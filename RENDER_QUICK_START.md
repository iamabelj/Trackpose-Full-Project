# RENDER SETUP QUICK REFERENCE

## ✅ IMPORTANT: Your backend uses MySQL, NOT PostgreSQL!

## 1. Create MySQL Database First

Go to Render Dashboard → New + → **MySQL** (not PostgreSQL!)

**Settings:**
- Name: `trackpose-db`
- Database: `trackpose`
- Region: Oregon (or closest to you)
- Plan: Free or Starter

**Save this URL:** You'll get an "Internal Database URL" like:
```
mysql://trackpose_user:password@dpg-xxxxx.oregon-postgres.render.com:3306/trackpose
```

## 2. Create Web Service (Backend)

Go to Render Dashboard → New + → Web Service

**Connect Your Repo:**
- Repository: `iamabelj/Trackpose-Full-Project`
- Branch: `main`

**Service Settings:**
- Name: `trackpose-backend`
- Region: Same as database (Oregon)
- Root Directory: `services/backend`
- Runtime: **Docker** (auto-detected from Dockerfile)
- Instance Type: Free or Starter

**Build Command:** (leave empty - Docker handles it)

**Start Command:** (leave empty - Dockerfile CMD handles it)

## 3. Environment Variables

Click "Add Environment Variable" - add these ONE BY ONE:

```
DATABASE_URL=<paste Internal Database URL from MySQL>
NODE_ENV=production
PORT=3000
JWT_SECRET=<generate random 64-char string>
JWT_EXPIRES_IN=7d
RUN_MIGRATIONS=true
CORS_ORIGIN=*
LOG_LEVEL=info
```

**Generate JWT_SECRET:**
Run in PowerShell:
```powershell
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

**Copy the output** and paste as JWT_SECRET value.

## 4. Deploy

Click **"Create Web Service"**

Render will:
1. Clone your repo
2. Build Docker image (5-10 minutes first time)
3. Run Prisma migrations
4. Start server

**Your API will be at:**
```
https://trackpose-backend.onrender.com
```

**Test it:**
```
https://trackpose-backend.onrender.com/api/v1/admin/system-health
```

## 5. Monitor Logs

In Render dashboard:
- Click on your service
- Go to "Logs" tab
- Watch for startup messages

**Look for:**
```
Prisma schema loaded from prisma/schema.prisma
✔ Generated Prisma Client
Backend listening on 3000
```

## Troubleshooting

### "Cannot find module 'nodemailer'"
- Already fixed in latest commit
- Render will install it automatically

### "JWT TypeScript errors"
- Already fixed in latest commit
- Using proper StringValue type from 'ms' package

### "No open ports detected"
- Check your `src/index.ts` binds to `0.0.0.0`:
  ```typescript
  app.listen(PORT, '0.0.0.0', () => { ... });
  ```
- This is already correct in your code

### Database connection fails
- Double-check DATABASE_URL is the **Internal Database URL**
- Must start with `mysql://` not `postgres://`
- Check database is "Available" in Render dashboard

### Build succeeds but crashes at runtime
- Check Logs tab for error details
- Prisma might need OpenSSL fix (already in Dockerfile)

## Your Code Status

✅ JWT helper fixed with proper types
✅ Email helper with nodemailer installed
✅ Sessions route uses 'UPLOAD' (uppercase)
✅ Build passes locally
✅ Dockerfile optimized for production
✅ All dependencies in package.json

## Next Steps

1. Create MySQL database on Render
2. Copy Internal Database URL
3. Create Web Service with Docker
4. Add environment variables
5. Deploy and wait
6. Test your API endpoint
7. Check logs if anything fails

---

**Latest commit pushed:** fix(backend): resolve JWT TypeScript errors and add Render deployment guide

**Your deployment should work now!** 🚀
