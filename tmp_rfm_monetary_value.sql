insert into tmp_rfm_monetary_value 
with monetary_value as
(select id, 
case when sum(payment) is null then 0 else
sum(payment) end as payment from
users left join 
(select * from orders where status = 4) as orders_closed
on users.id=orders_closed.user_id
group by id
order by id)
select id, 
case 
when 
row_number() over(order by payment)*1.0/
(select count(*) from monetary_value)<=0.2
then 1
when 
row_number() over(order by payment)*1.0/
(select count(*) from monetary_value)<=0.4
then 2
when 
row_number() over(order by payment)*1.0/
(select count(*) from monetary_value)<=0.6
then 3
when 
row_number() over(order by payment)*1.0/
(select count(*) from monetary_value)<=0.8
then 4
when 
row_number() over(order by payment)*1.0/
(select count(*) from monetary_value)<=1
then 5
else 0
end as group
from monetary_value
order by payment;