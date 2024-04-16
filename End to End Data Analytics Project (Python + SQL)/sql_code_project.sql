select * from df_orders

-- find top 10 highest revenue generating products
select top 10 product_id, sum(sale_price) as sales 
from df_orders
group by product_id
order by sales desc

-- show the available regions
select distinct region from df_orders

-- find top 5 highest selling products in each region
select top 5 region,product_id,sum(sale_price) as sales
from df_orders
group by region,product_id
order by region,sales desc

-- find top 5 highest selling products in each region with cte
with cte as (
select region,product_id,sum(sale_price) as sales
from df_orders
group by region,product_id)
select *
,row_number() over (partition by region order by sales desc) as rn
from cte

-- find top 5 highest selling products in each region with cte
with cte as (
select region,product_id,sum(sale_price) as sales
from df_orders
group by region,product_id)
select * from (
select *
,row_number() over (partition by region order by sales desc) as rn
from cte) A
where rn<=5

-- find the years
select distinct year(order_date) from df_orders

-- find moth over month grothw comparison for 2022 and 2023 sales eg: jan 2022 vs jan 2023
with cte as (
select year(order_date) as order_year,month(order_date) as order_month,
sum(sale_price) as sales
from df_orders
group by year(order_date),month(order_date)
--order by year(order_date),month(order_date)
)
select order_month
,sum(case when order_year=2022 then sales else 0 end) as sales_2022
,sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte
group by order_month
order by order_month

-- show the distinct category
select distinct(category) from df_orders

-- for each category which motnh had highest sales 
with cte as (
select category, format(order_Date,'yyyyMM') as order_year_month
, sum(sale_price) as sales
from df_orders
group by category, format(order_date,'yyyyMM')
--order by category, format(order_Date,'yyyyMM')
)
select * from (
select *, 
row_number() over(partition by category order by sales desc) as rn
from cte
) a
where rn=1

-- show the distinct sub-category
select distinct(sub_category) from df_orders

-- which sub category had highest growth by profit in 2023 cómpare to 2022
with cte as (
select sub_category,year(order_date) as order_year,
sum(sale_price) as sales
from df_orders
group by sub_category,year(order_date)
--order by year(order_date),month(order_date)
)
, cte2 as (
select sub_category
,sum(case when order_year=2022 then sales else 0 end) as sales_2022
,sum(case when order_year=2023 then sales else 0 end) as sales_2023
from cte
group by sub_category
)
select top 1 *
,(sales_2023-sales_2022)*100/sales_2022 as growth
from cte2

