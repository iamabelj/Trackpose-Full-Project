// TrackPose - AI-Powered Wellbeing Monitoring
// Main entry point

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/dashboard_screen.dart';
import                                      ;
import 'screens/caregiver_facility_setup_screen.dart';
import 'screens/live_feed_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/admin_notifications_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/user_settings_screen.dart';
import 'screens/admin_settings_screen.dart';

void main() {
  runApp(const TrackPoseApp());
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
  initialLocation: '/dashboard',
  routes: [
    // Parent Dashboard
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),

    // Admin Dashboard
    GoRoute(
      path: '/admin/dashboard',
      name: 'admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),

    // Facility Setup
    GoRoute(
      path: '/facility-setup',
      name: 'facility-setup',
      builder: (context, state) => const CaregiverFacilitySetupScreen(),
    ),

    // Live Feed
    GoRoute(
      path: '/live-feed',
      name: 'live-feed',
      builder: (context, state) => const LiveFeedScreen(),
    ),

    // Notifications
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),

    // Admin Notifications
    GoRoute(
      path: '/admin/notifications',
      name: 'admin-notifications',
      builder: (context, state) => const AdminNotificationsScreen(),
    ),

    // Reports
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const ReportsScreen(),
    ),

    // User Settings
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const UserSettingsScreen(),
    ),

    // Admin Settings
    GoRoute(
      path: '/admin/settings',
      name: 'admin-settings',
      builder: (context, state) => const AdminSettingsScreen(),
    ),

    // Session Detail (placeholder)
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

    // Notification Detail (placeholder)
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

    // Messages (placeholder)
    GoRoute(
      path: '/messages',
      name: 'messages',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Messages')),
        body: const Center(
          child: Text('Messages Screen\n\n// TODO: Implement messages screen'),
        ),
      ),
    ),

    // Plan Selection (placeholder)
    GoRoute(
      path: '/choose-plan',
      name: 'choose-plan',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Choose Plan')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose Plan Screen\n\n// TODO: Implement plan selection',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                child: const Text('Back to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    ),

    // Facility Add (placeholder)
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

    // Facility Detail (placeholder)
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
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('404: ${state.uri.toString()} not found'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/dashboard'),
            child: const Text('Go to Dashboard'),
          ),
        ],
      ),
    ),
  ),
);
