with

order_items as (

    select * from {{ ref('stg_jaffle_shop__order_items') }}

),

products as (

    select * from {{ ref('stg_jaffle_shop__products') }}

),

supplies as (

    select * from {{ ref('stg_jaffle_shop__supplies') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}
),

-- Transformation cte's

supplies_per_product as (

    select

    product_id,
    sum(supply_cost) as supply_cost

    from supplies
    group by 1

),

order_items_enriched as (

    select

    order_items.order_item_id,
    order_items.order_id,
    orders.ordered_at,
    products.product_id,
    products.product_price,
    products.is_food_item,
    products.is_drink_item,
    supplies_per_product.supply_cost

    from order_items
    left join products
        on order_items.product_id = products.product_id
    left join supplies_per_product
        on order_items.product_id = supplies_per_product.product_id
    left join orders
        on order_items.order_id = orders.order_id
)

select * from order_items_enriched