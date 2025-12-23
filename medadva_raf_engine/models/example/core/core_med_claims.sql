with medical_claims as (
    SELECT *
    FROM {{ref('stg_med_claims')}}
),

validated as(
    select 
        claim_id,
        member_id,
        claim_date,
        icd10_code,
        amount,
        place_of_service,
        provider_code
    FROM medical_claims
    where 
        claim_id is not null
        and member_id is  not null 
        and claim_date is not null 
)

SELECT * 
FROM validated