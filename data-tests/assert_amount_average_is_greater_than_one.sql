{{ 
    config(
        severity = "warn"
        ) 
}}

select
    customer_id, 
    avg(order_cost) as average_order_cost
from {{ ref('orders') }}
group by 1
having count(customer_id) > 1 and average_order_cost < 1