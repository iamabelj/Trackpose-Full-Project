# Multi-stage Dockerfile for TrackPose Backend
# Optimized for production deployment on Render
# Cache bust: 2025-11-22-16:14

# =============================================================================
# Stage 1: Builder
# =============================================================================
FROM node:20-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache python3 make g++

# Copy package files first (for layer caching)
COPY package*.json ./
COPY prisma ./prisma/

# Install all dependencies (including dev dependencies for build)
RUN npm ci --no-audit --no-fund

# Copy source code (this invalidates cache if source changes)
COPY tsconfig.json ./
COPY src ./src

# Generate Prisma Client
RUN npx prisma generate

# Build TypeScript to JavaScript
RUN npm run build

# Verify build output exists
RUN ls -la dist/

# =============================================================================
# Stage 2: Production (DEFAULT TARGET)
# =============================================================================
FROM node:20-alpine

WORKDIR /app

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Set environment
ENV NODE_ENV=production

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production && npm cache clean --force

# Copy Prisma schema and generated client from builder
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma

# Copy built application from builder
COPY --from=builder /app/dist ./dist

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app

USER nodejs

# Expose application port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/v1/admin/system-health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Start command - runs compiled JavaScript, not TypeScript
CMD ["sh", "-c", "if [ \"$RUN_MIGRATIONS\" = \"true\" ]; then echo 'Running migrations...' && npx prisma generate && npx prisma migrate deploy; fi && npx prisma generate && node dist/index.js"]

# =============================================================================
# BUILD NOTES
# =============================================================================
# 
# Build for production:
#   docker build -t trackpose-backend:prod .
# 
# Run locally:
#   docker run -p 3000:3000 --env-file .env trackpose-backend:prod
# 
# Render will automatically build this production image
# 
# Environment variables required:
#   DATABASE_URL, JWT_SECRET, STRIPE_SECRET_KEY, S3_*, SENDGRID_API_KEY, etc.
#   See .env.example for complete list
# 
# =============================================================================

