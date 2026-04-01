with dup_query as (
    select *,
    row_number() over (partition by id order by updateDate desc) as row_num
    from {{ source('ecommerce_source','item') }}
)

select id, name, category, updateDate
from dup_query
where row_num = 1