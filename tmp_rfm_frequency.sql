insert into tmp_rfm_frequency 
with frequency as
(select id, 
case when count(order_id) is null then 0 else
count(order_id) end as count_orders from
users left join 
(select * from orders where status = 4) as orders_closed
on users.id=orders_closed.user_id
group by id
order by id)
select id, 
case 
when 
row_number() over(order by count_orders)*1.0/
(select count(*) from frequency)<=0.2
then 1
when 
row_number() over(order by count_orders)*1.0/
(select count(*) from frequency)<=0.4
then 2
when 
row_number() over(order by count_orders)*1.0/
(select count(*) from frequency)<=0.6
then 3
when 
row_number() over(order by count_orders)*1.0/
(select count(*) from frequency)<=0.8
then 4
when 
row_number() over(order by count_orders)*1.0/
(select count(*) from frequency)<=1
then 5
else 0
end as group
from frequency
order by count_orders;
