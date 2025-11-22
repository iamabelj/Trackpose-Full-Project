# TrackPose - AI-Powered Wellbeing Monitoring

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Node.js](https://img.shields.io/badge/Node.js-20+-339933?logo=node.js)
![Python](https://img.shields.io/badge/Python-3.11+-3776AB?logo=python)
![License](https://img.shields.io/badge/License-Proprietary-red)

TrackPose is an AI-powered wellbeing monitoring platform for families, caregivers, and facility managers to monitor children and elderly individuals using real-time computer vision and pose estimation.

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.x
- Node.js 20+
- Python 3.11+
- Docker & Docker Compose

### Local Development Setup (5 minutes)

```bash
# 1. Clone and install
git clone <your-repo-url>
cd trackpose

# Backend
cd services/backend && npm install && cd ../..

# Media service
cd services/media && pip install -r requirements.txt && cd ../..

# Mobile app
cd apps/mobile && flutter pub get && cd ../..

# 2. Start services
docker-compose up -d

# 3. Run migrations
cd services/backend
npx prisma migrate dev
npx prisma generate

# 4. Start development servers
# Terminal 1 - Backend
npm run dev

# Terminal 2 - Media service
cd ../../services/media
uvicorn app.main:app --reload

# Terminal 3 - Mobile app
cd ../../apps/mobile
flutter run
```

## 📱 Features

- **Real-time Monitoring**: Live camera feeds with AI-powered pose analysis
- **AI Insights**: Automated wellbeing reports (Activity, Mood, Safety, Social, Sleep, Nutrition, Medical)
- **Multi-Role Access**: Parent, Staff/Caregiver, and Admin dashboards
- **Facility Management**: Home or external facility connections with access codes
- **Subscription Plans**: Trial, Basic, Premium with Stripe integration
- **GDPR Compliant**: User data erasure and privacy controls

## 🏗️ Architecture

```
Flutter Mobile App → Node.js Backend → MySQL Database
                   ↓
           Python Media Service → S3 Storage
```

### Technology Stack
- **Mobile**: Flutter with Riverpod & go_router
- **Backend**: Node.js, TypeScript, Express, Prisma ORM
- **Media**: Python, FastAPI, MediaPipe
- **Database**: MySQL 8
- **Storage**: S3-compatible
- **Payments**: Stripe
- **Hosting**: Render

## 📂 Project Structure

```
trackpose/
├── apps/mobile/          # Flutter mobile app
├── services/
│   ├── backend/          # Node.js API server
│   └── media/            # Python media processor
├── packages/             # Shared packages
├── docker-compose.yml    # Local development
├── render.yaml           # Production deployment
├── README.md             # This file
├── CHANGELOG.md          # Version history
└── DOCUMENTATION.md      # Complete documentation
```

## 🌐 Deployment

### Production (Render)

1. **Create Services**:
   - MySQL Database: `trackpose-db`
   - Backend: `trackpose-backend` (Docker)
   - Media Service: `trackpose-media` (Docker)

2. **Backend Service Configuration**:
   
   **Build Command**:
   ```bash
   cd services/backend && npm ci && npm run build
   ```
   
   **Start Command**:
   ```bash
   cd services/backend && npx prisma generate && node dist/index.js
   ```
   
   **Important**: Ensure your backend server:
   - Listens on `process.env.PORT` (Render assigns this dynamically)
   - Binds to `0.0.0.0` (not just `localhost`)

3. **Set Environment Variables**:
   ```bash
   # Backend
   DATABASE_URL=<render-mysql-url>
   JWT_SECRET=<random-64-char>
   STRIPE_SECRET_KEY=<stripe-key>
   S3_BUCKET=<bucket-name>
   SENDGRID_API_KEY=<sendgrid-key>
   
   # Media Service
   CALLBACK_SECRET=<shared-secret>
   S3_BUCKET=<bucket-name>
   ```

4. **Deploy**:
   ```bash
   git push origin main
   # Render auto-deploys from render.yaml
   ```

5. **Run Migrations**:
   ```bash
   cd services/backend
   DATABASE_URL=<render-url> npx prisma migrate deploy
   ```

See [DOCUMENTATION.md](DOCUMENTATION.md) for complete deployment guide.

## 📱 Mobile App Publishing

### Android
```bash
flutter build appbundle --release
# Upload to Google Play Console
```

### iOS
```bash
flutter build ipa --release
# Upload to App Store Connect
```

## 🧪 Testing

```bash
# Backend tests
cd services/backend
npm run test

# Mobile tests
cd apps/mobile
flutter test
flutter analyze
```

## 📖 Documentation

- **[Complete Documentation](DOCUMENTATION.md)**: Full development and deployment guide
- **[Changelog](CHANGELOG.md)**: Version history and changes
- **API Docs**: Available at `/api/v1/docs` after deployment

## 🔐 Security

- JWT authentication with bcrypt password hashing
- Email verification enforcement
- CORS protection and input validation
- SQL injection protection via Prisma
- GDPR-compliant user data deletion

## 🛠️ Key Commands

```bash
# Development
docker-compose up -d          # Start services
npm run dev                   # Backend dev server
flutter run                   # Mobile app

# Testing
npm run test                  # Backend tests
flutter test                  # Mobile tests

# Deployment
git push origin main          # Deploy to Render
flutter build appbundle       # Android build
flutter build ipa             # iOS build

# Database
npx prisma migrate dev        # Run migrations
npx prisma studio             # Database GUI
```

## 🚧 Current Status

**Version**: 1.0.0  
**Status**: Production-ready with mock AI (MediaPipe integration pending)

### Implemented
- ✅ Complete authentication system
- ✅ User roles and permissions
- ✅ Facility management
- ✅ Profile management
- ✅ Session tracking
- ✅ Mock AI insights
- ✅ Stripe payments
- ✅ File uploads to S3
- ✅ Email notifications
- ✅ 40+ mobile screens
- ✅ GDPR compliance

### Pending
- ⏳ MediaPipe real-time processing
- ⏳ WebSocket notifications
- ⏳ Advanced analytics dashboard
- ⏳ Multi-language support
- ⏳ Offline mode

## 🐛 Troubleshooting

### Database connection failed
```bash
# Check if MySQL is running
docker ps
# Verify DATABASE_URL in .env
```

### Flutter build errors
```bash
flutter doctor
flutter clean && flutter pub get
```

### S3 upload failed
```bash
# Verify credentials and bucket permissions
aws s3 ls s3://your-bucket
```

See [DOCUMENTATION.md](DOCUMENTATION.md#troubleshooting) for more solutions.

## 📄 License

Proprietary - All rights reserved

## 👥 Team

TrackPose Development Team

## 🔗 Links

- **Repository**: <your-github-repo>
- **Issues**: <repo-url>/issues
- **Website**: https://trackpose.com (coming soon)
- **Support**: support@trackpose.com

---

**Built with ❤️ using Flutter, Node.js, and Python**
