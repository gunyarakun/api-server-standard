# vim: set expandtab ts=2 sw=2 nowrap ft=perl ff=unix : */
package Amon2::Plugin::Web::ResponseTime;

use strict;
use warnings;
use Amon2::Util;
use Time::HiRes;

sub init {
  my ($class, $c) = @_;
  Amon2::Util::add_method($c, save_start_time => sub {
    my $self  = shift;
    $self->{start_time} = Time::HiRes::time;
  });
  Amon2::Util::add_method($c, render_json_time => sub {
    my ($self, $status, $body) = @_;

    my $time;
    if ($self->{start_time}) {
      my $end_time = Time::HiRes::time;
      $time = $end_time - $self->{start_time};
    }
    $self->render_json(+{
      status => $status,
      time => $time,
      body => $body,
    });
  });
  $c->add_trigger(BEFORE_DISPATCH => sub {
    my ($self, $res) = @_;
    $self->save_start_time();
  });
}

1;
