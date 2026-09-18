-- Reffime database schema
create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  category text not null,
  description text not null default '',
  price numeric(10,2) not null default 0,
  compare_price numeric(10,2),
  badge text,
  image_url text,
  featured boolean not null default false,
  visible boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.site_settings (
  id integer primary key default 1 check (id = 1),
  brand_name text not null default 'Reffime',
  hero_title text not null default 'Wear your|presence.',
  hero_text text not null default 'Modern fragrance, made personal.',
  hero_image_url text,
  whatsapp_number text not null default '2349073924215',
  updated_at timestamptz not null default now()
);

insert into public.site_settings (id) values (1) on conflict (id) do nothing;

alter table public.products enable row level security;
alter table public.site_settings enable row level security;

create policy "Public can read visible products" on public.products for select using (visible = true);
create policy "Public can read site settings" on public.site_settings for select using (true);

-- Admin write policies should be replaced with authenticated role policies after Supabase Auth is enabled.
create policy "Authenticated admins manage products" on public.products for all to authenticated using (true) with check (true);
create policy "Authenticated admins manage settings" on public.site_settings for all to authenticated using (true) with check (true);

insert into public.products (slug,name,category,description,price,badge,featured,sort_order)
values
 ('muse-01','Muse 01','Skin scents','Pear skin · sheer musk · warm cedar',68,'Bestseller',true,1),
 ('afterglow','Afterglow','Night rituals','Saffron · amber woods · vanilla',82,'Sale',true,2),
 ('still-02','Still / 02','Skin scents','White tea · iris · cashmere',64,'New',true,3),
 ('signal','Signal','Statement scents','Pink pepper · rose · smoked suede',76,null,false,4)
on conflict (slug) do nothing;

-- Run this after creating a private storage bucket named product-images.
create policy "Authenticated admins upload product images" on storage.objects for insert to authenticated with check (bucket_id = 'product-images');
create policy "Authenticated admins update product images" on storage.objects for update to authenticated using (bucket_id = 'product-images') with check (bucket_id = 'product-images');
create policy "Authenticated admins delete product images" on storage.objects for delete to authenticated using (bucket_id = 'product-images');
