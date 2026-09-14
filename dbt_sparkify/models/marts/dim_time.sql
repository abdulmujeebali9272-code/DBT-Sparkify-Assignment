with distinct_times as (
    select distinct start_time
    from {{ ref('stg_events') }}
)

select
    start_time,
    hour(start_time)       as hour,
    day(start_time)        as day,
    weekofyear(start_time) as week,
    month(start_time)      as month,
    year(start_time)       as year,
    dayofweek(start_time)  as weekday
from distinct_times