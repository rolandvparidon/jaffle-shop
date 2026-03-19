with

-- Import CTE's
order_items as (

    select * from {{ ref('stg_jaffle_shop__order_items') }}

),

products as (

    select * from {{ ref('stg_jaffle_shop__products') }}

),

supplies as (

    select * from {{ ref('stg_jaffle_shop__supplies') }}

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

        order_items.order_id,
        order_items.order_item_id,
        products.product_price,
        products.is_food_item,
        products.is_drink_item,
        supplies_per_product.supply_cost


    from order_items
    
    left join products as products
        on order_items.product_id = products.product_id
    left join supplies_per_product as supplies_per_product
        on order_items.product_id = supplies_per_product.product_id

),

order_items_pivoted as (

    select

        order_id,
        sum(supply_cost) as order_cost,
        sum(product_price) as order_items_subtotal,
        count(order_item_id) as count_order_items,
        sum(
            case
                when is_food_item then 1
                else 0
            end
        ) as count_food_items,
        sum(
            case
                when is_drink_item then 1
                else 0
            end
        ) as count_drink_items

    from order_items_enriched
    group by 1

)

select * from order_items_pivoted


