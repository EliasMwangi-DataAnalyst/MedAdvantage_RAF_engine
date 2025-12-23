with source as(
    SELECT *
    FROM {{source('postgres', 'pharmacy_claims')}}
),

renamed as(
    SELECT
        cast(rx_claim_id as int)                    as rx_claim_id,
        cast(members_id as int)                      as member_id,

        cast(fill_date as date)                     as fill_date,

        nullif(trim(ndc_code), '')                  as ndc_code,

        cast(days_supply as int)                    as days_supply,

        cast(ingredient_cost as numeric(10,2))      as ingredient_cost

    FROM source
)

SELECT *
FROM renamed

