
{% set old_relation = ref('orders_deprecated') -%}

{% set dbt_relation = ref('orders') %}

{{ audit_helper.quick_are_relations_identical(
    a_relation = old_relation,
    b_relation = dbt_relation,
    columns = None
) }}
