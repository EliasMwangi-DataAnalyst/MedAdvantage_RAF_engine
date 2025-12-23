with source as (
    SELECT *
    FROM {{ source('postgres', 'members') }}
),

renamed as (
    SELECT
    -- convert empty strings to NULL
    -- add safe casting incase of different data types
        cast(nullif(trim(member_id), '') as int)    as member_id,

        nullif(trim(first_name), '' )               as first_name,
        nullif(trim(last_name), '')                 as last_name,

        cast(date_of_birth as date)                 as date_of_birth,

        upper(nullif(trim (gender), '')  )          as gender,
        
        cast(plan_id as int)                        as plan_code,
        
        cast(enrollment_start as date)              as enrollment_start,
        cast(enrollment_end as date)                as enrollment_end,
        
        nullif(trim(city), '')                      as city,
        nullif(trim(us_state), '' )                 as us_state
        
    FROM source
)

SELECT *
FROM renamed