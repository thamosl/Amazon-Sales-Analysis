create database amazon_analysis;
use amazon_analysis;
show tables;
select * from sales;

-- 1. Sales of the T-shirt based on size

select size , 
sum(amount) as Total_Sales
from sales where status = 'Shipped - Delivered to Buyer'
group by size;


-- 2. count of the Returned Products based on category

select category,
count(order_id)
from sales where status = 'Shipped - Returned to Seller' group by category;

-- 3. Count of Orders based on status
select 
status , count(status) as Total_Orders
from sales group by status;

-- 4. count of orders based on Courier Status
select courier_status,
count(courier_status) from sales group by courier_status;

-- 5. Percentage of orders based on the Status
select 
status,
count(*) as Total_Count,
Round(100*count(*)/(select count(*) from sales),2) as Percentage
from sales where status in ('Shipped - Delivered to Buyer','Shipped - Returned to Seller','Shipped')
group by status;

-- 6. Sales based on Month
SELECT 
    DATE_FORMAT(order_date, '%m-%y') AS Month,
    SUM(amount) AS Monthly_Revenue
FROM sales
GROUP BY DATE_FORMAT(order_date, '%m-%y')
ORDER BY Month;


-- 7. Top 5 cities by revenue
select ship_city,
sum(amount) as Total_Revenue 
from sales 
group by ship_city  
order by Total_Revenue desc 
limit 5;

-- 8. Revenue Split by Sales Channel

select fulfilment,
sum(amount) as Total_Sales
from sales group  by fulfilment;

-- 9. count of Orders by courier status

select courier_status,
count(order_id) as Total_Orders
from sales
group by courier_status;

-- 10. Orders are on the way and marked as Cancelled

select * from sales
where status in('On the way' ,'Cancelled');

-- 11. Percentage of orders delivered vs cancelled

select status,
count(*) as Total_orders,
Round(100*count(*)/(select count(*) from sales),2) as Percentage
from sales where status in ('Shipped - Delivered to Buyer','Shipped - Returned to Seller')
group by status;


-- 12. Top 10 cities with high number of Order

select ship_city,
count(*) as Total_Orders
from sales group by ship_city 
order by Total_orders desc limit 10;

-- 13. Revenue by State

select ship_state,
sum(amount) as Total_Revenue
from sales 
group by ship_state;

-- 14. Which state has Highest Cancellation

select ship_state,
count(order_id) as Orders
from sales where courier_status not in ('Shipped')
group by ship_state 
order by Orders desc limit 1;

-- 15. Average Order value per city

select ship_city,
avg(amount) as Average_Revenue
from sales group by ship_city
order by Average_Revenue desc;

-- 16 Count of B2B and Non B2B Oorders

select 
b2b , count(order_id) as Total_Orders
from sales group by b2b;

-- 17. Most Sold Category
select category,
count(order_id) as Order_Count
from sales 
where status not in('Shipped - Returned to Seller')
group by category
order by Order_Count desc;

-- 18. Category Wise cancellation  Rate / Which Category has Highest Cancellation Rate
select category,
count(order_id) as Total_Orders
from sales where status in ('Shipped - Returned to Seller')
group by category 
order by Total_Orders desc;


-- 19 Rank Cities based on Revenue
SELECT 
    ship_city,
    SUM(amount) AS Total_Revenue,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS Revenue_Rank
FROM sales
GROUP BY ship_city
ORDER BY Revenue_Rank;

-- 20. Top 3 Categories based on Revenue
select category,
sum(amount) as Total_Revenue,
rank() over(order by sum(amount) desc) as Revenue_Rank
from sales
group by category
order by Revenue_Rank limit 3;


-- 21. Running total of Revenue by Date	
select 
order_date,
sum(amount) as daily_Revenue,
sum(sum(amount)) over(order by order_date) as running_total_revenue
from sales 
group by order_date
order by order_date;

