select
    artist_id,
    artist_name      as name,
    artist_location  as location,
    artist_latitude  as latitude,
    artist_longitude as longitude
from {{ ref('stg_songs') }}
where artist_id is not null
qualify row_number() over (partition by artist_id order by artist_name) = 1