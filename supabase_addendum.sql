alter table orders add column if not exists cat text not null default 'perro';
alter table zones add column if not exists from_price boolean not null default false;
