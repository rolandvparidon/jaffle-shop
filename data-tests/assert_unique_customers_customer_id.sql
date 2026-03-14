select
    customer_id,
    count(*) as row_count
from {{ ref('customers') }}
group by customer_id
having count(*) > 1