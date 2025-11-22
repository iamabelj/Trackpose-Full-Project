// Generated from design - TrackPose (source: file:///mnt/data/admin_settings_screen.png)

// TODO: Add assets to pubspec.yaml: assets/designs/icon_notifications.png, assets/designs/icon_privacy.png, assets/designs/icon_support.png
// TODO: Persist settings server-side using Render-managed MySQL and secure tokens; implement GDPR export and erasure endpoint.
// TODO: Implement support chat backend and entitlement checks (Stripe + Render).

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

// ============================================================================
// DESIGN TOKENS - TODO: Move to theme.dart
// ============================================================================

// Colors
const Color kBackgroundGradientStart = Color(0xFFE6F0FF);
const Color kBackgroundGradientEnd = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBackground = Color(0xFFFFFFFF);
const Color kPrimaryGradientStart = Color(0xFF7A3FF2);
const Color kPrimaryGradientEnd = Color(0xFFFF2E7A);
const Color kToggleAccent = Color(0xFFA76BFF);
const Color kInfoPanelBlueBg = Color(0xFFF1F8FF);
const Color kInfoPanelPurpleBg = Color(0xFFF7F0FF);
const Color kBadgePurple = Color(0xFFA76BFF);
const Color kSuccessGreen = Color(0xFF00C853);
const Color kSuccessGreenBg = Color(0xFFE8FBEE);

// Spacing
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;
const double kGapL = 28.0;
const double kPagePadding = 20.0;

// Radii
const double kCardRadius = 16.0;
const double kCardRadiusLarge = 20.0;
const double kInputRadius = 12.0;

// Shadows
const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// Font sizes
const double kHeadlineSize = 28.0;
const double kSectionHeadingSize = 18.0;
const double kBodySize = 16.0;

// ============================================================================
// MOCK DATA
// ============================================================================

class NotificationPreference {
  final String id;
  final String title;
  final String description;
  bool enabled;

  NotificationPreference({
    required this.id,
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class PrivacySetting {
  final String id;
  final String title;
  final String description;
  bool enabled;

  PrivacySetting({
    required this.id,
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class Facility {
  final String id;
  final String name;
  final List<String> tags;
  final String status;
  final String primaryContact;
  final String lastSync;

  const Facility({
    required this.id,
    required this.name,
    required this.tags,
    required this.status,
    required this.primaryContact,
    required this.lastSync,
  });
}

class FaqItem {
  final String id;
  final String question;
  final String answer;
  final bool isPopular;

  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
    this.isPopular = false,
  });
}

class ResourceItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const ResourceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

List<NotificationPreference> kNotificationPreferences = [
  NotificationPreference(
    id: 'emotional_change',
    title: 'Emotional Change Alerts',
    description: 'Get notified when mood patterns change significantly',
    enabled: true,
  ),
  NotificationPreference(
    id: 'activity',
    title: 'Activity Alerts',
    description: 'Notifications for rich/fail activities and milestones',
    enabled: true,
  ),
  NotificationPreference(
    id: 'messages',
    title: 'Message Notifications',
    description: 'Alerts for new messages from caregivers and staff',
    enabled: true,
  ),
  NotificationPreference(
    id: 'reports',
    title: 'Daily & Weekly Reports',
    description: 'Get automated wellbeing summaries and insights',
    enabled: false,
  ),
  NotificationPreference(
    id: 'system',
    title: 'System Notifications',
    description: 'Updates about app status, cameras, connectivity',
    enabled: true,
  ),
  NotificationPreference(
    id: 'live',
    title: 'Real-Time Live Alerts',
    description: 'Instant notification during live monitoring',
    enabled: true,
  ),
];

List<PrivacySetting> kPrivacySettings = [
  PrivacySetting(
    id: 'report_sharing',
    title: 'Allow Report Sharing',
    description: 'Share selected reports with other family members',
    enabled: true,
  ),
  PrivacySetting(
    id: 'photo_saves',
    title: 'Allow Photo Saves',
    description: 'Enable saving photos from highlights & alerts',
    enabled: true,
  ),
  PrivacySetting(
    id: 'ai_processing',
    title: 'AI Emotion Processing',
    description: 'Allow on-device or server-side AI to analyze videos',
    enabled: true,
  ),
  PrivacySetting(
    id: 'extended_family',
    title: 'Share with Extended Family',
    description: 'Share aggregate insights with extended family',
    enabled: false,
  ),
];

const List<Facility> kLinkedFacilities = [
  Facility(
    id: '1',
    name: 'Sunny Days Care Center',
    tags: ['Daycare'],
    status: 'Active',
    primaryContact: 'admin@sunnydayscare.com',
    lastSync: '2 mins ago',
  ),
  Facility(
    id: '2',
    name: 'Rainbow Play Center',
    tags: ['Soft Play'],
    status: 'Active',
    primaryContact: 'contact@rainbowplay.com',
    lastSync: '5 mins ago',
  ),
];

const List<FaqItem> kFaqItems = [
  FaqItem(
    id: '1',
    question: 'How accurate is the emotion detection?',
    answer:
        'Our AI achieves 92–95% accuracy in detecting primary Emotional & Behavioral Insights using MediaPipe and TensorFlow Lite. However, AI is a tool to support caregivers, not replace human judgment and care.',
    isPopular: true,
  ),
  FaqItem(
    id: '2',
    question: 'Is the data secure and private?',
    answer:
        'Yes. All data is encrypted at rest and in transit using industry-standard protocols. We comply with GDPR and store data in Render-managed MySQL with strict access controls.',
  ),
  FaqItem(
    id: '3',
    question: 'How does real-time monitoring work?',
    answer:
        'Our system processes video feeds in real-time using on-device and cloud-based AI models to detect emotional states, activities, and safety events.',
  ),
  FaqItem(
    id: '4',
    question: 'How does TrackPose benefit staff and caregivers?',
    answer:
        'TrackPose reduces documentation burden, provides actionable insights, and helps staff focus on quality care rather than manual observation logs.',
  ),
  FaqItem(
    id: '5',
    question: 'How easy is it to set up and use?',
    answer:
        'Setup takes less than 10 minutes. Simply connect your cameras, configure zones, and start monitoring. Our intuitive interface requires minimal training.',
  ),
  FaqItem(
    id: '6',
    question: 'What are the pricing options?',
    answer:
        'We offer flexible plans starting with a 7-day free trial, followed by monthly or annual subscriptions. Contact us for facility-wide pricing.',
  ),
  FaqItem(
    id: '7',
    question: 'Do staff need special training to use TrackPose?',
    answer:
        'No special training is required. Basic orientation takes 15–20 minutes, and our support team is available to assist.',
  ),
  FaqItem(
    id: '8',
    question: 'Does TrackPose integrate with other systems?',
    answer:
        'Yes, TrackPose integrates with popular facility management systems and can export data in standard formats.',
  ),
];

const List<ResourceItem> kResourceItems = [
  ResourceItem(
    id: 'privacy',
    title: 'Privacy Policy',
    description: 'How we protect your data',
    icon: Icons.privacy_tip,
  ),
  ResourceItem(
    id: 'terms',
    title: 'Terms of Service',
    description: 'Usage guidelines',
    icon: Icons.description,
  ),
  ResourceItem(
    id: 'guide',
    title: 'User Guide',
    description: 'Complete documentation',
    icon: Icons.menu_book,
  ),
  ResourceItem(
    id: 'safety',
    title: 'Safety Guidelines',
    description: 'Best practices',
    icon: Icons.security,
  ),
];

// ============================================================================
// ADMIN SETTINGS SCREEN
// ============================================================================

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen>
    with TickerProviderStateMixin {
  final List<NotificationPreference> _notificationPrefs =
      List.from(kNotificationPreferences);
  final List<PrivacySetting> _privacySettings = List.from(kPrivacySettings);
  final List<Facility> _facilities = List.from(kLinkedFacilities);
  String _themeMode = 'Light';
  final String _dataRetention = '90 Days (Recommended)';
  final Map<String, bool> _faqExpanded = {};

  late AnimationController _sectionController;

  @override
  void initState() {
    super.initState();
    _sectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _sectionController.forward();
  }

  @override
  void dispose() {
    _sectionController.dispose();
    super.dispose();
  }

  void _toggleNotification(NotificationPreference pref, bool value) {
    setState(() {
      pref.enabled = value;
    });
    // TODO: Persist to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${pref.title} ${value ? "enabled" : "disabled"}')),
    );
  }

  void _togglePrivacy(PrivacySetting setting, bool value) {
    setState(() {
      setting.enabled = value;
    });
    // TODO: Persist to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy setting saved')),
    );
  }

  Future<void> _downloadData() async {
    // TODO: Implement GDPR data export via backend
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Your data export is ready — check your email')),
      );
    }
  }

  void _removeFacility(Facility facility) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Facility'),
        content: Text('Are you sure you want to remove ${facility.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _facilities.removeWhere((f) => f.id == facility.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${facility.name} removed')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out of TrackPose?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Clear flutter_secure_storage tokens
              Navigator.pop(context);
              context.go('/auth/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contentWidth = math.min(size.width - 40, 1100.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kBackgroundGradientStart, kBackgroundGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _AppBarRow(onBackPressed: () => context.pop()),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: kGapM),
                          _NotificationPreferences(
                            preferences: _notificationPrefs,
                            onToggle: _toggleNotification,
                          ),
                          const SizedBox(height: kGapL),
                          _PrivacyDataSharing(
                            settings: _privacySettings,
                            dataRetention: _dataRetention,
                            onToggle: _togglePrivacy,
                            onDownloadData: _downloadData,
                          ),
                          const SizedBox(height: kGapL),
                          _ThemePreference(
                            selectedTheme: _themeMode,
                            onThemeChanged: (theme) {
                              setState(() => _themeMode = theme);
                            },
                          ),
                          const SizedBox(height: kGapL),
                          _LinkedFacilities(
                            facilities: _facilities,
                            onRemove: _removeFacility,
                          ),
                          const SizedBox(height: kGapL),
                          _FrequentlyAskedQuestions(
                            faqItems: kFaqItems,
                            expandedMap: _faqExpanded,
                            onToggle: (id, expanded) {
                              setState(() {
                                _faqExpanded[id] = expanded;
                              });
                            },
                          ),
                          const SizedBox(height: kGapL),
                          const _ResourcesDocumentation(
                            resources: kResourceItems,
                          ),
                          const SizedBox(height: kGapL),
                          _SignOutButton(onSignOut: _signOut),
                          const SizedBox(height: kGapL * 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// APP BAR ROW
// ============================================================================

class _AppBarRow extends StatelessWidget {
  final VoidCallback onBackPressed;

  const _AppBarRow({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPagePadding, vertical: kGapM),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: onBackPressed,
            tooltip: 'Go back',
          ),
          const SizedBox(width: kGapS),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings & Support',
                  style: TextStyle(
                    color: kHeadlineColor,
                    fontSize: kHeadlineSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manage preferences and get help',
                  style: TextStyle(
                    color: kSubtextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// NOTIFICATION PREFERENCES
// ============================================================================

class _NotificationPreferences extends StatelessWidget {
  final List<NotificationPreference> preferences;
  final Function(NotificationPreference, bool) onToggle;

  const _NotificationPreferences({
    required this.preferences,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Notification Preferences',
      subtitle: 'Choose what alerts you want to receive',
      icon: Icons.notifications_outlined,
      child: Column(
        children: preferences.map((pref) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kGapS),
            child: _ToggleRow(
              title: pref.title,
              description: pref.description,
              value: pref.enabled,
              onChanged: (value) => onToggle(pref, value),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================================
// PRIVACY & DATA SHARING
// ============================================================================

class _PrivacyDataSharing extends StatelessWidget {
  final List<PrivacySetting> settings;
  final String dataRetention;
  final Function(PrivacySetting, bool) onToggle;
  final VoidCallback onDownloadData;

  const _PrivacyDataSharing({
    required this.settings,
    required this.dataRetention,
    required this.onToggle,
    required this.onDownloadData,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Privacy & Data Sharing',
      icon: Icons.privacy_tip_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(kGapM),
            decoration: BoxDecoration(
              color: kInfoPanelBlueBg,
              borderRadius: BorderRadius.circular(kCardRadius),
              border: Border.all(
                  color: kPrimaryGradientStart.withValues(alpha: 0.2)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline,
                    color: kPrimaryGradientStart, size: 24),
                SizedBox(width: kGapS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Privacy is Our Priority',
                        style: TextStyle(
                          color: kHeadlineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'TrackPose is committed to protecting your data and your loved ones\' privacy. All data is encrypted and stored securely with limited access (Render-managed storage).',
                        style: TextStyle(
                          color: kSubtextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kGapM),
          ...settings.map((setting) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kGapS),
              child: _ToggleRow(
                title: setting.title,
                description: setting.description,
                value: setting.enabled,
                onChanged: (value) => onToggle(setting, value),
              ),
            );
          }),
          const SizedBox(height: kGapM),
          const Text(
            'Data Retention Period',
            style: TextStyle(
              color: kHeadlineColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kGapS),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: kInfoPanelBlueBg,
              borderRadius: BorderRadius.circular(kInputRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    dataRetention,
                    style: const TextStyle(
                      color: kHeadlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: kSubtextColor),
              ],
            ),
          ),
          const SizedBox(height: kGapM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onDownloadData,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kPrimaryGradientStart, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kInputRadius),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download, color: kPrimaryGradientStart, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Download: All My Data',
                    style: TextStyle(
                      color: kPrimaryGradientStart,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// THEME PREFERENCE
// ============================================================================

class _ThemePreference extends StatelessWidget {
  final String selectedTheme;
  final Function(String) onThemeChanged;

  const _ThemePreference({
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Theme Preference',
      icon: Icons.palette_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ThemeOption(
                  title: 'Light Mode',
                  description: 'Bright and clear interface',
                  icon: Icons.light_mode,
                  isSelected: selectedTheme == 'Light',
                  onTap: () => onThemeChanged('Light'),
                ),
              ),
              const SizedBox(width: kGapM),
              Expanded(
                child: _ThemeOption(
                  title: 'Dark Mode',
                  description: 'Easy on the eyes at night',
                  icon: Icons.dark_mode,
                  isSelected: selectedTheme == 'Dark',
                  onTap: () => onThemeChanged('Dark'),
                  isDisabled: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: kGapS),
          const Text(
            'Dark mode is currently in development and will be available in a future update.',
            style: TextStyle(
              color: kSubtextColor,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDisabled;

  const _ThemeOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(kGapM),
        decoration: BoxDecoration(
          color: isSelected
              ? kToggleAccent.withValues(alpha: 0.1)
              : kInfoPanelBlueBg,
          borderRadius: BorderRadius.circular(kCardRadius),
          border: Border.all(
            color: isSelected ? kToggleAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isDisabled ? kSubtextColor : kToggleAccent,
              size: 32,
            ),
            const SizedBox(height: kGapS),
            Text(
              title,
              style: TextStyle(
                color: isDisabled ? kSubtextColor : kHeadlineColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kSubtextColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// LINKED FACILITIES
// ============================================================================

class _LinkedFacilities extends StatelessWidget {
  final List<Facility> facilities;
  final Function(Facility) onRemove;

  const _LinkedFacilities({
    required this.facilities,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Linked Facilities',
      icon: Icons.business,
      action: TextButton(
        onPressed: () => context.push('/facilities/add'),
        child: const Text('+ Add Facility'),
      ),
      child: Column(
        children: facilities.map((facility) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kGapM),
            child: _FacilityCard(
              facility: facility,
              onRemove: () => onRemove(facility),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final Facility facility;
  final VoidCallback onRemove;

  const _FacilityCard({
    required this.facility,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kInfoPanelBlueBg,
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  facility.name,
                  style: const TextStyle(
                    color: kHeadlineColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kSuccessGreenBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  facility.status,
                  style: const TextStyle(
                    color: kSuccessGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kGapXS),
          Wrap(
            spacing: 8,
            children: facility.tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: kToggleAccent.withValues(alpha: 0.1),
                labelStyle: const TextStyle(
                  color: kToggleAccent,
                  fontSize: 12,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: kGapS),
          Text(
            'Primary contact: ${facility.primaryContact}',
            style: const TextStyle(
              color: kSubtextColor,
              fontSize: 14,
            ),
          ),
          Text(
            'Last sync: ${facility.lastSync}',
            style: const TextStyle(
              color: kSubtextColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: kGapS),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      context.push('/facilities/${facility.id}/manage'),
                  child: const Text('Manage'),
                ),
              ),
              const SizedBox(width: kGapS),
              Expanded(
                child: OutlinedButton(
                  onPressed: onRemove,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// FREQUENTLY ASKED QUESTIONS
// ============================================================================

class _FrequentlyAskedQuestions extends StatelessWidget {
  final List<FaqItem> faqItems;
  final Map<String, bool> expandedMap;
  final Function(String, bool) onToggle;

  const _FrequentlyAskedQuestions({
    required this.faqItems,
    required this.expandedMap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Frequently Asked Questions',
      subtitle: 'Everything you need to know about TrackPose AI',
      icon: Icons.help_outline,
      child: Column(
        children: [
          ...faqItems.map((faq) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kGapS),
              child: _FaqItemWidget(
                faq: faq,
                isExpanded: expandedMap[faq.id] ?? false,
                onToggle: (expanded) => onToggle(faq.id, expanded),
              ),
            );
          }),
          const SizedBox(height: kGapM),
          Container(
            padding: const EdgeInsets.all(kGapM),
            decoration: BoxDecoration(
              color: kInfoPanelPurpleBg,
              borderRadius: BorderRadius.circular(kCardRadius),
            ),
            child: Column(
              children: [
                const Text(
                  'Still need help?',
                  style: TextStyle(
                    color: kHeadlineColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: kGapM),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement email support
                        },
                        child: const Text('Email Support'),
                      ),
                    ),
                    const SizedBox(width: kGapS),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.push('/support/chat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryGradientStart,
                        ),
                        child: const Text('Live Chat'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItemWidget extends StatelessWidget {
  final FaqItem faq;
  final bool isExpanded;
  final Function(bool) onToggle;

  const _FaqItemWidget({
    required this.faq,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kInfoPanelBlueBg,
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                faq.question,
                style: const TextStyle(
                  color: kHeadlineColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (faq.isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: kBadgePurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Most Popular',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        onExpansionChanged: onToggle,
        children: [
          Padding(
            padding: const EdgeInsets.all(kGapM),
            child: Text(
              faq.answer,
              style: const TextStyle(
                color: kSubtextColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RESOURCES & DOCUMENTATION
// ============================================================================

class _ResourcesDocumentation extends StatelessWidget {
  final List<ResourceItem> resources;

  const _ResourcesDocumentation({required this.resources});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Resources & Documentation',
      icon: Icons.library_books,
      child: Column(
        children: resources.map((resource) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kGapS),
            child: _ResourceRow(resource: resource),
          );
        }).toList(),
      ),
    );
  }
}

class _ResourceRow extends StatelessWidget {
  final ResourceItem resource;

  const _ResourceRow({required this.resource});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Open resource
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening ${resource.title}')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(kGapM),
        decoration: BoxDecoration(
          color: kInfoPanelBlueBg,
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        child: Row(
          children: [
            Icon(resource.icon, color: kToggleAccent, size: 24),
            const SizedBox(width: kGapM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    style: const TextStyle(
                      color: kHeadlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    resource.description,
                    style: const TextStyle(
                      color: kSubtextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: kSubtextColor),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SIGN OUT BUTTON
// ============================================================================

class _SignOutButton extends StatelessWidget {
  final VoidCallback onSignOut;

  const _SignOutButton({required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onSignOut,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kInputRadius),
          ),
        ),
        child: const Text(
          'Sign Out of TrackPose',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// REUSABLE WIDGETS
// ============================================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;
  final Widget? action;

  const _SectionCard({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(kCardRadiusLarge),
        boxShadow: const [kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kToggleAccent, size: 28),
              const SizedBox(width: kGapS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kHeadlineColor,
                        fontSize: kSectionHeadingSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          color: kSubtextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: kGapM),
          child,
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final Function(bool) onChanged;

  const _ToggleRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kInfoPanelBlueBg,
        borderRadius: BorderRadius.circular(kInputRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: kHeadlineColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: kSubtextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: kToggleAccent,
          ),
        ],
      ),
    );
  }
}
