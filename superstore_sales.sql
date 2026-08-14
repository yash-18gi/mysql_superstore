create database major_pro;
use major_pro;
select * from superstore;

-- SELECT, WHERE, ORDER BY
select * from superstore
order by sales desc
limit 10;

select * from superstore
where profit <0;

SELECT *
FROM superstore
WHERE discount >= 0.30;

select * from superstore
where region="West"
order by sales desc
limit 10;

-- Aggregate Functions
select round(sum(sales),2) as total_sales from  superstore;

select round(sum(profit),2) as total_profit from  superstore;

select round(sum(quantity),2) as total_quantity from  superstore;

select round(avg(discount),2) as avg_discount from  superstore;

SELECT 
    round(SUM(sales) / COUNT(DISTINCT order_id),2) AS avg_order_value
FROM
    superstore;

select count(distinct customer_name) as unique_customer from superstore;

select max(profit) as highest_profit,
       min(profit) as lowest_profit
       from superstore;

-- ROUP BY + HAVING
SELECT 
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS Total_profit
FROM
    superstore
GROUP BY category
ORDER BY total_sales desc;

SELECT 
    sub_category,
    MAX(profit) AS max_profit,
    MIN(profit) AS min_profit
FROM
    superstore
GROUP BY sub_category
ORDER BY max_profit desc;

select customer_name,  round(sum(sales),2) as total_sales from superstore
where sales >5000
group by Customer_name;

select region, round(sum(sales),2) as Total_sales from superstore
group by region
order by total_sales desc;


select sub_category, round(sum(profit),2) as total_profit from superstore
where profit <0
group by sub_category;

-- CASE WHEN
select order_id,customer_name,sales,
case 
when sales >15000 then "high_sales"
when sales >8000 then "medium_sales"
else "low_sales"
end as sales_parameter
from superstore;


select order_id,profit,
case 
when profit >0 then "profitable"
when profit <0 then "loss_making"
end as profit_behaviour
from superstore;

select 
case 
when discount < 0.10 then "Low_profit"
when discount <0.30 then "medium_profit"
else "High_profit"
end discount_category,
SUM(Profit) AS total_profit
from superstore
GROUP BY discount_category
ORDER BY total_profit DESC;

-- Date Functions
select year(order_date) as years, round(sum(sales),2) as total_sales, round(sum(profit),2) as Total_profit from superstore
group by years
order by years,total_sales desc;

select month(order_date) as months, round(sum(sales),2) as Total_sales  from superstore
group by months
order by total_sales desc
limit 1;

select  round(avg(datediff(ship_date,order_date)),2) as  avg_date_diff from superstore;

select order_id, datediff(ship_date,order_date) as date_diff from superstore
where  datediff(ship_date,order_date) > 5;

-- Subqueries

SELECT order_id, customer_name, sales
FROM superstore
WHERE sales > (SELECT ROUND(AVG(sales), 2) AS avg_sales
FROM superstore);


SELECT customer_name, 
       ROUND(SUM(sales)) AS Total_sales
FROM superstore
GROUP BY customer_name
HAVING ROUND(SUM(sales)) >(
select avg(Total_sales) from(
select customer_name, round(sum(sales)) as Total_sales
from superstore
group  by customer_name
)  avg_sales
);

select category,sum(sales) as Total_sales
from superstore
group by category
having sum(profit) > (
select avg(Total_profit)
from(
select category,sum(profit) as  Total_profit
from superstore
group by category
) as avg_profit );




