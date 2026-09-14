with source as (
    select * from {{ source('raw', 'raw_events') }}
)

select
    raw_data:userId::string                      as user_id,
    raw_data:firstName::string                   as first_name,
    raw_data:lastName::string                    as last_name,
    raw_data:gender::string                      as gender,
    raw_data:level::string                       as level,
    raw_data:song::string                        as song_title,
    raw_data:artist::string                      as artist_name,
    raw_data:length::float                       as song_length,
    raw_data:sessionId::int                      as session_id,
    raw_data:itemInSession::int                  as item_in_session,
    raw_data:location::string                    as location,
    raw_data:userAgent::string                   as user_agent,
    raw_data:ts::number                          as ts_epoch_ms,
    to_timestamp_ntz(raw_data:ts::number / 1000) as start_time
from source
where raw_data:page::string = 'NextSong'
  and nullif(trim(raw_data:userId::string), '') is not null