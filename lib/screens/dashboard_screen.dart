// Generated from design - TrackPose (source: file:///mnt/data/dashboard_screen.png)

// TODO: Add referenced assets to pubspec.yaml
// TODO: Integrate live streaming, MediaPipe/TFLite AI processing and backend endpoints (Render-managed MySQL & object storage)
// TODO: Secure tokens in flutter_secure_storage
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
const Color kChartCalmColor = Color(0xFF4AA3FF);
const Color kChartHappyColor = Color(0xFFFFC857);
const Color kChartJoyfulColor = Color(0xFFA76BFF);

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

class Highlight {
  final String id;
  final String title;
  final String description;
  final String thumbnailAsset;
  final String timestamp;
  final String emoji;

  Highlight({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailAsset,
    required this.timestamp,
    required this.emoji,
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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _bannerController;
  late Animation<Offset> _bannerSlideAnimation;

  int _selectedChildIndex = 0;
  bool _isLoadingFeed = false;
  bool _isUploadingVideo = false;

  final List<Child> _children = [
    Child(
      id: '1',
      name: 'Emma',
      initials: 'E',
      avatarAsset: 'assets/designs/avatar_e.png',
    ),
    Child(
      id: '2',
      name: 'Lucas',
      initials: 'L',
      avatarAsset: 'assets/designs/avatar_l.png',
    ),
    Child(
      id: '3',
      name: 'Mia',
      initials: 'M',
      avatarAsset: 'assets/designs/avatar_m.png',
    ),
  ];

  final Map<String, LiveSnapshot> _liveSnapshots = {
    '1': LiveSnapshot(
      mood: 'Joyful & Engaged',
      activity: 'Group Play',
      socialInteraction: 'Playing with 3 friends',
      thumbnailAsset: 'assets/designs/live_thumb.png',
      time: '2:30 PM',
    ),
    '2': LiveSnapshot(
      mood: 'Calm & Focused',
      activity: 'Reading Time',
      socialInteraction: 'Independent activity',
      thumbnailAsset: 'assets/designs/live_thumb.png',
      time: '2:30 PM',
    ),
    '3': LiveSnapshot(
      mood: 'Happy & Creative',
      activity: 'Art & Crafts',
      socialInteraction: 'Working with 2 friends',
      thumbnailAsset: 'assets/designs/live_thumb.png',
      time: '2:30 PM',
    ),
  };

  final List<Highlight> _highlights = [
    Highlight(
      id: '1',
      title: 'Joyful Playtime',
      description: 'Emma had an energetic play session with friends',
      thumbnailAsset: 'assets/designs/highlight1.png',
      timestamp: '10:15 AM',
      emoji: '😊',
    ),
    Highlight(
      id: '2',
      title: 'Calm Storytime',
      description: 'Peaceful moment during group reading activity',
      thumbnailAsset: 'assets/designs/highlight2.png',
      timestamp: '11:30 AM',
      emoji: '📚',
    ),
    Highlight(
      id: '3',
      title: 'Creative Activities',
      description: 'Engaged in focused arts and crafts session',
      thumbnailAsset: 'assets/designs/highlight3.png',
      timestamp: '1:45 PM',
      emoji: '🎨',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _bannerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOut,
    ));
    _bannerController.forward();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  LiveSnapshot get _currentSnapshot {
    return _liveSnapshots[_children[_selectedChildIndex].id]!;
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Future<void> _handleViewLiveFeed() async {
    setState(() => _isLoadingFeed = true);
    // TODO: Initialize streaming connection to backend
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoadingFeed = false);
    if (mounted) {
      context.push('/live-feed');
    }
  }

  Future<void> _handleUploadVideo() async {
    setState(() => _isUploadingVideo = true);
    // TODO: Open file picker, upload to Render object storage, trigger AI analysis
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isUploadingVideo = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video uploaded successfully')),
      );
    }
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
                    SlideTransition(
                      position: _bannerSlideAnimation,
                      child: _TopBanner(
                        onUpgradeTap: () => context.push('/choose-plan'),
                      ),
                    ),
                    const SizedBox(height: kGapM),
                    _buildGreetingRow(),
                    const SizedBox(height: kGapL),
                    _ChildCarousel(
                      children: _children,
                      selectedIndex: _selectedChildIndex,
                      onChildSelected: (index) {
                        setState(() => _selectedChildIndex = index);
                      },
                    ),
                    const SizedBox(height: kGapL),
                    _LiveSnapshotCard(
                      snapshot: _currentSnapshot,
                      childName: _children[_selectedChildIndex].name,
                      isLoadingFeed: _isLoadingFeed,
                      isUploadingVideo: _isUploadingVideo,
                      onViewLiveFeed: _handleViewLiveFeed,
                      onUploadVideo: _handleUploadVideo,
                    ),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Today\'s Highlights'),
                    const SizedBox(height: kGapM),
                    ..._highlights.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: kGapM),
                        child: _HighlightCard(
                          highlight: entry.value,
                          index: entry.key,
                          onTap: () =>
                              context.push('/session/${entry.value.id}'),
                        ),
                      );
                    }),
                    const SizedBox(height: kGapL),
                    const _EmotionalChart(),
                    const SizedBox(height: kGapL),
                    _buildSectionHeading('Quick Actions'),
                    const SizedBox(height: kGapM),
                    _UtilityCard(
                      icon: Icons.message_outlined,
                      title: 'Messages',
                      subtitle: 'Chat with caregivers',
                      onTap: () => context.push('/messages'),
                    ),
                    const SizedBox(height: kGapS),
                    _UtilityCard(
                      icon: Icons.assessment_outlined,
                      title: 'Reports',
                      subtitle: 'View detailed insights',
                      isLocked: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Upgrade to Pro to unlock Reports')),
                        );
                      },
                    ),
                    const SizedBox(height: kGapS),
                    _UtilityCard(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'View alerts & updates',
                      onTap: () => context.push('/notifications'),
                    ),
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

  Widget _buildGreetingRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()}, Globullads',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: kHeadlineColor,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Here\'s how your loved ones are doing today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kSubtextColor,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, size: 24),
          color: kHeadlineColor,
          onPressed: () => context.push('/notifications'),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 24),
          color: kHeadlineColor,
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }

  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: kHeadlineColor,
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  final VoidCallback onUpgradeTap;

  const _TopBanner({required this.onUpgradeTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: kPrimaryGradientColors),
        borderRadius: BorderRadius.circular(12),
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
          GestureDetector(
            onTap: onUpgradeTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(
                  color: Color(0xFF7A3FF2),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChildCarousel extends StatefulWidget {
  final List<Child> children;
  final int selectedIndex;
  final Function(int) onChildSelected;

  const _ChildCarousel({
    required this.children,
    required this.selectedIndex,
    required this.onChildSelected,
  });

  @override
  State<_ChildCarousel> createState() => _ChildCarouselState();
}

class _ChildCarouselState extends State<_ChildCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.children.length,
        separatorBuilder: (context, index) => const SizedBox(width: kGapM),
        itemBuilder: (context, index) {
          final child = widget.children[index];
          final isSelected = index == widget.selectedIndex;

          return Semantics(
            label: 'Select child ${child.name}',
            button: true,
            child: GestureDetector(
              onTap: () => widget.onChildSelected(index),
              child: AnimatedScale(
                scale: isSelected ? 1.03 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: const Color(0xFF7A3FF2), width: 3)
                        : null,
                    boxShadow: isSelected ? [kCardShadow] : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            const Color(0xFF7A3FF2).withValues(alpha: 0.1),
                        child: Text(
                          child.initials,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7A3FF2),
                          ),
                        ),
                      ),
                      const SizedBox(height: kGapXS),
                      Text(
                        child.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: kHeadlineColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LiveSnapshotCard extends StatefulWidget {
  final LiveSnapshot snapshot;
  final String childName;
  final bool isLoadingFeed;
  final bool isUploadingVideo;
  final VoidCallback onViewLiveFeed;
  final VoidCallback onUploadVideo;

  const _LiveSnapshotCard({
    required this.snapshot,
    required this.childName,
    required this.isLoadingFeed,
    required this.isUploadingVideo,
    required this.onViewLiveFeed,
    required this.onUploadVideo,
  });

  @override
  State<_LiveSnapshotCard> createState() => _LiveSnapshotCardState();
}

class _LiveSnapshotCardState extends State<_LiveSnapshotCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.6,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _slideAnimations = List.generate(4, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.6,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBackgroundWhite,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: const [kCardShadow],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          const SizedBox(height: 4),
          const Text(
            'Current activity and mood',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: kSubtextColor,
            ),
          ),
          const SizedBox(height: kGapM),
          FadeTransition(
            opacity: _fadeAnimations[0],
            child: SlideTransition(
              position: _slideAnimations[0],
              child: _buildThumbnail(),
            ),
          ),
          const SizedBox(height: kGapM),
          FadeTransition(
            opacity: _fadeAnimations[1],
            child: SlideTransition(
              position: _slideAnimations[1],
              child: _StatTile(
                icon: Icons.sentiment_satisfied_alt,
                title: 'Current Mood',
                value: widget.snapshot.mood,
              ),
            ),
          ),
          const SizedBox(height: kGapS),
          FadeTransition(
            opacity: _fadeAnimations[2],
            child: SlideTransition(
              position: _slideAnimations[2],
              child: _StatTile(
                icon: Icons.directions_run,
                title: 'Activity',
                value: widget.snapshot.activity,
              ),
            ),
          ),
          const SizedBox(height: kGapS),
          FadeTransition(
            opacity: _fadeAnimations[3],
            child: SlideTransition(
              position: _slideAnimations[3],
              child: _StatTile(
                icon: Icons.people_outline,
                title: 'Social Interaction',
                value: widget.snapshot.socialInteraction,
              ),
            ),
          ),
          const SizedBox(height: kGapL),
          _buildCTAs(),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return Semantics(
      label: 'Live snapshot image for ${widget.childName}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey.shade200,
                child: Image.asset(
                  widget.snapshot.thumbnailAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child:
                            Icon(Icons.videocam, size: 48, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Row(
                children: [
                  _buildMoodChip('Happy'),
                  const SizedBox(width: kGapXS),
                  _buildMoodChip('Playtime'),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.snapshot.time,
                  style: const TextStyle(
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
    );
  }

  Widget _buildMoodChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: kHeadlineColor,
        ),
      ),
    );
  }

  Widget _buildCTAs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          label: 'View Live Feed button',
          button: true,
          child: GestureDetector(
            onTap: widget.isLoadingFeed ? null : widget.onViewLiveFeed,
            child: AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: kPrimaryGradientColors),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: widget.isLoadingFeed
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'View Live Feed',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kGapS),
        Semantics(
          label: 'Upload Video for Analysis button',
          button: true,
          child: GestureDetector(
            onTap: widget.isUploadingVideo ? null : widget.onUploadVideo,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF7A3FF2), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: widget.isUploadingVideo
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF7A3FF2)),
                        ),
                      )
                    : const Text(
                        'Upload Video for Analysis',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7A3FF2),
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kGapXS),
        const Text(
          'Upload a short video to receive independent AI wellbeing insights.',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: kSubtextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: const Color(0xFF7A3FF2).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF7A3FF2), size: 20),
          ),
          const SizedBox(width: kGapS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kSubtextColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
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

class _HighlightCard extends StatefulWidget {
  final Highlight highlight;
  final int index;
  final VoidCallback onTap;

  const _HighlightCard({
    required this.highlight,
    required this.index,
    required this.onTap,
  });

  @override
  State<_HighlightCard> createState() => _HighlightCardState();
}

class _HighlightCardState extends State<_HighlightCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: kCardBackgroundWhite,
              borderRadius: BorderRadius.circular(kCardRadius),
              boxShadow: const [kCardShadow],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kCardRadius),
                    bottomLeft: Radius.circular(kCardRadius),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade200,
                        child: Image.asset(
                          widget.highlight.thumbnailAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.image,
                                    size: 32, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.highlight.emoji,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.highlight.timestamp,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.highlight.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kHeadlineColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.highlight.description,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kSubtextColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12, top: 50),
                  child:
                      Icon(Icons.chevron_right, color: kSubtextColor, size: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmotionalChart extends StatefulWidget {
  const _EmotionalChart();

  @override
  State<_EmotionalChart> createState() => _EmotionalChartState();
}

class _EmotionalChartState extends State<_EmotionalChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<double> _calmData = [3.0, 3.5, 4.0, 4.2, 3.8, 3.5, 3.0, 2.8];
  final List<double> _happyData = [4.0, 4.5, 5.0, 5.5, 5.8, 6.0, 5.5, 5.0];
  final List<double> _joyfulData = [2.0, 2.5, 3.5, 4.0, 5.0, 5.5, 6.5, 7.0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Daily Emotional Journey chart',
      child: Container(
        decoration: BoxDecoration(
          color: kCardBackgroundWhite,
          borderRadius: BorderRadius.circular(kCardRadius),
          boxShadow: const [kCardShadow],
        ),
        padding: const EdgeInsets.all(20),
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
            const SizedBox(height: kGapL),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: _ChartPainter(
                    calmData: _calmData,
                    happyData: _happyData,
                    joyfulData: _joyfulData,
                    progress: _animation.value,
                  ),
                );
              },
            ),
            const SizedBox(height: kGapM),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Calm', kChartCalmColor),
        const SizedBox(width: kGapM),
        _buildLegendItem('Happy', kChartHappyColor),
        const SizedBox(width: kGapM),
        _buildLegendItem('Joyful', kChartJoyfulColor),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: kSubtextColor,
          ),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> calmData;
  final List<double> happyData;
  final List<double> joyfulData;
  final double progress;

  _ChartPainter({
    required this.calmData,
    required this.happyData,
    required this.joyfulData,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw axes
    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);

    // Draw time labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final times = ['9AM', '10', '11', '12PM', '1', '2', '3', '4'];
    for (int i = 0; i < times.length; i++) {
      final x = (size.width / (times.length - 1)) * i;
      textPainter.text = TextSpan(
        text: times[i],
        style: const TextStyle(
          fontSize: 10,
          color: kSubtextColor,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, size.height + 8));
    }

    // Draw lines
    _drawLine(canvas, size, calmData, kChartCalmColor, paint);
    _drawLine(canvas, size, happyData, kChartHappyColor, paint);
    _drawLine(canvas, size, joyfulData, kChartJoyfulColor, paint);
  }

  void _drawLine(
      Canvas canvas, Size size, List<double> data, Color color, Paint paint) {
    paint.color = color;
    final path = Path();

    for (int i = 0; i < data.length; i++) {
      final x = (size.width / (data.length - 1)) * i;
      final y = size.height - (data[i] / 10.0 * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Animate path drawing
    final pathMetrics = path.computeMetrics();
    final metric = pathMetrics.first;
    final extractPath = metric.extractPath(0, metric.length * progress);

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(_ChartPainter oldDelegate) =>
      progress != oldDelegate.progress;
}

class _UtilityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLocked;
  final VoidCallback onTap;

  const _UtilityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF7A3FF2).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF7A3FF2), size: 28),
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
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: kHeadlineColor,
                        ),
                      ),
                      if (isLocked) ...[
                        const SizedBox(width: kGapXS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: kPrimaryGradientColors),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Pro',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kSubtextColor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: kSubtextColor, size: 24),
          ],
        ),
      ),
    );
  }
}
