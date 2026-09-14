with events as (
    select * from {{ ref('stg_events') }}
),

songs as (
    select * from {{ ref('stg_songs') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['e.user_id', 'e.session_id', 'e.item_in_session']) }} as songplay_id,
    e.start_time,
    e.user_id,
    e.level,
    s.song_id,
    s.artist_id,
    e.session_id,
    e.location,
    e.user_agent
from events e
left join songs s
    on  lower(e.song_title)  = lower(s.title)
    and lower(e.artist_name) = lower(s.artist_name)
    and abs(e.song_length - s.duration) < 1