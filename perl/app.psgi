#!/bin/perl
# vim: set expandtab ts=2 sw=2 nowrap ft=perl ff=unix : */

use strict;
use warnings;
use utf8;

use File::Spec;
use File::Basename qw(dirname);
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use local::lib File::Spec->catdir(dirname(__FILE__), 'extlib');

use DBI;
use YAML::XS;
use SQL::Maker;
use Amon2::Lite;

our $CONFIG = YAML::XS::LoadFile('../config.yaml');
our $DB_CONFIG = $CONFIG->{database};
sub config {
  my $c = shift;
  +{
    DBI => [
      'dbi:mysql:db=' . $DB_CONFIG->{database} . ':' . $DB_CONFIG->{host} . ':' . $DB_CONFIG->{port},
      $DB_CONFIG->{username},
      $DB_CONFIG->{password},
      +{
        RaiseError => 1,
        AutoCommit => 0,
      }
    ],
  }
}

our $builder = SQL::Maker->new(
  driver => 'mysql',
);

sub result_response {
  my ($c, $text, $status_code) = @_;

  $c->render_json({});
}

get '/insert/:table' => sub {
  my ($c, $args) = @_;

  my $table = $args->{table};
  my $name  = $c->req->param('name');

  my $affected_rows;
  my %value;

  $value{'name'} = $name if $name;

  if (%value) {
    my ($sql, @binds) = $builder->insert($table, \%value);
    my $guard = $c->dbh->txn_scope;
    {
      my $sth = $c->dbh->prepare($sql);
      $affected_rows = $sth->execute(@binds);
      $guard->commit;
    }
  }

  result_response($c, 'INSERT', $affected_rows);
};

get '/select/:table' => sub {
  my ($c, $args) = @_;

  my $table    = $args->{table};
  my $columns  = $c->req->param('columns') || '*';
  my $order    = $c->req->param('order');
  my $offset   = $c->req->param('offset');
  my $limit    = $c->req->param('limit');

  my $user_q = $builder->new_select()
    ->add_select($columns)
    ->add_from($table);
  $user_q->add_order_by($order) if $order;
  $user_q->add_offset($offset) if $offset;
  $user_q->add_limit($limit) if $limit;

  my $sql = $user_q->as_sql();
  my $guard = $c->dbh->txn_scope;
  {
    my $sth = $c->dbh->prepare($sql);
    $sth->execute();
    my $is_number = $sth->{mysql_is_num};
    my $users = $sth->fetchall_arrayref();
    $guard->commit;

    # convert column values from numeric string to number.
    my @filtered_users;
    for my $user (@$users) {
      my $i = 0;
      my @filtered_user = map { $is_number->[$i++] ? ($_ + 0) : $_ } @$user;
      push(@filtered_users, \@filtered_user);
    }

    $c->render_json_time('OK', \@filtered_users);
  }
};

get '/update/:table' => sub {
  my ($c, $args) = @_;

  my $table = $args->{table};
  my $id    = $c->req->param('id');
  my $name  = $c->req->param('name');

  my $affected_rows;
  my (%where, %value);

  $where{'id'} = $id if $id;
  $value{'name'} = $name if $name;

  if (%where and %value) {
    my ($sql, @binds) = $builder->update($table, \%value, \%where);
    my $guard = $c->dbh->txn_scope;
    {
      my $sth = $c->dbh->prepare($sql);
      $affected_rows = $sth->execute(@binds);
      $guard->commit;
    }
  }

  result_response($c, 'UPDATE', $affected_rows);
};

get '/delete/:table' => sub {
  my ($c, $args) = @_;

  my $table = $args->{table};
  my $id    = $c->req->param('id');
  my $name  = $c->req->param('name');

  my $affected_rows;
  my %where;

  $where{'id'} = $id if $id;
  $where{'name'} = $name if $name;

  if (%where) {
    my ($sql, @binds) = $builder->delete($table, \%where);
    my $guard = $c->dbh->txn_scope;
    {
      my $sth = $c->dbh->prepare($sql);
      $affected_rows = $sth->execute(@binds);
      $guard->commit;
    }
  }

  result_response($c, 'DELETE', $affected_rows);
};

__PACKAGE__->load_plugins(qw/DBI Web::JSON Web::CSRFDefender Web::ResponseTime/);
__PACKAGE__->to_app(handle_static => 1);

__END__

=head1 NAME

ApiServer - ApiServer via HTTP

=head1 SYNOPSIS

  % plackup app.psgi

=head1 DESCRIPTION

ApiServer is an implementation of API server via HTTP.

=head1 AUTHOR

Tasuku SUENAGA a.k.a. gunyarakun E<lt>tasuku-s-github@titech.acE<gt>

See I<AUTHORS> file for the name of all the contributors.
