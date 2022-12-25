drop table if exists analysis.dm_rfm_segments;
create table analysis.dm_rfm_segments (
  user_id bigint not null primary key,
  recency bigint not null check(recency>=1 and recency<=5),
  frequency bigint not null check(frequency>=1 and frequency<=5),
  monetary_value bigint not null check(monetary_value>=1 and monetary_value<=5)
);