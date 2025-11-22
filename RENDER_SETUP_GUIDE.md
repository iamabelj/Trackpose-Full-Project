# TrackPose Backend - Render Deployment Guide

## Prerequisites
- GitHub repository with your code pushed
- Render account (free tier works)

## Step 1: Create MySQL Database on Render

**IMPORTANT:** Your Prisma schema uses MySQL, NOT PostgreSQL!

1. Go to https://dashboard.render.com
2. Click "New +" → "MySQL"
3. Configure:
   - **Name**: `trackpose-db` (or any name you prefer)
   - **Database**: `trackpose`
   - **User**: `trackpose_user` (auto-generated)
   - **Region**: Choose closest to your users
   - **Plan**: Free or paid (free has limits)
4. Click "Create Database"
5. **SAVE the connection details** - you'll need the "Internal Database URL"

## Step 2: Create Web Service on Render

1. Click "New +" → "Web Service"
2. Connect your GitHub repository
3. Configure the service:

### Basic Settings
- **Name**: `trackpose-backend`
- **Region**: Same as database
- **Branch**: `main`
- **Root Directory**: `services/backend`
- **Runtime**: Docker
- **Instance Type**: Free or paid

### Build & Deploy Settings
Since you're using Docker, Render will automatically detect the Dockerfile.

**NO NEED TO SET BUILD COMMAND** - Docker builds automatically.

**Start Command** (leave empty - Dockerfile handles it)

### Environment Variables

Click "Add Environment Variable" and add these one by one:

```
DATABASE_URL=<paste from Render MySQL Internal URL>
NODE_ENV=production
PORT=3000
JWT_SECRET=<generate random 64-char string>
JWT_EXPIRES_IN=7d
RUN_MIGRATIONS=true

# Optional but recommended:
CORS_ORIGIN=*
LOG_LEVEL=info
```

**How to generate JWT_SECRET:**
- Run this in PowerShell: `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`
- Or use: https://www.random.org/strings/

### Important Notes:
- Use the **Internal Database URL** from Step 1 for DATABASE_URL
- Format: `mysql://user:password@host:port/database`
- Example: `mysql://trackpose_user:abc123@dpg-xxxxx-a.oregon-postgres.render.com:3306/trackpose`

## Step 3: Deploy

1. Click "Create Web Service"
2. Render will:
   - Clone your repo
   - Build the Docker image
   - Run migrations (if RUN_MIGRATIONS=true)
   - Start the service
3. Wait 5-10 minutes for first deploy

## Step 4: Verify Deployment

Your service will be available at: `https://trackpose-backend.onrender.com`

Test endpoints:
```
GET https://trackpose-backend.onrender.com/api/v1/admin/system-health
```

## Troubleshooting

### "No open ports detected"
- Your app must bind to `0.0.0.0` and port from `process.env.PORT`
- Check `src/index.ts` has this pattern:
  ```typescript
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
  });
  ```

### Docker build fails
- Check Dockerfile is at `services/backend/Dockerfile`
- Ensure all dependencies are in package.json
- Check logs for specific errors

### Database connection fails
- Verify DATABASE_URL is the Internal URL from Render MySQL
- Format must be: `mysql://user:pass@host:port/dbname`
- Check database is running in Render dashboard

### TypeScript errors during build
- These must be fixed before deployment
- Run `npm run build` locally first
- Fix all type errors

## Current Known Issues to Fix

Based on your error logs, you have these TypeScript errors:

1. **JWT Error** in `src/lib/jwt.ts:3,61`
   - Wrong type cast for JWT_SECRET
   - Needs proper Secret type handling

2. **Sessions Error** in `src/routes/sessions.ts:11,127`
   - Using lowercase `'upload'` instead of `'UPLOAD'`
   - SessionSource enum expects uppercase

## Quick Fixes Needed

### Fix 1: JWT Helper
File: `services/backend/src/lib/jwt.ts`
```typescript
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret-change-in-production';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '7d';

export function signToken(payload: object, expiresIn?: string): string {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: expiresIn || JWT_EXPIRES_IN });
}

export function verifyToken<T = any>(token: string): T | null {
  try {
    return jwt.verify(token, JWT_SECRET) as T;
  } catch {
    return null;
  }
}

export type JwtPayload = { [key: string]: any };
```

### Fix 2: Sessions Route
Find this line in `services/backend/src/routes/sessions.ts`:
```typescript
source: 'upload'
```

Change to:
```typescript
source: 'UPLOAD'
```

## After Fixes

1. Commit changes:
```bash
git add .
git commit -m "fix: TypeScript errors for Render deployment"
git push origin main
```

2. Render will auto-deploy (if enabled)

3. Check logs in Render dashboard

## Support

If deployment fails:
1. Check Render logs (click on service → "Logs" tab)
2. Copy exact error messages
3. Check database connection in Render dashboard
4. Verify all environment variables are set

---

**Remember:** PostgreSQL 18 won't work with your current schema. You MUST use MySQL on Render!
