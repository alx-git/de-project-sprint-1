create or replace view analysis.Orders as
with orderstatuslog_max as (
select id, orderstatuslog.order_id, status_id, dttm 
from orderstatuslog left join 
(select order_id, max(dttm) from orderstatuslog
group by order_id) as max_date on
orderstatuslog.order_id=max_date.order_id
where dttm=max)
select orders.order_id, order_ts, user_id, bonus_payment, payment,
cost, bonus_grant, status_id as status
from production.orders left join orderstatuslog_max on
orders.order_id=orderstatuslog_max.order_id;