-- Fotos de producto reales (reemplaza el placeholder que no se guardaba)
alter table products add column if not exists image_url text;

insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do update set public = true;

drop policy if exists "product-images public read" on storage.objects;
create policy "product-images public read"
  on storage.objects for select
  using (bucket_id = 'product-images');

drop policy if exists "product-images anon upload" on storage.objects;
create policy "product-images anon upload"
  on storage.objects for insert
  with check (bucket_id = 'product-images');

drop policy if exists "product-images anon update" on storage.objects;
create policy "product-images anon update"
  on storage.objects for update
  using (bucket_id = 'product-images');
