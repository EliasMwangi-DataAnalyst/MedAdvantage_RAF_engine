with pharma_claims as(
    SELECT * 
    FROM {{ref('stg_pharmacy_claims')}}
),

validated as (
    SELECT
        rx_claim_id,
        member_id,
        fill_date,
        ndc_code,
        days_supply,
        ingredient_cost
    FROM pharma_claims
    WHERE 
        rx_claim_id is not null 
        and member_id is not null 
        and fill_date is not null 
)

SELECT * 
FROM validated