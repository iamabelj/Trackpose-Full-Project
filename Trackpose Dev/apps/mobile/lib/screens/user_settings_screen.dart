// Generated from design - TrackPose (source: file:///mnt/data/user_settings_screen.png)

// TODO: Add assets to pubspec.yaml: assets/designs/icon_notifications.png, assets/designs/icon_privacy.png, assets/designs/icon_theme.png
// TODO: Persist settings server-side using Render-managed MySQL and secure tokens; implement GDPR delete endpoint and data export on the backend.
// TODO: Integrate support chat backend and email support provider.
// TODO: Move color/spacing tokens to theme.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design Tokens - TODO: Move to theme.dart
const Color kPageBgGradientStart = Color(0xFFE6F0FF);
const Color kPageBgGradientEnd = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBackgroundWhite = Color(0xFFFFFFFF);
const Color kToggleAccent = Color(0xFFA76BFF);
const Color kSuccessGreen = Color(0xFF00C853);
const Color kSuccessBg = Color(0xFFE8FBEE);
const Color kPrivacyPanelBg = Color(0xFFE8F5FF);
const Color kFaqPanelBg = Color(0xFFF3E8FF);
const Color kDangerRed = Color(0xFFEF4444);

const List<Color> kPrimaryGradientColors = [
  Color(0xFF7A3FF2),
  Color(0xFFFF2E7A)
];

const double kPageHorizontalPadding = 20.0;
const double kMaxContentWidth = 920.0;
const double kCardRadius = 16.0;
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;
const double kGapL = 28.0;

const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// Mock Data Models
class NotificationPreference {
  String title;
  String description;
  bool enabled;

  NotificationPreference({
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class PrivacyToggle {
  String title;
  String description;
  bool enabled;

  PrivacyToggle({
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class Facility {
  final String id;
  final String name;
  final String tag;
  final String status;
  final String primaryContact;
  final String lastSync;

  Facility({
    required this.id,
    required this.name,
    required this.tag,
    required this.status,
    required this.primaryContact,
    required this.lastSync,
  });
}

class FaqItem {
  final String question;
  final String answer;
  final bool isPopular;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isPopular = false,
    this.isExpanded = false,
  });
}

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _cardControllers;

  String _selectedTheme = 'Light';
  final String _dataRetentionPeriod = '90 Days (Recommended)';

  final List<NotificationPreference> _notificationPrefs = [
    NotificationPreference(
      title: 'Emotional Change Alerts',
      description: 'Get notified when mood patterns change significantly',
      enabled: true,
    ),
    NotificationPreference(
      title: 'Activity Alerts',
      description: 'Notifications for rich/fail activities and milestones',
      enabled: true,
    ),
    NotificationPreference(
      title: 'Message Notifications',
      description: 'Alerts for new messages from caregivers and staff',
      enabled: true,
    ),
    NotificationPreference(
      title: 'Daily & Weekly Reports',
      description: 'Get automated wellbeing summaries and insights',
      enabled: false,
    ),
    NotificationPreference(
      title: 'System Notifications',
      description: 'Updates about app status, cameras, connectivity',
      enabled: true,
    ),
    NotificationPreference(
      title: 'Real-Time Live Alerts',
      description: 'Instant notification during live monitoring',
      enabled: true,
    ),
  ];

  final List<PrivacyToggle> _privacyToggles = [
    PrivacyToggle(
      title: 'Allow Report Sharing',
      description: 'Share selected reports with other family members',
      enabled: true,
    ),
    PrivacyToggle(
      title: 'Allow Photo Saves',
      description: 'Enable saving photos from highlights & alerts',
      enabled: true,
    ),
    PrivacyToggle(
      title: 'AI Emotion Processing',
      description: 'Allow on-device or server-side AI to analyze videos',
      enabled: true,
    ),
    PrivacyToggle(
      title: 'Share with Extended Family',
      description: 'Share aggregate insights with extended family',
      enabled: false,
    ),
  ];

  final List<Facility> _facilities = [
    Facility(
      id: '1',
      name: 'Sunny Days Care Center',
      tag: 'Daycare',
      status: 'Active',
      primaryContact: 'Jane Smith',
      lastSync: '2 hours ago',
    ),
    Facility(
      id: '2',
      name: 'Rainbow Play Center',
      tag: 'Soft Play',
      status: 'Active',
      primaryContact: 'Mike Johnson',
      lastSync: '5 hours ago',
    ),
  ];

  final List<FaqItem> _faqs = [
    FaqItem(
      question: 'How accurate is the emotion detection?',
      answer:
          'Our AI-powered emotion detection uses advanced machine learning models trained on thousands of hours of video data, achieving over 90% accuracy in controlled environments.',
      isPopular: true,
    ),
    FaqItem(
      question: 'Is the data secure and private?',
      answer:
          'Yes, all data is encrypted end-to-end and stored on secure Render-managed servers with industry-standard security protocols.',
    ),
    FaqItem(
      question: 'How does real-time monitoring work?',
      answer:
          'Our system processes video feeds in real-time using edge computing and cloud AI to provide instant insights and alerts.',
    ),
    FaqItem(
      question: 'How does TrackPose benefit staff and caregivers?',
      answer:
          'TrackPose helps staff identify children who need attention, track engagement patterns, and improve care quality with data-driven insights.',
    ),
    FaqItem(
      question: 'How easy is it to set up and use?',
      answer:
          'Setup takes less than 30 minutes. Simply mount cameras, connect to WiFi, and start monitoring through our intuitive app.',
    ),
    FaqItem(
      question: 'What are the pricing options?',
      answer:
          'We offer flexible plans starting from a 7-day free trial, followed by monthly or annual subscriptions with Pro features.',
    ),
    FaqItem(
      question: 'Do staff need special training to use TrackPose?',
      answer:
          'No special training required. Our interface is intuitive and we provide comprehensive onboarding materials and support.',
    ),
    FaqItem(
      question: 'Does TrackPose integrate with other systems?',
      answer:
          'Yes, we offer API integrations with popular childcare management systems and support custom integrations upon request.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _cardControllers = List.generate(
      6,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    for (int i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 80), () {
        if (mounted) _cardControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleNotificationPref(int index) {
    setState(() {
      _notificationPrefs[index].enabled = !_notificationPrefs[index].enabled;
    });
    // TODO: Persist to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preference saved')),
    );
  }

  void _togglePrivacySetting(int index) {
    setState(() {
      _privacyToggles[index].enabled = !_privacyToggles[index].enabled;
    });
    // TODO: Persist to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preference saved')),
    );
  }

  void _removeFacility(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Facility'),
        content: const Text(
            'Are you sure you want to remove this facility? You can reconnect it later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _facilities.removeWhere((f) => f.id == id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Facility removed')),
              );
            },
            child: const Text('Remove', style: TextStyle(color: kDangerRed)),
          ),
        ],
      ),
    );
  }

  void _showAddFacilityModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Facility',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
                  ),
                ),
                const SizedBox(height: kGapL),
                ListTile(
                  leading: const Icon(Icons.home, color: kToggleAccent),
                  title: const Text('Own Home Facility'),
                  subtitle: const Text('Set up monitoring at home'),
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/facility-setup/home');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business, color: kToggleAccent),
                  title: const Text('Connect to Facility'),
                  subtitle: const Text('Link with an existing facility'),
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/facility-setup/connect');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadData() async {
    // TODO: Implement server-side data export and GDPR erasure endpoint
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preparing data export...')),
    );
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Your data export is ready — check your email')),
      );
    }
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Clear secure storage
              context.go('/auth/login');
            },
            child: const Text('Sign Out', style: TextStyle(color: kDangerRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = (screenWidth - (kPageHorizontalPadding * 2))
        .clamp(0.0, kMaxContentWidth);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPageBgGradientStart, kPageBgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kGapM),
                    _buildAppBar(),
                    const SizedBox(height: kGapL),
                    _buildAnimatedCard(0, _buildNotificationPreferences()),
                    const SizedBox(height: kGapM),
                    _buildAnimatedCard(1, _buildPrivacySettings()),
                    const SizedBox(height: kGapM),
                    _buildAnimatedCard(2, _buildThemePreference()),
                    const SizedBox(height: kGapM),
                    _buildAnimatedCard(3, _buildLinkedFacilities()),
                    const SizedBox(height: kGapM),
                    _buildAnimatedCard(4, _buildFAQ()),
                    const SizedBox(height: kGapM),
                    _buildAnimatedCard(5, _buildResources()),
                    const SizedBox(height: kGapL),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(int index, Widget child) {
    if (index >= _cardControllers.length) return child;

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardControllers[index], curve: Curves.easeOut),
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _cardControllers[index], curve: Curves.easeOut));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.arrow_back, color: kHeadlineColor, size: 24),
          ),
        ),
        const SizedBox(width: kGapM),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings & Support',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: kHeadlineColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage preferences and get help',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kSubtextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationPreferences() {
    return _SectionCard(
      title: 'Notification Preferences',
      subtitle: 'Choose what alerts you want to receive',
      child: Column(
        children: _notificationPrefs.asMap().entries.map((entry) {
          return _ToggleRow(
            title: entry.value.title,
            description: entry.value.description,
            value: entry.value.enabled,
            onChanged: (_) => _toggleNotificationPref(entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return _SectionCard(
      title: 'Privacy & Data Sharing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kPrivacyPanelBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Privacy is Our Priority',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
                  ),
                ),
                SizedBox(height: kGapS),
                Text(
                  'TrackPose is committed to protecting your data and your loved ones\' privacy. All data is encrypted and stored securely with limited access (Render-managed storage).',
                  style: TextStyle(
                    fontSize: 14,
                    color: kSubtextColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kGapM),
          ..._privacyToggles.asMap().entries.map((entry) {
            return _ToggleRow(
              title: entry.value.title,
              description: entry.value.description,
              value: entry.value.enabled,
              onChanged: (_) => _togglePrivacySetting(entry.key),
            );
          }),
          const SizedBox(height: kGapM),
          const Text(
            'Data Retention Period',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kHeadlineColor,
            ),
          ),
          const SizedBox(height: kGapS),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _dataRetentionPeriod,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kHeadlineColor,
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
            child: OutlinedButton.icon(
              onPressed: _downloadData,
              icon: const Icon(Icons.download),
              label: const Text('Download All My Data'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemePreference() {
    return _SectionCard(
      title: 'Theme Preference',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ThemeOption(
            title: 'Light Mode',
            description: 'Bright and clear interface',
            isSelected: _selectedTheme == 'Light',
            onTap: () => setState(() => _selectedTheme = 'Light'),
          ),
          const SizedBox(height: kGapS),
          _ThemeOption(
            title: 'Dark Mode',
            description: 'Easy on the eyes at night',
            isSelected: _selectedTheme == 'Dark',
            onTap: () => setState(() => _selectedTheme = 'Dark'),
          ),
          const SizedBox(height: kGapM),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: Colors.orange),
                SizedBox(width: kGapS),
                Expanded(
                  child: Text(
                    'Dark mode is currently in development and will be available in a future update.',
                    style: TextStyle(
                      fontSize: 13,
                      color: kHeadlineColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedFacilities() {
    return _SectionCard(
      title: 'Linked Facilities',
      trailing: GestureDetector(
        onTap: _showAddFacilityModal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: kPrimaryGradientColors),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '+ Add Facility',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Column(
        children: _facilities.map((facility) {
          return _FacilityCard(
            facility: facility,
            onManage: () {
              // TODO: Navigate to facility management
              context.push('/facility/${facility.id}/manage');
            },
            onRemove: () => _removeFacility(facility.id),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFAQ() {
    return _SectionCard(
      title: 'Frequently Asked Questions',
      subtitle: 'Everything you need to know about TrackPose AI',
      child: Column(
        children: [
          ..._faqs.map((faq) {
            return _FaqItem(
              faq: faq,
              onExpansionChanged: (expanded) {
                setState(() {
                  faq.isExpanded = expanded;
                });
              },
            );
          }),
          const SizedBox(height: kGapL),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kFaqPanelBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Still have questions?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
                  ),
                ),
                const SizedBox(height: kGapM),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Integrate email support
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opening email...')),
                          );
                        },
                        icon: const Icon(Icons.email_outlined),
                        label: const Text('Email Support'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: kGapS),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Integrate live chat
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Starting live chat...')),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline,
                            color: Colors.white),
                        label: const Text('Live Chat'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: kToggleAccent,
                        ),
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

  Widget _buildResources() {
    return _SectionCard(
      title: 'Resources & Documentation',
      child: Column(
        children: [
          _ResourceRow(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            description: 'How we protect your data',
            onTap: () => context.push('/privacy-policy'),
          ),
          _ResourceRow(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            description: 'Usage guidelines',
            onTap: () => context.push('/terms'),
          ),
          _ResourceRow(
            icon: Icons.menu_book_outlined,
            title: 'User Guide',
            description: 'Complete documentation',
            onTap: () => context.push('/user-guide'),
          ),
          _ResourceRow(
            icon: Icons.security_outlined,
            title: 'Safety Guidelines',
            description: 'Best practices',
            onTap: () => context.push('/safety-guidelines'),
          ),
          const SizedBox(height: kGapL),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _signOut,
              icon: const Icon(Icons.logout, color: kDangerRed),
              label: const Text('Sign Out of TrackPose'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                foregroundColor: kDangerRed,
                side: const BorderSide(color: kDangerRed),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  const _SectionCard({
    required this.title,
    this.subtitle,
    this.trailing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBackgroundWhite,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: const [kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kHeadlineColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kSubtextColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
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
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title toggle, ${value ? "enabled" : "disabled"}',
      child: Padding(
        padding: const EdgeInsets.only(bottom: kGapS),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kHeadlineColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kSubtextColor,
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
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? kToggleAccent.withValues(alpha: 0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? kToggleAccent : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? kToggleAccent : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? kToggleAccent : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: kGapM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? kToggleAccent : kHeadlineColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kSubtextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final Facility facility;
  final VoidCallback onManage;
  final VoidCallback onRemove;

  const _FacilityCard({
    required this.facility,
    required this.onManage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kGapM),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kHeadlineColor,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kSuccessBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    facility.status,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: kSuccessGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kGapS),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kToggleAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    facility.tag,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kToggleAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kGapS),
            Text(
              'Primary Contact: ${facility.primaryContact}',
              style: const TextStyle(
                fontSize: 13,
                color: kSubtextColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Last Sync: ${facility.lastSync}',
              style: const TextStyle(
                fontSize: 13,
                color: kSubtextColor,
              ),
            ),
            const SizedBox(height: kGapM),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onManage,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Manage'),
                  ),
                ),
                const SizedBox(width: kGapS),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRemove,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      foregroundColor: kDangerRed,
                      side: const BorderSide(color: kDangerRed),
                    ),
                    child: const Text('Remove'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final FaqItem faq;
  final ValueChanged<bool> onExpansionChanged;

  const _FaqItem({
    required this.faq,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kGapS),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    faq.question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kHeadlineColor,
                    ),
                  ),
                ),
                if (faq.isPopular) ...[
                  const SizedBox(width: kGapS),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kToggleAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Most Popular',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            onExpansionChanged: onExpansionChanged,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  faq.answer,
                  style: const TextStyle(
                    fontSize: 14,
                    color: kSubtextColor,
                    height: 1.5,
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

class _ResourceRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ResourceRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kGapS),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kToggleAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: kToggleAccent, size: 20),
              ),
              const SizedBox(width: kGapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kHeadlineColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kSubtextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: kSubtextColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
