create schema if not exists raw;

create or replace table raw.taxis as (select * from './data/*.parquet');
