-- Homer — esquema inicial (reseñas, productos, zonas, pedidos)

create table if not exists reviews (
  id text primary key,
  name text not null,
  pet text not null default 'Cliente Homer',
  text text not null,
  approved boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists products (
  id text primary key,
  brand text not null,
  name text not null,
  cat text not null,
  price numeric not null default 0,
  old_price numeric,
  stock integer not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists zones (
  id text primary key,
  name text not null,
  price numeric not null default 0,
  eta text not null default '24 h',
  free boolean not null default false,
  note text not null default '',
  sort_order integer not null default 0
);

create table if not exists orders (
  id text primary key,
  customer_name text not null,
  items text not null,
  total numeric not null default 0,
  zone_name text,
  status text not null default 'pendiente',
  created_at timestamptz not null default now()
);

create table if not exists settings (
  key text primary key,
  value jsonb not null
);

-- RLS: habilitado, con acceso abierto de lectura/escritura vía la publishable key
-- (el backoffice todavía no tiene login propio, así que el nivel de protección
-- es el mismo que ya tenía hoy con localStorage + URL sin publicar)
alter table reviews enable row level security;
alter table products enable row level security;
alter table zones enable row level security;
alter table orders enable row level security;
alter table settings enable row level security;

create policy "public read/write reviews" on reviews for all using (true) with check (true);
create policy "public read/write products" on products for all using (true) with check (true);
create policy "public read/write zones" on zones for all using (true) with check (true);
create policy "public read/write orders" on orders for all using (true) with check (true);
create policy "public read/write settings" on settings for all using (true) with check (true);

-- Realtime: para que landing y backoffice se sincronicen al instante
alter publication supabase_realtime add table reviews, products, zones, orders, settings;
