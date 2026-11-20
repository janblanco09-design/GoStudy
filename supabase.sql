-- Ejecutar una sola vez en el editor SQL del proyecto Supabase.
-- Todas las filas están protegidas: cada usuario solo lee/escribe sus propios datos.
create table if not exists public.go_study_data (
  id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.go_study_data enable row level security;
create policy "Go Study: leer datos propios" on public.go_study_data
  for select to authenticated using ((select auth.uid()) = id);
create policy "Go Study: insertar datos propios" on public.go_study_data
  for insert to authenticated with check ((select auth.uid()) = id);
create policy "Go Study: actualizar datos propios" on public.go_study_data
  for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);
grant select, insert, update on public.go_study_data to authenticated;
