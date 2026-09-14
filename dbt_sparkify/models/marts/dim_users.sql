select
    user_id,
    first_name,
    last_name,
    gender,
    level
from {{ ref('stg_events') }}
qualify row_number() over (partition by user_id order by ts_epoch_ms desc) = 1