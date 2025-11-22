# Changelog

All notable changes to TrackPose will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Production MediaPipe integration
- Real-time WebSocket notifications
- Advanced analytics dashboard
- Multi-language support
- Offline mode for mobile app

## [1.0.0] - 2025-01-20

### Added
- Complete monorepo structure with backend, media service, and mobile app
- Node.js + TypeScript + Express backend with Prisma ORM
- Python FastAPI media processing microservice with MediaPipe placeholder
- Flutter mobile app for Android and iOS with Riverpod and go_router
- MySQL database schema with full relations
- S3-compatible object storage integration
- Stripe subscription payment flows
- Email verification with 6-digit codes
- JWT authentication and authorization
- Access code system for facility connections
- Trial plan with server-side enforcement
- GDPR user erasure endpoint
- Mock AI aggregator with deterministic outputs
- Live monitoring with camera integration
- AI insights reports with 7 categories
- Docker and Docker Compose configurations
- Render deployment configuration (render.yaml)
- GitHub Actions CI/CD workflows
- Fastlane configuration for mobile app publishing
- Comprehensive documentation and deployment guides

### Security
- Password hashing with bcrypt
- JWT token-based authentication
- Secure environment variable handling
- Email verification enforcement
- CORS protection
- Input validation
- SQL injection protection via Prisma
- XSS protection via Express security middleware

## [0.1.0] - 2025-01-15

### Added
- Initial project scaffolding
- Basic directory structure
- Placeholder files
