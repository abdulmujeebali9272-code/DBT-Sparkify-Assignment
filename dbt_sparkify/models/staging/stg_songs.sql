with source as (
    select * from {{ source('raw', 'raw_songs') }}
)

select
    raw_data:song_id::string                            as song_id,
    raw_data:title::string                              as title,
    raw_data:artist_id::string                          as artist_id,
    raw_data:artist_name::string                        as artist_name,
    nullif(trim(raw_data:artist_location::string), '')  as artist_location,
    raw_data:artist_latitude::float                     as artist_latitude,
    raw_data:artist_longitude::float                    as artist_longitude,
    nullif(raw_data:year::int, 0)                       as year,
    raw_data:duration::float                            as duration
from source
where raw_data:song_id::string is not null