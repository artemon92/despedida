-- Configuración de Supabase para el Organizador de la Despedida.
-- Pégalo entero en Supabase → SQL Editor → New query → Run. Se puede ejecutar más de una vez.

-- 1. Tabla donde se guarda todo (asistentes, mesas y gastos) en una sola fila.
create table if not exists public.evento (
  id          text primary key,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

alter table public.evento enable row level security;

-- Solo las personas con sesión iniciada pueden leer y escribir.
-- Como el registro público estará desactivado, solo entra quien des de alta tú.
drop policy if exists "evento_leer" on public.evento;
drop policy if exists "evento_crear" on public.evento;
drop policy if exists "evento_modificar" on public.evento;
create policy "evento_leer"      on public.evento for select to authenticated using (true);
create policy "evento_crear"     on public.evento for insert to authenticated with check (true);
create policy "evento_modificar" on public.evento for update to authenticated using (true) with check (true);

-- 2. Carpeta privada para los tickets (fotos y PDF, máximo 20 MB cada uno).
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('tickets', 'tickets', false, 20971520,
        array['image/jpeg','image/png','image/webp','image/heic','image/heif','image/gif','application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "tickets_leer" on storage.objects;
drop policy if exists "tickets_subir" on storage.objects;
drop policy if exists "tickets_borrar" on storage.objects;
create policy "tickets_leer"   on storage.objects for select to authenticated using (bucket_id = 'tickets');
create policy "tickets_subir"  on storage.objects for insert to authenticated with check (bucket_id = 'tickets');
create policy "tickets_borrar" on storage.objects for delete to authenticated using (bucket_id = 'tickets');
