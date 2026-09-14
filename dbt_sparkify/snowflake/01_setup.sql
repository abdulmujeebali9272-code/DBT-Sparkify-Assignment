use role sysadmin;

create warehouse if not exists sparkify_wh
  warehouse_size = 'xsmall'
  auto_suspend = 60
  auto_resume = true
  initially_suspended = true;

create database if not exists sparkify;

use database sparkify;

create schema if not exists raw;
create schema if not exists staging;
create schema if not exists marts;

show schemas in database sparkify;