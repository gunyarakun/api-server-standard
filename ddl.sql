-- vim: set expandtab ts=2 sw=2 nowrap ft=sql ff=unix :
DROP DATABASE IF EXISTS apiserver;
CREATE DATABASE apiserver DEFAULT CHARACTER SET utf8;
USE apiserver;
CREATE TABLE users (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name char(100) NOT NULL
);
