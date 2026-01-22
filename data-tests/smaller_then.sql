select 
    order_cost 
from {{ ref('orders') }} 
where order_cost <= 0.1