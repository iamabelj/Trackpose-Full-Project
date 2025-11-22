# Multi-stage Dockerfile for TrackPose Backend
# Optimized for production deployment on Render

# =============================================================================
# Stage 1: Builder
# =============================================================================
FROM node:20-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache python3 make g++

# Copy package files
COPY package*.json ./
COPY prisma ./prisma/

# Install all dependencies (including dev dependencies for build)
RUN npm ci

# Copy source code
COPY tsconfig.json ./
COPY src ./src

# Generate Prisma Client
RUN npx prisma generate

# Build TypeScript to JavaScript
RUN npm run build

# =============================================================================
# Stage 2: Production
# =============================================================================
FROM node:20-alpine AS production

WORKDIR /app

# Install dumb-init for proper signal handling and mysql client for healthcheck
RUN apk add --no-cache dumb-init mysql-client

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
# Checks if the application responds with 200 on the health endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/v1/admin/system-health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Start command
# If RUN_MIGRATIONS=true, run migrations before starting the server
# WARNING: Be careful with auto-migrations in production!
CMD ["sh", "-c", "if [ \"$RUN_MIGRATIONS\" = \"true\" ]; then echo 'Running migrations...' && npx prisma migrate deploy; fi && node dist/index.js"]

# =============================================================================
# Stage 3: Development (for local Docker Compose)
# =============================================================================
FROM node:20-alpine AS development

WORKDIR /app

# Install development tools
RUN apk add --no-cache git mysql-client

# Copy package files
COPY package*.json ./

# Install all dependencies including dev dependencies
RUN npm install

# Copy Prisma schema
COPY prisma ./prisma/

# Generate Prisma Client
RUN npx prisma generate

# Copy source code (will be mounted as volume in docker-compose)
COPY . .

# Expose port
EXPOSE 3000

# Development command with hot reload
CMD ["npm", "run", "dev"]

# =============================================================================
# BUILD NOTES
# =============================================================================
# 
# Build for development:
#   docker build --target development -t trackpose-backend:dev .
# 
# Build for production:
#   docker build --target production -t trackpose-backend:prod .
# 
# Run locally:
#   docker run -p 3000:3000 --env-file .env trackpose-backend:prod
# 
# Render will automatically build the 'production' stage
# 
# Environment variables required:
#   DATABASE_URL, JWT_SECRET, STRIPE_SECRET_KEY, S3_*, SENDGRID_API_KEY, etc.
#   See .env.example for complete list
# 
# =============================================================================

