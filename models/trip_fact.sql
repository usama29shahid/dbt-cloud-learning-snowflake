{{ config(materialized='table') }}
WITH TRIPS as (

select
RIDE_ID,
DATE(TO_TIMESTAMP(STARTED_AT)) AS TRIP_DATE,
START_STATIO_ID AS START_STATION_ID,
END_STATION_ID,
MEMBER_CSUAL AS MEMBER_CASUAL,
TIMESTAMPDIFF(SECOND,TO_TIMESTAMP(STARTED_AT),TO_TIMESTAMP(ENDED_AT)) AS TRIP_DURATION_SECONDS
from {{ ref('stg_bike') }}

where RIDE_ID != '"bikeid"' and RIDE_ID != 'bikeid' --and STARTED_AT <> 'started_at'

-- limit 100
)

select
*
from TRIPS