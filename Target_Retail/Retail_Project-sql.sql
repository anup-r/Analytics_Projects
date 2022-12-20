show databases;

use sqlp;


-- Number of columns-- 
-- 1)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers' and table_schema='sqlp';
-- 2)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'geolocation' and table_schema='sqlp';
-- 3)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_items' and table_schema='sqlp';
-- 4)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_reviews' and table_schema='sqlp';
-- 5)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'orders' and table_schema='sqlp'; 
-- 6)
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'payments' and table_schema='sqlp'; 
-- 7) 
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'products' and table_schema='sqlp';
-- 8)  
SELECT COUNT(*) as no_of_col
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sellers' and table_schema='sqlp';





-- Number of rows
-- 1) 
select
count(*) as no_of_rows
from sqlp.customers;
-- 2) 
select
count(*) as no_of_rows
from sqlp.geolocation;
-- 3)
 select
count(*) as no_of_rows
from sqlp.order_items;
-- 4)
select
count(*) as no_of_rows
from sqlp.order_reviews;
-- 5)
select
count(*) as no_of_rows
from sqlp.orders; 
-- 6) 
select
count(*) as no_of_rows
from sqlp.payments;
-- 7) 
select
count(*) as no_of_rows
from sqlp.products;
-- 8) 
select
count(*) as no_of_rows
from sqlp.sellers;




-- Shape of Data: 
-- 1) There are '99441' rows and '5' columns in customers table
-- 2) There are '1000163' rows and '5' columns in geolocation table
-- 3) There are '112650' rows and '7' columns in order_items table
-- 4) There are '99224' rows and '6' columns in order_reviews table
-- 5) There are '99441' rows and '8' columns in orders table
-- 6) There are '103886' rows and '5' columns in payments table
-- 7) There are '32951' rows and '9' columns in products table
-- 8) There are '3095' rows and '4' columns in sellers table


-- 'Characterstics of Dataset'
-- Table-Customers-- 
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customers' and table_schema='sqlp';

-- Table-Geolocation--
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'geolocation' and table_schema='sqlp';

-- Table-Order_Items--
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'order_items' and table_schema='sqlp';

-- Table - Order_reviews
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'order_reviews' and table_schema='sqlp';

-- Table - Orders
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders' and table_schema='sqlp';

-- Table - Payments
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'order_reviews' and table_schema='sqlp';

-- Table - Products
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'products' and table_schema='sqlp';

-- Table - Sellers
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sellers' and table_schema='sqlp';

-- Cities and State covered in DataSET
SELECT 
distinct customer_city
from customers;

select
distinct customer_state
from customers;

-- Time Period of Data 
select min(order_purchase_timestamp) as MinTime ,max(order_purchase_timestamp) as MaxTime
from orders;
-- Time Frame of the data is in between 2016 to 2018

select 
order_purchase_timestamp
from orders;


-- Extract day(numerical_form) from order_purchase 
select
extract(day from order_purchase_timestamp)
from orders;

-- Extract Day name 
-- Number of Orders Each Day 
select
dayname(order_purchase_timestamp) as dn,count(dayname(order_purchase_timestamp))
from orders
group by dn
order by count(dn) desc ;
-- People order the most on Monday and least on Saturday.
-- Number of order from Monday to Friday decreases gradually and then dramatically drop on Saturday. 



-- Extract only time from timestamp 
select
time(order_purchase_timestamp) as order_time
from orders;



with new_t as (
select
case
when time(order_purchase_timestamp) between '5:30:00' and '6:29:00' then 'Dawn'
when time(order_purchase_timestamp) between '6:30:00' and '11:59:00' then 'Morning'
when time(order_purchase_timestamp) between '12:00:00' and '17:59:00' then 'Afternoon'
when time(order_purchase_timestamp) between '18:00:00' and '23:59:00' then 'Night'
else 'midnight'
end as 'time_of_day'
from orders)
select time_of_day,count(time_of_day) as orders_by_time
from new_t
group by time_of_day
order by count(time_of_day) desc;



-- Checking each time slot 
select 
time(order_purchase_timestamp) as order_time
from orders
where time(order_purchase_timestamp) between '5:30:00' and '6:29:00';

select 
*
from orders
where time(order_purchase_timestamp) between '6:30:00' and '11:59:00';

select 
*
from orders
where time(order_purchase_timestamp) between '12:00:00' and '17:59:00';

select 
*
from orders
where time(order_purchase_timestamp) between '18:00:00' and '23:59:00';



-- Trend of E-Commerce with respect to sales:
select
o.order_id,cast(o.order_purchase_timestamp as date) as Dateonly,oi.price,oi.freight_value
from orders o join order_items oi on o.order_id=oi.`order_id"`;



-- Total Sales by months:

-- Lowest sales acc to year /month 
select
cast(o.order_purchase_timestamp as date) as Dateonly,
round(sum(price)+sum(freight_value),2) as total_sales
from orders o join order_items oi on o.order_id=oi.`order_id"`
group by year(o.order_purchase_timestamp),month(o.order_purchase_timestamp)
order by cast(o.order_purchase_timestamp as date) asc,round(sum(price)+sum(freight_value),2) asc ;
-- Lowest sales on 2016-09 and 2016-12


 -- Highest Total Sales
select
cast(o.order_purchase_timestamp as date) as Dateonly,
round(sum(price)+sum(freight_value),2) as total_sales
from orders o join order_items oi on o.order_id=oi.`order_id"`
group by year(o.order_purchase_timestamp),month(o.order_purchase_timestamp)
order by round(sum(price)+sum(freight_value),2) desc
limit 5;
-- Highest sales are on 2017-November and 2018-April

-- Evolution of E-commerce orders in the Brazil region
-- Customer Distribution acc to state
select
c.customer_city,c.customer_state,count(o.order_id) as no_of_orders
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_state
order by count(o.order_id) desc;

-- Customer Distribution acc to city
select
c.customer_city,count(o.order_id) as no_of_orders
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_city
order by count(o.order_id) desc;


-- Impact on Economy 
-- Percentage Change in Price
with newt as (
select 
year(o.order_purchase_timestamp) as year,round(sum(price)+sum(freight_value),3) as total_cost
from order_items oi join orders o on oi.`order_id"`=o.order_id
where month(o.order_purchase_timestamp)>1 and month(o.order_purchase_timestamp)<8
group by year(o.order_purchase_timestamp))
select n1.year,n1.total_cost,
round(((n2.total_cost-n1.total_cost)/n1.total_cost)*100,2) as pchange
from newt n1 left join newt n2 on n1.year+1=n2.year;

--  Mean & Sum of price and freight value by customer state:
select
c.customer_state,round(avg(oi.price),2) as mean_price,round(avg(oi.freight_value),2) as avg_freight,
round((oi.price)+sum(oi.freight_value),2) as total_value
from order_items oi join orders o on oi.`order_id"`=o.order_id
join customers c on c.customer_id=o.customer_id
group by c.customer_state;


 -- Days between purchasing, delivering and estimated delivery
select
cast(order_purchase_timestamp as date) as order_purchase,cast(order_delivered_customer_date as date) as order_delivered,
cast(order_estimated_delivery_date as date) as order_estimated_delivery,
datediff(order_delivered_customer_date,order_purchase_timestamp) as time_to_delivery,
datediff(order_estimated_delivery_date,order_delivered_customer_date) as diff_estimated_delivery 
from orders;

select 
c.customer_state,
round(avg(oi.freight_value),2) as mean_freightv,
datediff(order_delivered_customer_date,order_purchase_timestamp) as time_to_delivery,
datediff(order_estimated_delivery_date,order_delivered_customer_date) as diff_estimated_delivery 
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id= oi.`order_id"`
group by c.customer_state;


-- Sort acc to freight_values
-- Top 5 states with least average freight_value 
select 
c.customer_state,
round(avg(oi.freight_value),2) as mean_freightv,
datediff(order_delivered_customer_date,order_purchase_timestamp) as time_to_delivery,
datediff(order_estimated_delivery_date,order_delivered_customer_date) as diff_estimated_delivery 
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id= oi.`order_id"`
group by c.customer_state
order by round(avg(oi.freight_value),2) asc limit 5;
-- SP,PR,MG,RJ,DF are the states with least avg freight value


-- Top 5 states with highest average freight_value
select 
c.customer_state,
round(avg(oi.freight_value),2) as mean_freightv
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id= oi.`order_id"`
group by c.customer_state
order by round(avg(oi.freight_value),2) desc limit 5;
-- RR,PB,RO are the states with highest avg freight value


-- Top 5 states with highest/lowest average time to delivery
-- Highest Average 
select 
c.customer_state,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) as avg_time_to_delivery
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_state
order by round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) desc limit 5;
-- RR,AP,AM,AL,PA are states with highest avg time_to_delivery

-- Lowest Average
select 
c.customer_state,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) as avg_time_to_delivery
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_state
order by round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) asc limit 5; 
-- SP,PR,MG,DF,SC are the states which have the least avg_time_to_delivery


-- Top 5 states where delivery is really fast/ not so fast compared to estimated date

-- Really fast delivery  
select
c.customer_state,
datediff(order_delivered_customer_date,order_purchase_timestamp) as time_to_delivery,
datediff(order_estimated_delivery_date,order_delivered_customer_date) as diff_estimated_delivery 
from customers c join orders o on c.customer_id=o.customer_id
where datediff(order_delivered_customer_date,order_purchase_timestamp) < datediff(order_estimated_delivery_date,order_delivered_customer_date)
group by c.customer_state
order by datediff(order_delivered_customer_date,order_purchase_timestamp) asc limit 5;
-- RS,MG,SP,RJ,PB are states with least time_to_delivery

-- Not so Fast  
select
c.customer_state,
datediff(order_delivered_customer_date,order_purchase_timestamp) as time_to_delivery,
datediff(order_estimated_delivery_date,order_delivered_customer_date) as diff_estimated_delivery 
from customers c join orders o on c.customer_id=o.customer_id
where datediff(order_delivered_customer_date,order_purchase_timestamp) > datediff(order_estimated_delivery_date,order_delivered_customer_date)
group by c.customer_state
order by datediff(order_delivered_customer_date,order_purchase_timestamp) desc limit 5;
-- PA,PB,MA,AM,AL are the states with time_to_delivery being not so fast

-- Payment Analysis:
select 
payment_type,count(order_id)
from payments
group by payment_type ;
-- Credit card is the most used payment type


-- Distribution of payment installments and count of orders
select 
payment_installments,count(payment_installments) as payment_count
from payments
group by payment_installments
order by payment_count desc; 

-- people who pay for the product in 1 and 2 installments are the most 

 
