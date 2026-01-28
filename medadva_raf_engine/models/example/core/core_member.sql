with members as(
    SELECT *
    from {{ ref('stg_members')}}
),

filtered as (
    SELECT
        member_id,
        first_name,
        last_name,
        date_of_birth,
        gender,
        plan_id,
        enrollment_start,
        enrollment_end,
        city,
        us_state
    FROM members
    WHERE member_id is not null 
)

select *
FROM filtered