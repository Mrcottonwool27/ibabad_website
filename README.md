# IBABAD

Badminton club matchmaking, scoring, and finance app.

## Run locally

```bash
npm install
npm run dev
```

## Push to your GitHub repo

From inside this folder:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/Mrcottonwool27/ibabad_website.git
git push -u origin main
```

If the repo already has files (like a README created on GitHub), pull first to avoid conflicts:

```bash
git pull origin main --allow-unrelated-histories
```

then resolve any conflicts and push.

## Deploy (get a real link)

Once it's on GitHub, connect it to [Vercel](https://vercel.com) or [Netlify](https://netlify.com):
1. Sign in with GitHub
2. "Import Project" → pick `ibabad_website`
3. Framework preset: **Vite**
4. Deploy — you'll get a live URL

## Next: online database

This version stores everything in memory (resets on refresh). See the chat history for the plan to connect Supabase for persistent, shared, online storage.
