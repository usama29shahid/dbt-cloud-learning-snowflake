{% macro get_season_from_timestamp(timestamp_column) %}
    CASE 
        WHEN MONTH({{ timestamp_column }}) IN (12, 1, 2) THEN 'WINTER'
        WHEN MONTH({{ timestamp_column }}) IN (3, 4, 5) THEN 'SPRING'
        WHEN MONTH({{ timestamp_column }}) IN (6, 7, 8) THEN 'SUMMER'
        ELSE 'AUTUMN'
    END
{% endmacro %}