select
    song_id,
    title,
    artist_id,
    year,
    duration
from {{ ref('stg_songs') }}
qualify row_number() over (partition by song_id order by title) = 1