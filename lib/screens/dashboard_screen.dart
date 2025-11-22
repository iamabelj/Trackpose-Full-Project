// Generated from design - TrackPose (source: file:///mnt/data/dashboard_screen.png)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

// TODO: Add referenced assets to pubspec.yaml
// TODO: Integrate live streaming, MediaPipe/TFLite AI processing and backend endpoints (Render-managed MySQL & object storage)
// TODO: Secure tokens in flutter_secure_storage

// ============================================================================
// DESIGN TOKENS
// ============================================================================
// TODO: move to theme.dart

// Colors
const Color kPageBgStartColor = Color(0xFFE6F0FF);
const Color kPageBgEndColor = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBgColor = Color(0xFFFFFFFF);
const Color kPrimaryGradientStart = Color(0xFF7A3FF2);
const Color kPrimaryGradientEnd = Color(0xFFFF2E7A);
const Color kLiveBadgeBg = Color(0xFFE8FBEE);
const Color kLiveBadgeDot = Color(0xFF00C853);
const Color kChartCalm = Color(0xFF4AA3FF);
const Color kChartHappy = Color(0xFFFFC857);
const Color kChartJoyful = Color(0xFFA76BFF);

// Metrics card tints
const Color kFacilitiesCardBg = Color(0xFFEAF6FF);
const Color kUsersTodayCardBg = Color(0xFFF6F0FF);
const Color kAvgMoodCardBg = Color(0xFFEFFCEC);

// Spacing
const double kPagePadding = 20.0;
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;
const double kGapL = 28.0;

// Radii
const double kCardRadius = 16.0;
const double kSmallRadius = 12.0;

// Shadows
const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// ============================================================================
// MOCK DATA
// ============================================================================

class Child {
  final String id;
  final String name;
  final String initials;
  final String avatarAsset;

  Child({
    required this.id,
    required this.name,
    required this.initials,
    required this.avatarAsset,
  });
}

class LiveSnapshot {
  final String mood;
  final String activity;
  final String socialInteraction;
  final String thumbnailAsset;
  final String time;

  LiveSnapshot({
    required this.mood,
    required this.activity,
    required this.socialInteraction,
    required this.thumbnailAsset,
    required this.time,
  });
}

class Highlight {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  final String thumbnailAsset;
  final String emoji;

  Highlight({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.thumbnailAsset,
    required this.emoji,
  });
}

final List<Child> _mockChildren = [
  Child(
      id: '1',
      name: 'Emma',
      initials: 'E',
      avatarAsset: 'assets/designs/avatar_e.png'),
  Child(
      id: '2',
      name: 'Lucas',
      initials: 'L',
      avatarAsset: 'assets/designs/avatar_l.png'),
  Child(
      id: '3',
      name: 'Mia',
      initials: 'M',
      avatarAsset: 'assets/designs/avatar_m.png'),
];

final Map<String, LiveSnapshot> _mockSnapshots = {
  '1': LiveSnapshot(
    mood: 'Joyful & Engaged',
    activity: 'Group Play',
    socialInteraction: 'Playing with 3 friends',
    thumbnailAsset: 'assets/designs/live_thumb.png',
    time: '2:30 PM',
  ),
  '2': LiveSnapshot(
    mood: 'Happy & Active',
    activity: 'Reading Time',
    socialInteraction: 'Quiet time alone',
    thumbnailAsset: 'assets/designs/live_thumb.png',
    time: '2:30 PM',
  ),
  '3': LiveSnapshot(
    mood: 'Calm & Content',
    activity: 'Arts & Crafts',
    socialInteraction: 'Working with 2 friends',
    thumbnailAsset: 'assets/designs/live_thumb.png',
    time: '2:30 PM',
  ),
};

final List<Highlight> _mockHighlights = [
  Highlight(
    id: 'h1',
    title: 'Joyful Playtime',
    description: 'Emma had a wonderful time during group activities',
    timestamp: '10:15 AM',
    thumbnailAsset: 'assets/designs/highlight1.png',
    emoji: '😊',
  ),
  Highlight(
    id: 'h2',
    title: 'Calm Storytime',
    description: 'Peaceful moment during reading session',
    timestamp: '11:30 AM',
    thumbnailAsset: 'assets/designs/highlight1.png',
    emoji: '📚',
  ),
  Highlight(
    id: 'h3',
    title: 'Creative Activities',
    description: 'Engaged in arts and crafts with friends',
    timestamp: '1:45 PM',
    thumbnailAsset: 'assets/designs/highlight1.png',
    emoji: '🎨',
  ),
];

// Chart mock data (hours 9-16, three emotion series)
final List<double> _mockCalmData = [0.6, 0.7, 0.5, 0.4, 0.3, 0.5, 0.6, 0.7];
final List<double> _mockHappyData = [0.7, 0.8, 0.9, 0.8, 0.7, 0.8, 0.85, 0.9];
final List<double> _mockJoyfulData = [0.5, 0.6, 0.7, 0.9, 0.85, 0.8, 0.75, 0.8];

// ============================================================================
// DASHBOARD SCREEN
// ============================================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _selectedChildIndex = 0;
  late AnimationController _bannerController;
  late AnimationController _chartController;
  bool _isUploadingVideo = false;

  @override
  void initState() {
    super.initState();
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();

    _chartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _chartController.dispose();
    super.dispose();
  }

  Child get _selectedChild => _mockChildren[_selectedChildIndex];
  LiveSnapshot get _currentSnapshot => _mockSnapshots[_selectedChild.id]!;

  Future<void> _handleUploadVideo() async {
    // TODO: Implement file picker and upload to Render object storage
    setState(() => _isUploadingVideo = true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() => _isUploadingVideo = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Video uploaded successfully — Processing started')),
      );
      // TODO: Trigger backend AI processing and navigate to results
    }
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
            colors: [kPageBgStartColor, kPageBgEndColor],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Padding(
                  padding: const EdgeInsets.all(kPagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBanner(context),
                      const SizedBox(height: kGapM),
                      _buildGreetingRow(context),
                      const SizedBox(height: kGapM),
                      _buildChildCarousel(),
                      const SizedBox(height: kGapL),
                      _buildLiveSnapshotCard(),
                      const SizedBox(height: kGapL),
                      _buildHighlightsSection(),
                      const SizedBox(height: kGapL),
                      _buildEmotionalJourneyChart(),
                      const SizedBox(height: kGapL),
                      _buildUtilityCards(),
                      const SizedBox(height: kGapL),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBanner(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _bannerController,
        curve: Curves.easeOut,
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [kPrimaryGradientStart, kPrimaryGradientEnd],
          ),
          borderRadius: BorderRadius.circular(kSmallRadius),
          boxShadow: const [kCardShadow],
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '7 days remaining in your free trial — Upgrade for full access',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: kGapS),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () => context.push('/choose-plan'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Upgrade Now',
                    style: TextStyle(
                      color: kPrimaryGradientStart,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingRow(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good evening, Globullads',
                style: TextStyle(
                  color: kHeadlineColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Here\'s how your loved ones are doing today',
                style: TextStyle(
                  color: kSubtextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, size: 28),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: kPrimaryGradientEnd,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => context.push('/notifications'),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 28),
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }

  Widget _buildChildCarousel() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _mockChildren.length,
        itemBuilder: (context, index) {
          final child = _mockChildren[index];
          final isSelected = index == _selectedChildIndex;

          return Padding(
            padding: const EdgeInsets.only(right: kGapS),
            child: AnimatedScale(
              scale: isSelected ? 1.03 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _selectedChildIndex = index),
                  borderRadius: BorderRadius.circular(kSmallRadius),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: kCardBgColor,
                      borderRadius: BorderRadius.circular(kSmallRadius),
                      border: isSelected
                          ? Border.all(color: kPrimaryGradientStart, width: 2)
                          : null,
                      boxShadow: isSelected ? [kCardShadow] : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              kPrimaryGradientStart.withValues(alpha: 0.2),
                          child: Text(
                            child.initials,
                            style: const TextStyle(
                              color: kPrimaryGradientStart,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          child.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLiveSnapshotCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kCardBgColor,
          borderRadius: BorderRadius.circular(kCardRadius),
          boxShadow: const [kCardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Live Snapshot',
                    style: TextStyle(
                      fontSize: 20,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: kLiveBadgeDot,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
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
                  const Spacer(),
                  const Text(
                    'Current activity and mood',
                    style: TextStyle(
                      fontSize: 12,
                      color: kSubtextColor,
                    ),
                  ),
                ],
              ),
            ),
            _buildSnapshotThumbnail(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatTile(Icons.mood_outlined, 'Current Mood',
                      _currentSnapshot.mood),
                  const SizedBox(height: kGapS),
                  _buildStatTile(Icons.directions_run_outlined, 'Activity',
                      _currentSnapshot.activity),
                  const SizedBox(height: kGapS),
                  _buildStatTile(Icons.people_outline, 'Social Interaction',
                      _currentSnapshot.socialInteraction),
                  const SizedBox(height: kGapM),
                  _buildSnapshotActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapshotThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kSmallRadius),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child:
                    Icon(Icons.videocam_outlined, size: 48, color: Colors.grey),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMoodChip('Happy', kChartHappy),
              const SizedBox(height: 4),
              _buildMoodChip('Playtime', kChartJoyful),
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kHeadlineColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _currentSnapshot.time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPageBgStartColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(kSmallRadius),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: kPrimaryGradientStart),
          const SizedBox(width: kGapS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kSubtextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: kHeadlineColor,
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

  Widget _buildSnapshotActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () => context.push('/live-feed'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kPrimaryGradientStart, kPrimaryGradientEnd],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'View Live Feed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kGapS),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: _isUploadingVideo ? null : _handleUploadVideo,
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimaryGradientStart,
              side: const BorderSide(color: kPrimaryGradientStart),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: _isUploadingVideo
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Upload Video for Analysis',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
        const SizedBox(height: kGapXS),
        const Text(
          'Upload a short video to receive independent AI wellbeing insights.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: kSubtextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Highlights',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kHeadlineColor,
          ),
        ),
        const SizedBox(height: kGapM),
        ..._mockHighlights.asMap().entries.map((entry) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + (entry.key * 80)),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: kGapM),
              child: _buildHighlightCard(entry.value),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHighlightCard(Highlight highlight) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/session/${highlight.id}'),
        borderRadius: BorderRadius.circular(kCardRadius),
        child: Container(
          decoration: BoxDecoration(
            color: kCardBgColor,
            borderRadius: BorderRadius.circular(kCardRadius),
            boxShadow: const [kCardShadow],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kCardRadius),
                      bottomLeft: Radius.circular(kCardRadius),
                    ),
                    child: Container(
                      width: 120,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.photo, size: 32, color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        highlight.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: kHeadlineColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        highlight.timestamp,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        highlight.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kHeadlineColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        highlight.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kSubtextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.chevron_right, color: kSubtextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionalJourneyChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBgColor,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: const [kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Emotional Journey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kHeadlineColor,
            ),
          ),
          const SizedBox(height: kGapM),
          SizedBox(
            height: 200,
            child: AnimatedBuilder(
              animation: _chartController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _EmotionalChartPainter(
                    calmData: _mockCalmData,
                    happyData: _mockHappyData,
                    joyfulData: _mockJoyfulData,
                    animationValue: _chartController.value,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
          const SizedBox(height: kGapM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Calm', kChartCalm),
              const SizedBox(width: kGapM),
              _buildLegendItem('Happy', kChartHappy),
              const SizedBox(width: kGapM),
              _buildLegendItem('Joyful', kChartJoyful),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: kHeadlineColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUtilityCards() {
    return Column(
      children: [
        _buildUtilityCard(
          title: 'Messages',
          subtitle: 'Chat with caregivers',
          icon: Icons.message_outlined,
          onTap: () => context.push('/messages'),
        ),
        const SizedBox(height: kGapM),
        _buildUtilityCard(
          title: 'Reports',
          subtitle: 'View detailed insights',
          icon: Icons.bar_chart_outlined,
          isPro: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Upgrade to Pro to unlock Reports')),
            );
          },
        ),
        const SizedBox(height: kGapM),
        _buildUtilityCard(
          title: 'Notifications',
          subtitle: 'View alerts & updates',
          icon: Icons.notifications_outlined,
          badge: '3',
          onTap: () => context.push('/notifications'),
        ),
      ],
    );
  }

  Widget _buildUtilityCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
    bool isPro = false,
    String? badge,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kCardRadius),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kCardBgColor,
            borderRadius: BorderRadius.circular(kCardRadius),
            boxShadow: const [kCardShadow],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kPrimaryGradientStart, kPrimaryGradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: kGapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kHeadlineColor,
                          ),
                        ),
                        if (isPro) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  kPrimaryGradientStart.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Pro',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryGradientStart,
                              ),
                            ),
                          ),
                        ],
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: kPrimaryGradientEnd,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kSubtextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isPro ? Icons.lock_outline : Icons.chevron_right,
                color: kSubtextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CHART PAINTER
// ============================================================================

class _EmotionalChartPainter extends CustomPainter {
  final List<double> calmData;
  final List<double> happyData;
  final List<double> joyfulData;
  final double animationValue;

  _EmotionalChartPainter({
    required this.calmData,
    required this.happyData,
    required this.joyfulData,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Draw lines
    _drawLine(canvas, size, calmData, kChartCalm, paint);
    _drawLine(canvas, size, happyData, kChartHappy, paint);
    _drawLine(canvas, size, joyfulData, kChartJoyful, paint);

    // Draw x-axis labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 8; i++) {
      final x = size.width * (i / 7);
      textPainter.text = TextSpan(
        text: '${9 + i}',
        style: const TextStyle(
          fontSize: 10,
          color: kSubtextColor,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, size.height + 5));
    }
  }

  void _drawLine(
      Canvas canvas, Size size, List<double> data, Color color, Paint paint) {
    paint.color = color;
    final path = Path();

    for (int i = 0; i < data.length; i++) {
      final x = size.width * (i / (data.length - 1)) * animationValue;
      final y = size.height * (1 - data[i]);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _EmotionalChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
