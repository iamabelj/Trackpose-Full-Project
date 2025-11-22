// Generated from design - TrackPose (source: file:///mnt/data/live_feed.png)

// TODO: Add assets to pubspec.yaml: assets/designs/live_thumb.png, assets/designs/icon_play_area.png
// TODO: Integrate live video streaming, MediaPipe/TFLite AI processing and backend endpoints (Render-managed MySQL & object storage). Secure tokens in flutter_secure_storage.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ============================================================================
// DESIGN TOKENS - TODO: Move to theme.dart
// ============================================================================

// Colors
const Color kBackgroundGradientStart = Color(0xFFE6F0FF);
const Color kBackgroundGradientEnd = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBackground = Color(0xFFFFFFFF);
const Color kLiveBadgeBg = Color(0xFFE8FBEE);
const Color kLiveBadgeDot = Color(0xFF00C853);
const Color kPrimaryGradientStart = Color(0xFF7A3FF2);
const Color kPrimaryGradientEnd = Color(0xFFFF2E7A);
const Color kAccentBlue = Color(0xFF2B9CFF);
const Color kFeatureChipYellow = Color(0xFFFFC857);
const Color kFeatureChipBlue = Color(0xFF4AA3FF);
const Color kFeatureChipPurple = Color(0xFFA76BFF);
const Color kTimeBadgeBg = Color(0xFF0F1724);
const Color kInputBg = Color(0xFFF3F4F6);

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
const double kHeadlineSize = 30.0;
const double kSectionHeadingSize = 18.0;
const double kBodySize = 16.0;

// ============================================================================
// MOCK DATA
// ============================================================================

class CameraZone {
  final String id;
  final String name;
  final String icon;

  const CameraZone({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class FeatureChip {
  final String label;
  final Color color;

  const FeatureChip({required this.label, required this.color});
}

class TimelineItem {
  final String id;
  final String time;
  final String title;
  final String description;
  final String emoji;

  const TimelineItem({
    required this.id,
    required this.time,
    required this.title,
    required this.description,
    required this.emoji,
  });
}

class AlertSetting {
  final String id;
  final String title;
  final String description;
  bool enabled;

  AlertSetting({
    required this.id,
    required this.title,
    required this.description,
    required this.enabled,
  });
}

class StatusMetric {
  final String label;
  final double value;
  final String displayValue;
  final Color color;

  const StatusMetric({
    required this.label,
    required this.value,
    required this.displayValue,
    required this.color,
  });
}

class InsightItem {
  final String title;
  final String description;

  const InsightItem({required this.title, required this.description});
}

const List<CameraZone> kCameraZones = [
  CameraZone(id: 'play_area', name: 'Play Area', icon: '🎮'),
  CameraZone(id: 'reading_area', name: 'Reading Area', icon: '📚'),
  CameraZone(id: 'nap_zone', name: 'Nap Zone', icon: '😴'),
  CameraZone(id: 'outside', name: 'Outside', icon: '🌳'),
];

const List<FeatureChip> kLiveFeatureChips = [
  FeatureChip(label: 'Smiling', color: kFeatureChipYellow),
  FeatureChip(label: 'Calm', color: kFeatureChipBlue),
  FeatureChip(label: 'Group Activity', color: kFeatureChipPurple),
];

const List<TimelineItem> kTimelineItems = [
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
    emoji: '👫',
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
    emoji: '📖',
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

List<AlertSetting> kAlertSettings = [
  AlertSetting(
    id: 'emotional_change',
    title: 'Emotional Change',
    description: 'Notify on mood shifts',
    enabled: true,
  ),
  AlertSetting(
    id: 'low_activity',
    title: 'Low Activity',
    description: 'Alert on inactivity',
    enabled: true,
  ),
  AlertSetting(
    id: 'new_events',
    title: 'New Events',
    description: 'Notify on new moments',
    enabled: false,
  ),
];

const List<StatusMetric> kStatusMetrics = [
  StatusMetric(
    label: 'Emotional State',
    value: 0.8,
    displayValue: 'Happy',
    color: kFeatureChipYellow,
  ),
  StatusMetric(
    label: 'Activity Level',
    value: 0.6,
    displayValue: 'Moderate',
    color: kFeatureChipPurple,
  ),
  StatusMetric(
    label: 'Social Engagement',
    value: 0.9,
    displayValue: 'High',
    color: kPrimaryGradientEnd,
  ),
];

const List<InsightItem> kTodaysInsights = [
  InsightItem(
    title: 'Positive social interactions',
    description: 'Playing well with others throughout the day',
  ),
  InsightItem(
    title: 'Balanced energy levels',
    description: 'Good mix of active and calm periods',
  ),
  InsightItem(
    title: 'Consistent happiness',
    description: 'Maintained positive mood all day',
  ),
];

// ============================================================================
// LIVE FEED SCREEN
// ============================================================================

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen>
    with TickerProviderStateMixin {
  CameraZone _selectedZone = kCameraZones[0];
  final List<AlertSetting> _alertSettings = List.from(kAlertSettings);
  late AnimationController _cameraFeedController;
  late AnimationController _timelineController;
  late AnimationController _statusBarController;

  @override
  void initState() {
    super.initState();
    _cameraFeedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _timelineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _statusBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _cameraFeedController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _timelineController.forward();
        _statusBarController.forward();
      }
    });
  }

  @override
  void dispose() {
    _cameraFeedController.dispose();
    _timelineController.dispose();
    _statusBarController.dispose();
    super.dispose();
  }

  Future<void> _changeZone(CameraZone zone) async {
    setState(() => _selectedZone = zone);
    // TODO: Replace with real API call to switch camera feed
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Switched to ${zone.name}')),
      );
    }
  }

  void _onThumbnailTap() {
    showDialog(
      context: context,
      builder: (context) => _LiveFeedModal(
        zone: _selectedZone,
      ),
    );
  }

  void _onTimelineItemTap(TimelineItem item) {
    context.push('/session/${item.id}');
  }

  void _onToggleAlert(AlertSetting setting, bool value) {
    setState(() {
      setting.enabled = value;
    });
    // TODO: Persist alert preference to backend (Render-managed MySQL)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${setting.title} alerts ${value ? "enabled" : "disabled"}',
        ),
      ),
    );
  }

  void _onChipTap(FeatureChip chip) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(kCardRadiusLarge)),
      ),
      builder: (context) => _ChipExplanationSheet(chip: chip),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contentWidth = math.min(size.width - 40, 920.0);

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
                          _CameraFeedCard(
                            selectedZone: _selectedZone,
                            onZoneChange: _changeZone,
                            onThumbnailTap: _onThumbnailTap,
                            onChipTap: _onChipTap,
                            animationController: _cameraFeedController,
                          ),
                          const SizedBox(height: kGapL),
                          _ActivityTimeline(
                            items: kTimelineItems,
                            onItemTap: _onTimelineItemTap,
                            animationController: _timelineController,
                          ),
                          const SizedBox(height: kGapL),
                          _AlertSettings(
                            settings: _alertSettings,
                            onToggle: _onToggleAlert,
                          ),
                          const SizedBox(height: kGapL),
                          _CurrentStatus(
                            metrics: kStatusMetrics,
                            animationController: _statusBarController,
                          ),
                          const SizedBox(height: kGapL),
                          const _TodaysInsights(insights: kTodaysInsights),
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
                  'Live Monitoring',
                  style: TextStyle(
                    color: kHeadlineColor,
                    fontSize: kHeadlineSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'AI-powered wellbeing insights',
                  style: TextStyle(
                    color: kSubtextColor,
                    fontSize: 14,
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
                    color: kLiveBadgeDot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Live',
                  style: TextStyle(
                    color: kLiveBadgeDot,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
// CAMERA FEED CARD
// ============================================================================

class _CameraFeedCard extends StatelessWidget {
  final CameraZone selectedZone;
  final Function(CameraZone) onZoneChange;
  final VoidCallback onThumbnailTap;
  final Function(FeatureChip) onChipTap;
  final AnimationController animationController;

  const _CameraFeedCard({
    required this.selectedZone,
    required this.onZoneChange,
    required this.onThumbnailTap,
    required this.onChipTap,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        )),
        child: Container(
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kAccentBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.videocam,
                        color: kAccentBlue, size: 24),
                  ),
                  const SizedBox(width: kGapS),
                  const Text(
                    'Camera Feed',
                    style: TextStyle(
                      color: kHeadlineColor,
                      fontSize: kSectionHeadingSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                            color: kLiveBadgeDot,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Live',
                          style: TextStyle(
                            color: kLiveBadgeDot,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kGapM),
              _ZoneSelector(
                selectedZone: selectedZone,
                onZoneChange: onZoneChange,
              ),
              const SizedBox(height: kGapM),
              GestureDetector(
                onTap: onThumbnailTap,
                child: Stack(
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(kCardRadius),
                        image: const DecorationImage(
                          image: AssetImage('assets/designs/live_thumb.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: kGapS,
                      left: kGapS,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: kLiveFeatureChips.map((chip) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: kGapXS),
                            child: GestureDetector(
                              onTap: () => onChipTap(chip),
                              child: _FeatureChipWidget(chip: chip),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      bottom: kGapS,
                      right: kGapS,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: kTimeBadgeBg.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '06:37 PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kGapS),
              const Text(
                'Monitoring with care',
                style: TextStyle(
                  color: kSubtextColor,
                  fontSize: 12,
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

// ============================================================================
// ZONE SELECTOR
// ============================================================================

class _ZoneSelector extends StatelessWidget {
  final CameraZone selectedZone;
  final Function(CameraZone) onZoneChange;

  const _ZoneSelector({
    required this.selectedZone,
    required this.onZoneChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Camera Zone',
          style: TextStyle(
            color: kSubtextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: kGapM),
        Expanded(
          child: GestureDetector(
            onTap: () => _showZonePicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kInputBg,
                borderRadius: BorderRadius.circular(kInputRadius),
              ),
              child: Row(
                children: [
                  Text(
                    selectedZone.icon,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: kGapS),
                  Expanded(
                    child: Text(
                      selectedZone.name,
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
          ),
        ),
      ],
    );
  }

  void _showZonePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(kCardRadiusLarge)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(kGapM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Camera Zone',
              style: TextStyle(
                color: kHeadlineColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: kGapM),
            ...kCameraZones.map((zone) {
              final isSelected = zone.id == selectedZone.id;
              return ListTile(
                leading: Text(
                  zone.icon,
                  style: const TextStyle(fontSize: 28),
                ),
                title: Text(
                  zone.name,
                  style: TextStyle(
                    color: isSelected ? kPrimaryGradientStart : kHeadlineColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle,
                        color: kPrimaryGradientStart)
                    : null,
                onTap: () {
                  onZoneChange(zone);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// FEATURE CHIP WIDGET
// ============================================================================

class _FeatureChipWidget extends StatelessWidget {
  final FeatureChip chip;

  const _FeatureChipWidget({required this.chip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chip.color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chip.color, width: 1.5),
      ),
      child: Text(
        chip.label,
        style: TextStyle(
          color: chip.color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================================
// LIVE FEED MODAL
// ============================================================================

class _LiveFeedModal extends StatelessWidget {
  final CameraZone zone;

  const _LiveFeedModal({required this.zone});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(kGapM),
        decoration: BoxDecoration(
          color: kCardBackground,
          borderRadius: BorderRadius.circular(kCardRadiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '${zone.icon} ${zone.name}',
                  style: const TextStyle(
                    color: kHeadlineColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: kGapM),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(kCardRadius),
                image: const DecorationImage(
                  image: AssetImage('assets/designs/live_thumb.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: kGapM),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ModalButton(
                  icon: Icons.play_arrow,
                  label: 'Play',
                  onPressed: () {
                    // TODO: Implement live stream playback
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Live stream playback')),
                    );
                  },
                ),
                const SizedBox(width: kGapM),
                _ModalButton(
                  icon: Icons.camera_alt,
                  label: 'Snapshot',
                  onPressed: () {
                    // TODO: Capture and save snapshot
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Snapshot captured')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ModalButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kInputRadius),
        ),
      ),
    );
  }
}

// ============================================================================
// CHIP EXPLANATION SHEET
// ============================================================================

class _ChipExplanationSheet extends StatelessWidget {
  final FeatureChip chip;

  const _ChipExplanationSheet({required this.chip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _FeatureChipWidget(chip: chip),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: kGapM),
          Text(
            chip.label,
            style: const TextStyle(
              color: kHeadlineColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: kGapS),
          Text(
            _getChipExplanation(chip.label),
            style: const TextStyle(
              color: kSubtextColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: kGapM),
        ],
      ),
    );
  }

  String _getChipExplanation(String label) {
    switch (label) {
      case 'Smiling':
        return 'AI has detected facial expressions indicating happiness and joy. This is a positive emotional indicator.';
      case 'Calm':
        return 'Current activity shows peaceful, relaxed behavior with low stress markers.';
      case 'Group Activity':
        return 'Multiple individuals detected engaging in collaborative or social interaction.';
      default:
        return 'AI-detected feature from video analysis.';
    }
  }
}

// ============================================================================
// ACTIVITY TIMELINE
// ============================================================================

class _ActivityTimeline extends StatelessWidget {
  final List<TimelineItem> items;
  final Function(TimelineItem) onItemTap;
  final AnimationController animationController;

  const _ActivityTimeline({
    required this.items,
    required this.onItemTap,
    required this.animationController,
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
          const Text(
            'Activity Timeline',
            style: TextStyle(
              color: kHeadlineColor,
              fontSize: kSectionHeadingSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kGapM),
          ...items.asMap().entries.map((entry) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + (entry.key * 80)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(20 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: kGapS),
                child: _TimelineItemWidget(
                  item: entry.value,
                  onTap: () => onItemTap(entry.value),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineItemWidget extends StatelessWidget {
  final TimelineItem item;
  final VoidCallback onTap;

  const _TimelineItemWidget({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kGapS),
        decoration: BoxDecoration(
          color: kInputBg,
          borderRadius: BorderRadius.circular(kInputRadius),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  item.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: kGapS),
            Text(
              item.time,
              style: const TextStyle(
                color: kSubtextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: kGapS),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: kHeadlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item.description,
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
// ALERT SETTINGS
// ============================================================================

class _AlertSettings extends StatelessWidget {
  final List<AlertSetting> settings;
  final Function(AlertSetting, bool) onToggle;

  const _AlertSettings({
    required this.settings,
    required this.onToggle,
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
          const Text(
            'Alert Settings',
            style: TextStyle(
              color: kHeadlineColor,
              fontSize: kSectionHeadingSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kGapM),
          ...settings.map((setting) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kGapS),
              child: _AlertToggleRow(
                setting: setting,
                onToggle: (value) => onToggle(setting, value),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AlertToggleRow extends StatelessWidget {
  final AlertSetting setting;
  final Function(bool) onToggle;

  const _AlertToggleRow({
    required this.setting,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapS),
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(kInputRadius),
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
                    color: kHeadlineColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  setting.description,
                  style: const TextStyle(
                    color: kSubtextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: setting.enabled,
            onChanged: onToggle,
            activeThumbColor: kFeatureChipPurple,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CURRENT STATUS
// ============================================================================

class _CurrentStatus extends StatelessWidget {
  final List<StatusMetric> metrics;
  final AnimationController animationController;

  const _CurrentStatus({
    required this.metrics,
    required this.animationController,
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
          const Text(
            'Current Status',
            style: TextStyle(
              color: kHeadlineColor,
              fontSize: kSectionHeadingSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kGapM),
          ...metrics.map((metric) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kGapM),
              child: _StatusBar(
                metric: metric,
                animationController: animationController,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final StatusMetric metric;
  final AnimationController animationController;

  const _StatusBar({
    required this.metric,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              metric.label,
              style: const TextStyle(
                color: kSubtextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              metric.displayValue,
              style: TextStyle(
                color: metric.color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: kGapXS),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: metric.value * animationController.value,
                backgroundColor: metric.color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(metric.color),
                minHeight: 8,
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================================
// TODAY'S INSIGHTS
// ============================================================================

class _TodaysInsights extends StatelessWidget {
  final List<InsightItem> insights;

  const _TodaysInsights({required this.insights});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kLiveBadgeBg,
        borderRadius: BorderRadius.circular(kCardRadiusLarge),
        border:
            Border.all(color: kLiveBadgeDot.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.insights, color: kLiveBadgeDot, size: 24),
              SizedBox(width: kGapS),
              Text(
                'Today\'s Insights',
                style: TextStyle(
                  color: kHeadlineColor,
                  fontSize: kSectionHeadingSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: kGapM),
          ...insights.map((insight) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kGapS),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      color: kLiveBadgeDot, size: 20),
                  const SizedBox(width: kGapS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insight.title,
                          style: const TextStyle(
                            color: kHeadlineColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          insight.description,
                          style: const TextStyle(
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
          }),
        ],
      ),
    );
  }
}
