/*first part of homework*/
select round(sum(sales), 2)                               as total_sales,
       round(sum(profit), 2)                              as total_profit,
       round(sum(profit) / sum(sales), 4) * 100           as profit_ratio,
       round(sum(profit) / count(distinct order_id), 2)   as profit_per_order,
       round(sum(sales) / count(distinct customer_id), 2) as sales_per_customer,
       round(avg(discount), 4) * 100                      as avg_discount
from public.orders;

/*second part of homework (first itteration)*/
select date_part('year', order_date)  as year,
       date_part('month', order_date) as month,
       segment,
       round(sum(sales), 2)           as total_sales
from public.orders
group by year, month, segment
order by segment, year, month;

/*second part of homework (second itteration)*/
select date_part('month', order_date) as month,
       segment,
       round(sum(sales), 2)           as total_sales
from public.orders
group by month, segment
order by segment, month;

/*third part of homework (first itteration)*/
select date_part('year', order_date)  as year,
       date_part('month', order_date) as month,
       category,
       round(sum(sales), 2)           as total_sales
from public.orders
group by year, month, category
order by category, year, month;

/*third part of homework (second itteration)*/
select date_part('month', order_date) as month,
       category,
       round(sum(sales), 2)           as total_sales
from public.orders
group by month, category
order by category, month;

/*forth part of homework*/
select category,
       round(sum(sales), 2) as total_sales
from public.orders
group by category
order by category, total_sales desc

/*fifth part of homework*/
select customer_id,
       customer_name,
       round(sum(sales), 2)  as total_sales,
       round(sum(profit), 2) as total_profit
from public.orders
group by customer_id, customer_name
order by total_sales desc, total_profit desc

/*sixth part of homework*/
select a.customer_id,
       a.customer_name,
       a.total_sales,
       rank() over (order by a.total_sales desc)  as sales_rank,
       a.total_profit,
       rank() over (order by a.total_profit desc) as profit_rank
from (select customer_id,
             customer_name,
             round(sum(sales), 2)  as total_sales,
             round(sum(profit), 2) as total_profit
      from public.orders
      group by customer_id, customer_name
      order by total_sales desc, total_profit desc) as a

/*seventh part of homework*/
select a.region,
       a.total_sales,
       rank() over (order by a.total_sales desc) as sales_rank
from (select region,
             round(sum(sales), 2) as total_sales
      from public.orders
      group by region) as a

/*eigth part of homework*/
select b.percent_return, 100 - b.percent_return as percent_no_return
from (select round(sum(a.r_order) / sum(a.o_order), 4) * 100 as percent_return
      from (select (select count(distinct order_id) from public.returns) as r_order, count(distinct order_id) as o_order
            from public.orders
            group by r_order) as a) as b