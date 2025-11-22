// TrackPose - AI-Powered Wellbeing Monitoring
// Main entry point

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Auth & Onboarding Screens
import 'screens/intro_welcome_screen.dart';
import 'screens/onboarding_how_it_works_1.dart';
import 'screens/onboarding_how_it_works_2.dart';
import 'screens/onboarding_privacy.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/reset_password_screen.dart';

// Role & Setup Screens
import 'screens/choose_role_screen.dart';
import 'screens/facility_choice_screen.dart';
import 'screens/facility_setup_choice_screen.dart';
import 'screens/home_facility_screen.dart';
import 'screens/external_facility_screen.dart';
import 'screens/access_code_entry_screen.dart';
import 'screens/facility_setup_screen.dart';

// Dashboard Screens
import 'screens/dashboard_screen.dart';
import 'screens/parent_dashboard_screen.dart';
import 'screens/staff_dashboard_screen.dart';
import 'screens/admin_dashboard_screen.dart';

// Feature Screens
import 'screens/live_feed_screen.dart';
import 'screens/live_monitoring_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/admin_notifications_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/reports_ai_insights_screen.dart';
import 'screens/message_screen.dart';
import 'screens/profile_detail_screen.dart';

// Settings & Configuration
import 'screens/user_settings_screen.dart';
import 'screens/admin_settings_screen.dart';
import 'screens/caregiver_facility_setup_screen.dart';

// Plan & Payment
import 'screens/choose_plan_screen.dart';
import 'screens/plan_selection_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TrackPoseApp(),
    ),
  );
}

class TrackPoseApp extends StatelessWidget {
  const TrackPoseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrackPose',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      routerConfig: _router,
    );
  }
}

// Router Configuration
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // ========== ONBOARDING & AUTH ROUTES ==========
    
    // Intro/Welcome
    GoRoute(
      path: '/',
      name: 'intro',
      builder: (context, state) => const IntroWelcomeScreen(),
    ),
    
    // Onboarding How It Works 1
    GoRoute(
      path: '/onboarding-1',
      name: 'onboarding-1',
      builder: (context, state) => const OnboardingHowItWorks1(),
    ),
    
    // Onboarding How It Works 2
    GoRoute(
      path: '/onboarding-2',
      name: 'onboarding-2',
      builder: (context, state) => const OnboardingHowItWorks2(),
    ),
    
    // Onboarding Privacy
    GoRoute(
      path: '/onboarding-privacy',
      name: 'onboarding-privacy',
      builder: (context, state) => const OnboardingPrivacy(),
    ),
    
    // Login
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // Signup
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) {
        final role = state.uri.queryParameters['role'];
        return SignupScreen(role: role);
      },
    ),
    
    // Email Verification
    GoRoute(
      path: '/verification',
      name: 'verification',
      builder: (context, state) => const VerificationScreen(),
    ),
    
    // Forgot Password
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    
    // Reset Password
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    // ========== ROLE & SETUP ROUTES ==========
    
    // Choose Role
    GoRoute(
      path: '/choose-role',
      name: 'choose-role',
      builder: (context, state) => const ChooseRoleScreen(),
    ),
    
    // Facility Choice
    GoRoute(
      path: '/facility-choice',
      name: 'facility-choice',
      builder: (context, state) => const FacilityChoiceScreen(),
    ),
    
    // Facility Setup Choice
    GoRoute(
      path: '/facility-setup-choice',
      name: 'facility-setup-choice',
      builder: (context, state) => const FacilitySetupChoiceScreen(),
    ),
    
    // Home Facility Setup
    GoRoute(
      path: '/home-facility',
      name: 'home-facility',
      builder: (context, state) => const HomeFacilityScreen(),
    ),
    
    // External Facility Setup
    GoRoute(
      path: '/external-facility',
      name: 'external-facility',
      builder: (context, state) => const ExternalFacilityScreen(),
    ),
    
    // Access Code Entry
    GoRoute(
      path: '/access-code',
      name: 'access-code',
      builder: (context, state) => const AccessCodeEntryScreen(),
    ),
    
    // Facility Setup
    GoRoute(
      path: '/facility-setup',
      name: 'facility-setup',
      builder: (context, state) => const FacilitySetupScreen(),
    ),
    
    // Caregiver Facility Setup
    GoRoute(
      path: '/caregiver-facility-setup',
      name: 'caregiver-facility-setup',
      builder: (context, state) => const CaregiverFacilitySetupScreen(),
    ),

    // ========== PLAN & PAYMENT ROUTES ==========
    
    // Choose Plan
    GoRoute(
      path: '/choose-plan',
      name: 'choose-plan',
      builder: (context, state) => const ChoosePlanScreen(),
    ),
    
    // Plan Selection
    GoRoute(
      path: '/plan-selection',
      name: 'plan-selection',
      builder: (context, state) => const PlanSelectionScreen(),
    ),
    
    // Payment
    GoRoute(
      path: '/payment',
      name: 'payment',
      builder: (context, state) => const PaymentScreen(),
    ),

    // ========== DASHBOARD ROUTES ==========
    
    // Default Dashboard (redirects based on role)
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    
    // Parent Dashboard
    GoRoute(
      path: '/parent-dashboard',
      name: 'parent-dashboard',
      builder: (context, state) => const ParentDashboardScreen(),
    ),
    
    // Staff Dashboard
    GoRoute(
      path: '/staff-dashboard',
      name: 'staff-dashboard',
      builder: (context, state) => const StaffDashboardScreen(),
    ),
    
    // Admin Dashboard
    GoRoute(
      path: '/admin-dashboard',
      name: 'admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),

    // ========== FEATURE ROUTES ==========
    
    // Live Feed
    GoRoute(
      path: '/live-feed',
      name: 'live-feed',
      builder: (context, state) => const LiveFeedScreen(),
    ),
    
    // Live Monitoring
    GoRoute(
      path: '/live-monitoring',
      name: 'live-monitoring',
      builder: (context, state) => const LiveMonitoringScreen(),
    ),
    
    // Notifications
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    
    // Admin Notifications
    GoRoute(
      path: '/admin-notifications',
      name: 'admin-notifications',
      builder: (context, state) => const AdminNotificationsScreen(),
    ),
    
    // Reports
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    
    // Reports AI Insights
    GoRoute(
      path: '/reports-ai-insights',
      name: 'reports-ai-insights',
      builder: (context, state) => const ReportsAiInsightsScreen(),
    ),
    
    // Messages
    GoRoute(
      path: '/messages',
      name: 'messages',
      builder: (context, state) => const MessageScreen(),
    ),
    
    // Profile Detail
    GoRoute(
      path: '/profile/:id',
      name: 'profile-detail',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        // For now, pass a simple map - in production, fetch actual profile data
        return ProfileDetailScreen(
          profile: {
            'id': id,
            'name': 'Profile $id',
          },
        );
      },
    ),

    // ========== SETTINGS ROUTES ==========
    
    // User Settings
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const UserSettingsScreen(),
    ),
    
    // Admin Settings
    GoRoute(
      path: '/admin-settings',
      name: 'admin-settings',
      builder: (context, state) => const AdminSettingsScreen(),
    ),

    // ========== LEGACY/PLACEHOLDER ROUTES ==========
    
    // Session Detail
    GoRoute(
      path: '/sessions/:id',
      name: 'session-detail',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return Scaffold(
          appBar: AppBar(title: Text('Session $id')),
          body: Center(
            child: Text(
              'Session Detail: $id\n\n// TODO: Implement session detail screen',
            ),
          ),
        );
      },
    ),
    
    // Notification Detail
    GoRoute(
      path: '/notification/:id',
      name: 'notification-detail',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return Scaffold(
          appBar: AppBar(title: const Text('Notification')),
          body: Center(
            child: Text(
              'Notification Detail: $id\n\n// TODO: Implement notification detail screen',
            ),
          ),
        );
      },
    ),
    
    // Facility Add
    GoRoute(
      path: '/admin/facilities/new',
      name: 'facility-add',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Add Facility')),
        body: const Center(
          child: Text(
            'Add Facility Screen\n\n// TODO: Implement facility creation form',
          ),
        ),
      ),
    ),
    
    // Facility Detail
    GoRoute(
      path: '/admin/facility/:id',
      name: 'facility-detail',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return Scaffold(
          appBar: AppBar(title: Text('Facility $id')),
          body: Center(
            child: Text(
              'Facility Detail: $id\n\n// TODO: Implement facility detail/edit screen',
            ),
          ),
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7B2CBF), Color(0xFFE91E63)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.white),
            const SizedBox(height: 24),
            const Text(
              '404',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Page not found: ${state.uri.toString()}',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF7B2CBF),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  ),
);
