alter table products add column if not exists "desc" text;
alter table products add column if not exists tag text;
alter table products add column if not exists sizes jsonb;
