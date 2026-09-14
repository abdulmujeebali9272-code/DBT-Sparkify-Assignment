use role sysadmin;
use database sparkify;
use schema raw;
use warehouse sparkify_wh;

create or replace table raw_songs (
  raw_data    variant,
  source_file string,
  loaded_at   timestamp_ntz default current_timestamp()
);

create or replace table raw_events (
  raw_data    variant,
  source_file string,
  loaded_at   timestamp_ntz default current_timestamp()
);

copy into raw_songs (raw_data, source_file)
from (
  select $1, metadata$filename
  from @sparkify.raw.s3_stage/song_data/
)
file_format = (type = json)
pattern = '.*[.]json'
on_error = 'abort_statement';

copy into raw_events (raw_data, source_file)
from (
  select $1, metadata$filename
  from @sparkify.raw.s3_stage/log_data/
)
file_format = (type = json)
pattern = '.*[.]json'
on_error = 'abort_statement';

select 'songs' as tbl, count(*) as row_count from raw_songs
union all
select 'events', count(*) from raw_events;cls
