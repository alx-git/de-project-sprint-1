insert into tmp_rfm_recency 
with recency as
(select id, 
case when max(order_ts) is null then to_timestamp(0) else
max(order_ts) end as max_date from
users left join 
(select * from orders where status = 4) as orders_closed
on users.id=orders_closed.user_id
group by id
order by id)
select id, 
case 
when 
row_number() over(order by max_date)*1.0/
(select count(*) from recency)<=0.2
then 1
when 
row_number() over(order by max_date)*1.0/
(select count(*) from recency)<=0.4
then 2
when 
row_number() over(order by max_date)*1.0/
(select count(*) from recency)<=0.6
then 3
when 
row_number() over(order by max_date)*1.0/
(select count(*) from recency)<=0.8
then 4
when 
row_number() over(order by max_date)*1.0/
(select count(*) from recency)<=1
then 5
else 0
end as group
from recency
order by max_date;