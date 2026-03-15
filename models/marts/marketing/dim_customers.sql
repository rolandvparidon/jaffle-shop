with 

customers as (

    select

        customer_id,
        customer_name

     from {{ ref('stg_jaffle_shop__customers') }}

)

select * from customers