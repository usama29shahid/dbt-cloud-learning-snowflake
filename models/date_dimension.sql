{{ config(materialized='table') }}
WITH CTE AS (
    SELECT
        TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
        DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
        HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,
        CASE 
            WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat','Sun') THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END AS DAY_TYPE,
        {{ get_season_from_timestamp('TO_TIMESTAMP(STARTED_AT)') }} AS STATION_OF_YEAR
    FROM
        {{ ref('stg_bike') }}
    WHERE STARTED_AT != 'started_at' AND STARTED_AT != '"started_at"'
)
SELECT 
    *
FROM CTE