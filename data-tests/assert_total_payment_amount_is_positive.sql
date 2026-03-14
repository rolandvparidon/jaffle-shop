{{ config(store_failures = true) }}

select
    *
from {{ ref('stg_payments') }}
where amount < 0