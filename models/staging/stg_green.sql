{{ config(materialized='view') }}

select * from dezoomcamp.green limit 1
