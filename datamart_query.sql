insert into dm_rfm_segments
select tmp_rfm_recency.user_id, recency, frequency, monetary_value from 
tmp_rfm_recency join tmp_rfm_frequency on 
tmp_rfm_recency.user_id=tmp_rfm_frequency.user_id
join tmp_rfm_monetary_value on
tmp_rfm_recency.user_id=tmp_rfm_monetary_value.user_id
order by user_id;

0	1	3	4
1	4	3	3
2	2	3	5
3	2	3	3
4	4	3	3
5	5	5	5
6	1	3	5
7	4	2	2
8	1	1	3
9	1	3	2
10	3	5	2