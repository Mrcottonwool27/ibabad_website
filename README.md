# IBABAD

Badminton club matchmaking, scoring, and finance app — now syncs across devices via Supabase.

## 1. Set up Supabase (one-time)

1. Go to [supabase.com](https://supabase.com) → sign up → **New project**.
2. Once it's created, open **SQL Editor** → **New query**, paste the contents of
   `supabase_schema.sql` (in this folder), and run it. This creates the one table the app
   uses (`app_state`) and the access policies.
3. Go to **Project Settings → API**. Copy:
   - **Project URL**
   - **anon public** key

## 2. Connect the app to it

Copy `.env.example` to `.env` and fill in the two values from step 1:

```bash
cp .env.example .env
```

```
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-public-key
```

`.env` is already in `.gitignore` — never commit it.

## 3. Run locally

```bash
npm install
npm run dev
```

Open it on two different browser tabs/devices and check that changes on one show up on the
other within a few seconds.

## 4. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/Mrcottonwool27/ibabad_website.git
git push -u origin main
```

## 5. Deploy (Vercel)

1. [vercel.com](https://vercel.com) → sign in with GitHub → **Import Project** → pick `ibabad_website`.
2. Framework preset: **Vite** (auto-detected).
3. **Before deploying**, add the same two environment variables from your `.env` file under
   **Environment Variables** in the Vercel project settings (`VITE_SUPABASE_URL`,
   `VITE_SUPABASE_ANON_KEY`) — without these the deployed site can't reach your database.
4. Deploy — you'll get a live URL that any device can open, and they'll all share the same data.

## How the syncing works

- Everything (players, matches, prices, check-ins, payments, even the app password) lives in
  **one row** in the `app_state` table as a single JSON blob.
- Each device saves its changes ~1 second after you stop editing, and polls the database every
  ~5 seconds to pick up changes made on other devices.
- This is simple and reliable for one club being managed from a couple of devices at a time.
  It is **not** built for many people editing the exact same thing at the exact same instant —
  the last write within a given save cycle wins. For a single admin/captain workflow (which is
  how this app is designed) that's not an issue in practice.

## ⚠️ Security note

The password gate in the app is a **UI-level** lock — it does not protect the database itself.
Your Supabase `anon` key is public by design (it's embedded in the website's JavaScript, visible
to anyone who opens dev tools), and the SQL policies above allow that key to read/write the table
directly, bypassing the app's login screen entirely if someone goes looking. For a private club
tool this is a reasonable trade-off, but don't store anything genuinely sensitive in it. If you
want real protection later, the next step is adding proper Supabase Auth (real user accounts)
and rewriting the RLS policies to require a logged-in, authorized user — ask me when you're ready
for that.
