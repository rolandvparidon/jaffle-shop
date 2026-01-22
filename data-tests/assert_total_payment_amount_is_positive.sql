select
    order_id, 
    order_items_subtotal
from {{ ref('orders') }}
where order_items_subtotal <= 0