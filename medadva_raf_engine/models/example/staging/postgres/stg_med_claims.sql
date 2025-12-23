with source as(
    SELECT *
    FROM {{ source('postgres', 'medical_claims')}}
),

renamed as (
    SELECT
        cast(claim_id as int)                  as claim_id,

        cast(member_id as int)                 as member_id,

        cast(claim_date as date)                as claim_date,

        nullif(trim(icd10_code), '')            as icd10_code,

        amount ::numeric                        as amount,

        nullif(trim(place_of_service), '')      as place_of_service,

        nullif(trim(provider_id), '')           as provider_code
    FROM source
)

SELECT *
FROM renamed