{{
    config(
        materialized = 'incremental',
        unique_key = 'order_id',
        incremental_strategy = 'merge',
        on_schema_change = 'fail'
        
    )
}}

with

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

    {% if is_incremental() %}
        -- this filter will only be applied on an incremental run
        where ordered_at > (select max(ordered_at) from {{ this }}) 
    {% endif %}

),

order_items as (

    select * from {{ ref('int_order_items__pivoted') }}

),

compute_booleans as (

    select

        orders.*,
        order_items.order_cost,
        order_items.order_items_subtotal,
        order_items.count_food_items,
        order_items.count_drink_items,
        order_items.count_order_items,
        order_items.count_food_items > 0 as is_food_order,
        order_items.count_drink_items > 0 as is_drink_order

    from orders

    left join
        order_items
        on orders.order_id = order_items.order_id

),

customer_order_count as (

    select

        *,
        row_number() over (
            partition by customer_id
            order by ordered_at asc
        ) as customer_order_number

    from compute_booleans

)

select * from customer_order_count
