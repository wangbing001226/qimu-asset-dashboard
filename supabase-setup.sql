-- Run in Supabase SQL Editor for your project.
create table if not exists public.asset_state (
  user_id uuid primary key references auth.users (id) on delete cascade,
  revision bigint not null default 1,
  salt text not null,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.asset_state enable row level security;
revoke all on public.asset_state from anon, public;
grant select, insert, update on public.asset_state to authenticated;

drop policy if exists "Users can read their own encrypted asset state" on public.asset_state;
drop policy if exists "Users can insert their own encrypted asset state" on public.asset_state;
drop policy if exists "Users can update their own encrypted asset state" on public.asset_state;

create policy "Users can read their own encrypted asset state"
  on public.asset_state for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "Users can insert their own encrypted asset state"
  on public.asset_state for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "Users can update their own encrypted asset state"
  on public.asset_state for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
