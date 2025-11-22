// Generated from design - TrackPose (source: file:///mnt/data/live_feed.png)

// TODO: Add assets to pubspec.yaml: assets/designs/live_thumb.png, assets/designs/icon_play_area.png
// TODO: Integrate live video streaming, MediaPipe/TFLite AI processing and backend endpoints (Render-managed MySQL & object storage). Secure tokens in flutter_secure_storage.
// TODO: Move color/spacing tokens to theme.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design Tokens - TODO: Move to theme.dart
const Color kPageBgGradientStart = Color(0xFFE6F0FF);
const Color kPageBgGradientEnd = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBackgroundWhite = Color(0xFFFFFFFF);
const Color kLiveBadgeBg = Color(0xFFE8FBEE);
const Color kLiveDotColor = Color(0xFF00C853);
const Color kAccentBlue = Color(0xFF2B9CFF);
const Color kChipYellow = Color(0xFFFFC857);
const Color kChipBlue = Color(0xFF4AA3FF);
const Color kChipPurple = Color(0xFFA76BFF);
const Color kTimeBadgeBg = Color(0xFF0F1724);
const Color kInputBg = Color(0xFFF3F4F6);
const Color kInsightsCardBg = Color(0xFFE8F5FF);

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
class FeatureChip {
  final String label;
  final Color color;

  FeatureChip({required this.label, required this.color});
}

class TimelineItem {
  final String id;
  final String time;
  final String title;
  final String description;
  final String emoji;

  TimelineItem({
    required this.id,
    required this.time,
    required this.title,
    required this.description,
    required this.emoji,
  });
}

class AlertSetting {
  final String title;
  final String description;
  bool enabled;

  AlertSetting({
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class StatusData {
  final String label;
  final String value;
  final double progress;
  final Color color;

  StatusData({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });
}

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen>
    with TickerProviderStateMixin {
  late AnimationController _cameraCardController;
  late AnimationController _timelineController;
  late AnimationController _statusController;

  String _selectedZone = 'Play Area';
  final List<String> _zones = [
    'Play Area',
    'Reading Area',
    'Nap Zone',
    'Outside'
  ];

  final List<FeatureChip> _featureChips = [
    FeatureChip(label: 'Smiling', color: kChipYellow),
    FeatureChip(label: 'Calm', color: kChipBlue),
    FeatureChip(label: 'Group Activity', color: kChipPurple),
  ];

  final List<TimelineItem> _timelineItems = [
    TimelineItem(
      id: '1',
      time: '09:15',
      title: 'Arrived happy',
      description: 'Emma arrived with a big smile, excited to start the day',
      emoji: '😊',
    ),
    TimelineItem(
      id: '2',
      time: '10:05',
      title: 'Group play started',
      description: 'Happy interaction during group activity',
      emoji: '🎉',
    ),
    TimelineItem(
      id: '3',
      time: '11:15',
      title: 'Snack time',
      description: 'Calm and peaceful during meal',
      emoji: '🍎',
    ),
    TimelineItem(
      id: '4',
      time: '12:00',
      title: 'Story time',
      description: 'Engaged and smiling during reading',
      emoji: '📚',
    ),
    TimelineItem(
      id: '5',
      time: '13:30',
      title: 'Outdoor play',
      description: 'High energy outdoor activities',
      emoji: '⚽',
    ),
    TimelineItem(
      id: '6',
      time: '14:15',
      title: 'Rest period',
      description: 'Peaceful rest time',
      emoji: '😴',
    ),
    TimelineItem(
      id: '7',
      time: '15:00',
      title: 'Arts & crafts',
      description: 'Creative and happy',
      emoji: '🎨',
    ),
  ];

  final List<AlertSetting> _alertSettings = [
    AlertSetting(
      title: 'Emotional Change',
      description: 'Notify on mood shifts',
      enabled: true,
    ),
    AlertSetting(
      title: 'Low Activity',
      description: 'Alert on inactivity',
      enabled: false,
    ),
    AlertSetting(
      title: 'New Events',
      description: 'Notify on new moments',
      enabled: true,
    ),
  ];

  final List<StatusData> _statusData = [
    StatusData(
      label: 'Emotional State',
      value: 'Happy',
      progress: 0.8,
      color: kChipYellow,
    ),
    StatusData(
      label: 'Activity Level',
      value: 'Moderate',
      progress: 0.6,
      color: kChipPurple,
    ),
    StatusData(
      label: 'Social Engagement',
      value: 'High',
      progress: 0.9,
      color: const Color(0xFFFF2E7A),
    ),
  ];

  final List<Map<String, String>> _insights = [
    {
      'title': 'Positive social interactions',
      'description': 'Playing well with others throughout the day',
    },
    {
      'title': 'Balanced energy levels',
      'description': 'Good mix of active and calm periods',
    },
    {
      'title': 'Consistent happiness',
      'description': 'Maintained positive mood all day',
    },
  ];

  @override
  void initState() {
    super.initState();

    _cameraCardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _timelineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _statusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _cameraCardController.forward();
    _timelineController.forward();
    _statusController.forward();
  }

  @override
  void dispose() {
    _cameraCardController.dispose();
    _timelineController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _changeZone(String zone) async {
    setState(() => _selectedZone = zone);
    // TODO: Fetch live stream for selected zone from backend
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Switched to $zone')),
      );
    }
  }

  void _toggleAlertSetting(int index) {
    setState(() {
      _alertSettings[index].enabled = !_alertSettings[index].enabled;
    });
    // TODO: Persist alert preference to backend (Render MySQL)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_alertSettings[index].title} alerts ${_alertSettings[index].enabled ? "enabled" : "disabled"}',
        ),
      ),
    );
  }

  void _showZoneSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Camera Zone',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
                  ),
                ),
              ),
              ..._zones.map((zone) {
                return ListTile(
                  leading: Icon(
                    Icons.videocam,
                    color: zone == _selectedZone ? kAccentBlue : kSubtextColor,
                  ),
                  title: Text(zone),
                  trailing: zone == _selectedZone
                      ? const Icon(Icons.check, color: kAccentBlue)
                      : null,
                  onTap: () {
                    Navigator.pop(ctx);
                    _changeZone(zone);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showThumbnailDetail() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child:
                            Icon(Icons.videocam, size: 64, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Playing live feed...')),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Snapshot captured')),
                        );
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Capture'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
                    _CameraFeedCard(
                      controller: _cameraCardController,
                      selectedZone: _selectedZone,
                      featureChips: _featureChips,
                      onZoneTap: _showZoneSelector,
                      onThumbnailTap: _showThumbnailDetail,
                    ),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Activity Timeline'),
                    const SizedBox(height: kGapM),
                    ..._timelineItems.asMap().entries.map((entry) {
                      return _TimelineItem(
                        item: entry.value,
                        index: entry.key,
                        controller: _timelineController,
                        onTap: () => context.push('/session/${entry.value.id}'),
                      );
                    }),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Alert Settings'),
                    const SizedBox(height: kGapM),
                    ..._alertSettings.asMap().entries.map((entry) {
                      return _AlertToggleRow(
                        setting: entry.value,
                        onToggle: () => _toggleAlertSetting(entry.key),
                      );
                    }),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Current Status'),
                    const SizedBox(height: kGapM),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kCardBackgroundWhite,
                        borderRadius: BorderRadius.circular(kCardRadius),
                        boxShadow: const [kCardShadow],
                      ),
                      child: Column(
                        children: _statusData.asMap().entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: entry.key < _statusData.length - 1
                                  ? kGapM
                                  : 0,
                            ),
                            child: _StatusBar(
                              data: entry.value,
                              controller: _statusController,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Today\'s Insights'),
                    const SizedBox(height: kGapM),
                    _InsightsCard(insights: _insights),
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
                'Live Monitoring',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: kHeadlineColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'AI-powered wellbeing insights',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kSubtextColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: kLiveBadgeBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: kLiveDotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Live',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kLiveDotColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: kHeadlineColor,
      ),
    );
  }
}

class _CameraFeedCard extends StatelessWidget {
  final AnimationController controller;
  final String selectedZone;
  final List<FeatureChip> featureChips;
  final VoidCallback onZoneTap;
  final VoidCallback onThumbnailTap;

  const _CameraFeedCard({
    required this.controller,
    required this.selectedZone,
    required this.featureChips,
    required this.onZoneTap,
    required this.onThumbnailTap,
  });

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
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
                  const Icon(Icons.videocam, color: kAccentBlue, size: 24),
                  const SizedBox(width: kGapS),
                  const Text(
                    'Camera Feed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kHeadlineColor,
                    ),
                  ),
                  const SizedBox(width: kGapS),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kLiveBadgeBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: kLiveDotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Live',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: kLiveDotColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kGapM),
              Row(
                children: [
                  const Text(
                    'Camera Zone',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kSubtextColor,
                    ),
                  ),
                  const SizedBox(width: kGapS),
                  Expanded(
                    child: Semantics(
                      label: 'Zone selector',
                      button: true,
                      child: GestureDetector(
                        onTap: onZoneTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: kInputBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedZone,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kHeadlineColor,
                                  ),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down,
                                  size: 20, color: kSubtextColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kGapM),
              GestureDetector(
                onTap: onThumbnailTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Image.asset(
                            'assets/designs/live_thumb.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.videocam,
                                      size: 64, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: featureChips.map((chip) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: chip.color,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  chip.label,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: kTimeBadgeBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '06:37 PM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kGapS),
              const Text(
                'Monitoring with care',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: kSubtextColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final TimelineItem item;
  final int index;
  final AnimationController controller;
  final VoidCallback onTap;

  const _TimelineItem({
    required this.item,
    required this.index,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          index * 0.1,
          (index * 0.1) + 0.4,
          curve: Curves.easeOut,
        ),
      ),
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          index * 0.1,
          (index * 0.1) + 0.4,
          curve: Curves.easeOut,
        ),
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: kGapS),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kCardBackgroundWhite,
                borderRadius: BorderRadius.circular(kCardRadius),
                boxShadow: const [kCardShadow],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: kInputBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        item.emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: kGapM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.time,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: kAccentBlue,
                              ),
                            ),
                            const SizedBox(width: kGapS),
                            Expanded(
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: kHeadlineColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kSubtextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: kSubtextColor, size: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertToggleRow extends StatelessWidget {
  final AlertSetting setting;
  final VoidCallback onToggle;

  const _AlertToggleRow({
    required this.setting,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kGapS),
      child: Semantics(
        label: '${setting.title} toggle',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: kCardBackgroundWhite,
            borderRadius: BorderRadius.circular(kCardRadius),
            boxShadow: const [kCardShadow],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setting.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: kHeadlineColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      setting.description,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kSubtextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: setting.enabled,
                onChanged: (_) => onToggle(),
                activeThumbColor: kLiveDotColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final StatusData data;
  final AnimationController controller;

  const _StatusBar({
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kHeadlineColor,
              ),
            ),
            Text(
              data.value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: data.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: kGapXS),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: kInputBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: data.progress * animation.value,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: data.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _InsightsCard extends StatelessWidget {
  final List<Map<String, String>> insights;

  const _InsightsCard({required this.insights});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInsightsCardBg,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: const [kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kGapM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: kLiveDotColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
                const SizedBox(width: kGapS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kHeadlineColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight['description']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: kSubtextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
