with bronze_sales as (
    select
        sales_id,
        product_sk,
        customer_sk,
        {{multiply('unit_price','quantity')}} as calculated_gross_amount,
        gross_amount,
        payment_method
    from {{ ref('bronze_sales') }}
),

bronze_products as (
    select
        product_sk,
        category
    from {{ ref('bronze_product') }}
), 

customer as (
    select 
        customer_sk,   
        gender
    from {{ ref('bronze_customer') }}
),

sales_info as (

select
    b.sales_id,
    b.product_sk,
    p.category,
    b.customer_sk,
    b.calculated_gross_amount,
    c.gender,
    b.gross_amount,
    b.payment_method
from bronze_sales b
left join bronze_products p
    on b.product_sk = p.product_sk
left join customer c
    on b.customer_sk = c.customer_sk
)

select category, gender, sum(calculated_gross_amount) as total_calculated_gross_amount
from sales_info
group by category, gender
order by total_calculated_gross_amount