{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema = target.schema %}

    {% if node.resource_type == 'seed' %}
        {{ custom_schema_name | trim }}

    {% elif target.schema == 'Production' %}
        {{ custom_schema_name | trim }}
    {% else %}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    {% endif %}

{% endmacro %}