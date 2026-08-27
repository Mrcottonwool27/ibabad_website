-- Run this once in your Supabase project's SQL Editor (Supabase dashboard → SQL Editor → New query)

create table if not exists app_state (
  id int primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Row Level Security: required, otherwise Supabase blocks all access by default.
alter table app_state enable row level security;

-- These policies allow anyone with your project's public "anon" key to read and write.
-- That key is not secret (it ships inside your deployed website's JS bundle), so this table
-- is only as protected as your app's own password gate — see the security note in README.md.
create policy "Allow anon read" on app_state
  for select using (true);

create policy "Allow anon insert" on app_state
  for insert with check (true);

create policy "Allow anon update" on app_state
  for update using (true) with check (true);
