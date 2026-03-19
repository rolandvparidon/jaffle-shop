with

supplies as (

    select

        supply_uuid,
        supply_id,
        supply_name,
        supply_cost,
        is_perishable_supply

    from {{ ref('stg_jaffle_shop__supplies') }}

)

select * from supplies