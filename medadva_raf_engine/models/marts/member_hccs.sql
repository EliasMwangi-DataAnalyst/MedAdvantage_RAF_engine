{{ config(materialized='table')}}

select 
    m.member_id,
    m.plan_id,
    current_date as snapshot_date
from {{ ref('core_member')}} m 