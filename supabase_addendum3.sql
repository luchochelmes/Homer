alter table orders add column if not exists phone text;
alter table orders add column if not exists address text;
alter table orders add column if not exists payment_method text;
alter table orders add column if not exists notes text;
delete from orders;
