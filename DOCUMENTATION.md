# TrackPose - Complete Documentation

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Getting Started](#getting-started)
4. [Development Guide](#development-guide)
5. [API Reference](#api-reference)
6. [Mobile App Guide](#mobile-app-guide)
7. [Deployment](#deployment)
8. [Testing](#testing)
9. [Troubleshooting](#troubleshooting)

## Overview

TrackPose is an AI-powered wellbeing monitoring platform designed for families, caregivers, and facility managers to monitor children and elderly individuals in real-time using computer vision and pose estimation.

### Key Features
- **Real-time Monitoring**: Live camera feeds with AI-powered pose analysis
- **AI Insights**: Automated wellbeing reports across 7 categories (Activity, Mood, Safety, Social, Sleep, Nutrition, Medical)
- **Multi-Role Access**: Parent, Staff/Caregiver, and Admin dashboards
- **Facility Management**: Connect to home or external facilities with access codes
- **Subscription Plans**: Trial, Basic, and Premium tiers with Stripe integration
- **GDPR Compliant**: User data erasure and privacy controls

### Technology Stack
- **Mobile**: Flutter 3.x with Riverpod and go_router
- **Backend**: Node.js, TypeScript, Express, Prisma ORM
- **Media Service**: Python, FastAPI, MediaPipe (placeholder)
- **Database**: MySQL 8
- **Storage**: S3-compatible object storage
- **Payments**: Stripe
- **Deployment**: Render (managed services)

## Architecture

### System Components

```
┌─────────────────┐
│  Flutter Mobile │
│      App        │
└────────┬────────┘
         │
         │ REST API
         │
┌────────▼────────┐      ┌──────────────┐
│   Node.js       │◄────►│   MySQL      │
│   Backend       │      │   Database   │
└────────┬────────┘      └──────────────┘
         │
         │ REST API
         │
┌────────▼────────┐      ┌──────────────┐
│   Python        │◄────►│  S3 Object   │
│   Media Service │      │   Storage    │
└─────────────────┘      └──────────────┘
```

### Directory Structure
```
trackpose/
├── apps/
│   └── mobile/              # Flutter mobile app
│       ├── lib/
│       │   ├── config/      # App configuration
│       │   ├── providers/   # Riverpod providers
│       │   ├── screens/     # UI screens (40+ screens)
│       │   └── main.dart    # App entry point
│       └── pubspec.yaml
├── services/
│   ├── backend/             # Node.js API server
│   │   ├── src/
│   │   │   ├── controllers/ # Request handlers
│   │   │   ├── middleware/  # Auth, validation
│   │   │   ├── routes/      # API routes
│   │   │   └── services/    # Business logic
│   │   ├── prisma/
│   │   │   └── schema.prisma # Database schema
│   │   └── Dockerfile
│   └── media/               # Python media processor
│       ├── app/
│       │   ├── main.py      # FastAPI app
│       │   └── mediapipe_processor.py
│       └── Dockerfile
├── packages/                # Shared packages (future use)
├── unwanted_files/          # Archived documentation
├── .env.example             # Environment template
├── docker-compose.yml       # Local development
├── render.yaml              # Production deployment
├── README.md                # Quick start guide
├── CHANGELOG.md             # Version history
└── DOCUMENTATION.md         # This file
```

## Getting Started

### Prerequisites
- Flutter SDK 3.x
- Node.js 20+
- Python 3.11+
- Docker & Docker Compose
- MySQL 8 (via Docker)
- Git

### Quick Setup (5 minutes)

```bash
# 1. Clone repository
git clone <your-repo-url>
cd trackpose

# 2. Install dependencies
cd services/backend && npm install && cd ../..
cd services/media && pip install -r requirements.txt && cd ../..
cd apps/mobile && flutter pub get && cd ../..

# 3. Start services with Docker
docker-compose up -d

# 4. Run migrations
cd services/backend
npx prisma migrate dev
npx prisma generate

# 5. Start mobile app
cd ../../apps/mobile
flutter run
```

## Development Guide

### Backend Development

#### API Endpoints Structure
```
/api/v1/
├── auth/          # Authentication
├── users/         # User management
├── facilities/    # Facility CRUD
├── profiles/      # Child/elderly profiles
├── sessions/      # Monitoring sessions
├── reports/       # AI insights
├── notifications/ # Alerts
├── media/         # File uploads
└── payments/      # Stripe integration
```

#### Adding a New Endpoint

1. **Define route** (`services/backend/src/routes/example.ts`):
```typescript
import { Router } from 'express';
import { authenticate } from '../middleware/auth';
import * as controller from '../controllers/example.controller';

const router = Router();
router.get('/', authenticate, controller.getAll);
router.post('/', authenticate, controller.create);

export default router;
```

2. **Create controller** (`services/backend/src/controllers/example.controller.ts`):
```typescript
import { Request, Response } from 'express';
import * as service from '../services/example.service';

export async function getAll(req: Request, res: Response) {
  try {
    const data = await service.findAll(req.user!.id);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

3. **Implement service** (`services/backend/src/services/example.service.ts`):
```typescript
import { prisma } from '../lib/prisma';

export async function findAll(userId: number) {
  return prisma.example.findMany({
    where: { userId }
  });
}
```

4. **Register route** in `services/backend/src/index.ts`:
```typescript
import exampleRoutes from './routes/example';
app.use('/api/v1/examples', exampleRoutes);
```

### Mobile Development

#### Screen Structure
All screens follow this pattern:
```dart
// lib/screens/example_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleScreen extends ConsumerWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: Center(child: Text('Content')),
    );
  }
}
```

#### Navigation
Uses go_router. Add routes in `lib/main.dart`:
```dart
GoRoute(
  path: '/example',
  name: 'example',
  builder: (context, state) => const ExampleScreen(),
),
```

Navigate with:
```dart
context.go('/example');           // Replace current route
context.push('/example');         // Push on stack
context.goNamed('example');       // Named route
```

#### State Management
Uses Riverpod providers:
```dart
// Define provider
final exampleProvider = StateNotifierProvider<ExampleNotifier, ExampleState>(
  (ref) => ExampleNotifier(),
);

// Use in widget
final state = ref.watch(exampleProvider);
ref.read(exampleProvider.notifier).doSomething();
```

#### API Integration
```dart
// lib/providers/api_client_provider.dart
final apiClient = ref.watch(apiClientProvider);

final response = await apiClient.get('/profiles');
final data = await apiClient.post('/profiles', body: {...});
```

## API Reference

### Authentication

#### POST /api/v1/auth/signup
Register new user.
```json
Request:
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "role": "PARENT"
}

Response:
{
  "token": "jwt.token.here",
  "user": {
    "id": 1,
    "email": "john@example.com",
    "role": "PARENT"
  }
}
```

#### POST /api/v1/auth/login
Authenticate user.
```json
Request:
{
  "email": "john@example.com",
  "password": "SecurePass123!"
}

Response:
{
  "token": "jwt.token.here",
  "user": { ... }
}
```

#### POST /api/v1/auth/verify-email
Verify email with 6-digit code.
```json
Request:
{
  "email": "john@example.com",
  "code": "123456"
}

Response:
{
  "verified": true
}
```

### Profiles

#### GET /api/v1/profiles
Get all profiles for current user.
```
Headers: Authorization: Bearer <token>
Response: Array of profile objects
```

#### POST /api/v1/profiles
Create new profile.
```json
Request:
{
  "name": "Child Name",
  "dateOfBirth": "2020-01-01",
  "relation": "son",
  "facilityId": 1
}
```

### Sessions

#### POST /api/v1/sessions/start
Start monitoring session.
```json
Request:
{
  "profileId": 1,
  "cameraId": "cam-123"
}

Response:
{
  "sessionId": 5,
  "status": "active"
}
```

#### POST /api/v1/sessions/:id/stop
Stop monitoring session.

### Reports

#### GET /api/v1/reports/:profileId
Get AI insights for profile.
```
Query params: ?startDate=2025-01-01&endDate=2025-01-31
Response: AI insights across 7 categories
```

## Mobile App Guide

### User Flows

#### Onboarding Flow
1. Intro Welcome Screen
2. How It Works 1 (Pose Detection)
3. How It Works 2 (AI Insights)
4. Privacy Policy
5. Login/Signup

#### Parent Setup Flow
1. Signup → Email Verification
2. Choose Role (Parent)
3. Choose Plan (Trial/Basic/Premium)
4. Payment (if not trial)
5. Facility Choice (Home/External)
6. Home Facility Setup OR External Facility + Access Code
7. Parent Dashboard

#### Staff Setup Flow
1. Signup → Email Verification
2. Choose Role (Staff)
3. Caregiver Facility Setup (select facility type)
4. Staff Dashboard (full access, no payment)

#### Admin Setup Flow
1. Signup → Email Verification
2. Choose Role (Admin)
3. Facility Setup
4. Admin Dashboard

### Key Screens

- **Dashboard**: Real-time overview, recent activity
- **Live Feed**: Camera streams with AI overlays
- **Live Monitoring**: Full-screen monitoring view
- **Reports**: AI insights and analytics
- **Reports AI Insights**: Detailed AI analysis
- **Notifications**: Alerts and updates
- **Profile Detail**: Individual profile management
- **User Settings**: Account, notifications, privacy
- **Admin Settings**: System configuration
- **Messages**: Communication hub

## Deployment

### Render Deployment

#### 1. Create Services
```bash
# In Render Dashboard:
# - New Database: trackpose-db (MySQL)
# - New Web Service: trackpose-backend (Docker)
# - New Web Service: trackpose-media (Docker)
```

#### 2. Environment Variables

**Backend**:
- `DATABASE_URL`: From Render MySQL
- `JWT_SECRET`: Random 64-char string
- `STRIPE_SECRET_KEY`: From Stripe
- `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`
- `SENDGRID_API_KEY`, `EMAIL_FROM`
- `CALLBACK_SECRET`: Shared with media service
- `MEDIA_SERVICE_URL`: Media service URL

**Media Service**:
- `CALLBACK_SECRET`: Same as backend
- `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`

#### 3. Deploy
```bash
# Push to GitHub
git push origin main

# Render auto-deploys from render.yaml
# Or manually deploy from Dashboard
```

#### 4. Run Migrations
```bash
cd services/backend
DATABASE_URL="<render-db-url>" npx prisma migrate deploy
```

### Mobile App Publishing

#### Android (Google Play)
```bash
cd apps/mobile
flutter build appbundle --release

# Upload to Play Console
# Or use Fastlane:
cd android
bundle exec fastlane beta_android
```

#### iOS (App Store)
```bash
cd apps/mobile
flutter build ipa --release

# Upload to TestFlight
# Or use Fastlane:
cd ios
bundle exec fastlane beta_ios
```

## Testing

### Backend Tests
```bash
cd services/backend
npm run test          # Run all tests
npm run test:watch    # Watch mode
npm run test:coverage # Coverage report
```

### Mobile Tests
```bash
cd apps/mobile
flutter test                    # Unit tests
flutter test integration_test/  # Integration tests
flutter analyze                 # Static analysis
```

### Manual Testing Checklist
- [ ] User signup and email verification
- [ ] Login and JWT refresh
- [ ] Profile creation and editing
- [ ] Facility connection with access code
- [ ] Session start/stop
- [ ] File upload to S3
- [ ] Report generation
- [ ] Notifications
- [ ] Payment flow (Stripe test mode)
- [ ] User deletion (GDPR)

## Troubleshooting

### Common Issues

#### "Unable to connect to database"
- Verify `DATABASE_URL` is correct
- Check if MySQL is running: `docker ps`
- Ensure migrations ran: `npx prisma migrate status`

#### "S3 upload failed"
- Check S3 credentials in environment
- Verify bucket exists and permissions are correct
- Test with AWS CLI: `aws s3 ls s3://your-bucket`

#### "Flutter build failed"
- Run `flutter doctor` to check setup
- Clean build: `flutter clean && flutter pub get`
- Check platform-specific configs

#### "API returns 401 Unauthorized"
- Token expired? Re-login
- Token format: `Bearer <token>` in Authorization header
- Verify JWT_SECRET matches between environments

#### "Stripe webhook not working"
- Check webhook URL in Stripe Dashboard
- Verify `STRIPE_WEBHOOK_SECRET` matches
- Test webhook with Stripe CLI: `stripe listen --forward-to localhost:3000/api/v1/payments/webhook`

### Debug Mode

Backend debug logging:
```bash
DEBUG=trackpose:* npm run dev
```

Flutter debug:
```bash
flutter run --verbose
```

### Logs

View Render logs:
```bash
# From Dashboard or CLI
render logs --service trackpose-backend --tail
```

## Support

For issues and questions:
- GitHub Issues: <repo-url>/issues
- Email: support@trackpose.com
- Documentation: This file

## Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/my-feature`
3. Commit changes: `git commit -m 'Add my feature'`
4. Push to branch: `git push origin feature/my-feature`
5. Open Pull Request

### Code Standards
- Backend: ESLint + Prettier
- Mobile: Flutter analysis + `flutter format`
- Commit messages: Conventional Commits format

## License

Proprietary - All rights reserved

---

**Last Updated**: November 22, 2025  
**Version**: 1.0.0
