{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema = target.schema %}

    {# seeds go in a global raw schema #}
    {% if node.resource_type == 'seed' %}
        {{ custom_schema_name | trim }}

    {# no custom schema — use default #}
    {% elif custom_schema_name is none %}
        {{ default_schema }}

    {# prod — clean schema name e.g. 'marketing' #}
    {% elif target.schema == 'Production' %}
        {{ custom_schema_name | trim }}

    {# dev — ignore custom schema, use default only #}
    {% else %}
        {{ default_schema }}

    {% endif %}

{% endmacro %}