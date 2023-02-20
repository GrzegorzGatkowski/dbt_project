{{ config(materialized='view') }}

SELECT 
    -- identifiers
    {{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    dispatching_base_num,
    cast(PUlocationID as integer) as  pickup_locationid,
    Affiliated_base_number,
    cast(DOlocationID as integer) as dropoff_locationid,
    SR_Flag,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    
    
FROM {{source('staging','fhv') }}

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}