// Generated from design - TrackPose (source: file:///mnt/data/notifications_screen.png)

// TODO: Add assets to pubspec.yaml: assets/designs/icon_heart.png, assets/designs/icon_warning.png, assets/designs/icon_gear.png
// TODO: Integrate with backend for persistent notification state and mark-read API (Render-managed MySQL).
// TODO: Integrate push notifications service (FCM/APNs) for real-time delivery.
// TODO: Move color/spacing tokens to theme.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design Tokens - TODO: Move to theme.dart
const Color kPageBgGradientStart = Color(0xFFE6F0FF);
const Color kPageBgGradientEnd = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBackgroundWhite = Color(0xFFFFFFFF);
const Color kPositiveCardBg = Color(0xFFEFFCF2);
const Color kPositiveCardBorder = Color(0xFFDFF6E6);
const Color kAttentionCardBg = Color(0xFFFFF7EE);
const Color kAttentionCardBorder = Color(0xFFFFE8D8);
const Color kBadgePurple = Color(0xFFA76BFF);
const Color kUnreadDotPurple = Color(0xFFA76BFF);
const Color kMetaColor = Color(0xFF9CA3AF);
const Color kPositiveTagColor = Color(0xFF00C853);
const Color kAttentionTagColor = Color(0xFFFF8A00);
const Color kSystemTagColor = Color(0xFF4AA3FF);
const Color kTrialBannerBg = Color(0xFFFFF9E6);
const Color kTrialBannerBorder = Color(0xFFFFD700);

const double kPageHorizontalPadding = 20.0;
const double kMaxContentWidth = 920.0;
const double kCardRadius = 16.0;
const double kInnerCardRadius = 14.0;
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;
const double kGapL = 28.0;

const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// Mock Data Model
class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String time;
  final String type; // 'positive', 'attention', 'system'
  bool unread;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    required this.unread,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  String _selectedFilter = 'All Notifications';
  late List<NotificationItem> _notifications;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _notifications = _getMockNotifications();
    _initAnimations();
  }

  void _initAnimations() {
    _animationControllers = [];
    _fadeAnimations = [];
    _slideAnimations = [];

    for (int i = 0; i < _notifications.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
      _animationControllers.add(controller);

      _fadeAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
      );

      _slideAnimations.add(
        Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
      );

      Future.delayed(Duration(milliseconds: i * 80), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<NotificationItem> _getMockNotifications() {
    return [
      NotificationItem(
        id: '1',
        title: 'Ella Joined Playtime',
        body: 'Ella joined playtime at 2:30 PM.',
        time: '2:30 PM',
        type: 'positive',
        unread: true,
      ),
      NotificationItem(
        id: '2',
        title: 'Happy Moment Captured',
        body: 'Emma was detected smiling during arts and crafts activity.',
        time: '1:15 PM',
        type: 'positive',
        unread: true,
      ),
      NotificationItem(
        id: '3',
        title: 'Low Activity Detected',
        body: 'Low activity detected at 3:00 PM.',
        time: '3:00 PM',
        type: 'attention',
        unread: true,
      ),
      NotificationItem(
        id: '4',
        title: 'Camera Zone 2 Offline',
        body: 'Camera Zone 2 offline.',
        time: '12:45 PM',
        type: 'system',
        unread: false,
      ),
      NotificationItem(
        id: '5',
        title: 'Social Interaction',
        body: 'Emma engaged in collaborative play with Lucas and Mia.',
        time: '11:20 AM',
        type: 'positive',
        unread: false,
      ),
      NotificationItem(
        id: '6',
        title: 'Emotional Change Detected',
        body:
            'Mood changed from active to calm during transition to quiet time.',
        time: '10:50 AM',
        type: 'attention',
        unread: false,
      ),
      NotificationItem(
        id: '7',
        title: 'Daily Report Ready',
        body: 'Your daily wellbeing report for Emma is now available.',
        time: '9:00 AM',
        type: 'system',
        unread: false,
      ),
      NotificationItem(
        id: '8',
        title: 'Morning Arrival',
        body: 'Lucas arrived happy and energetic at 8:30 AM.',
        time: '8:30 AM',
        type: 'positive',
        unread: false,
      ),
    ];
  }

  int get _unreadCount => _notifications.where((n) => n.unread).length;

  List<NotificationItem> get _filteredNotifications {
    switch (_selectedFilter) {
      case 'Unread':
        return _notifications.where((n) => n.unread).toList();
      case 'Positive':
        return _notifications.where((n) => n.type == 'positive').toList();
      case 'Attention':
        return _notifications.where((n) => n.type == 'attention').toList();
      case 'System':
        return _notifications.where((n) => n.type == 'system').toList();
      default:
        return _notifications;
    }
  }

  void _markAsRead(String id) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n.id == id);
      notification.unread = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Marked read'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.unread = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked read'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  void _toggleReadStatus(String id) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n.id == id);
      notification.unread = !notification.unread;
    });
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text(
          'Are you sure you want to delete this notification?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteNotification(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = (screenWidth - (kPageHorizontalPadding * 2)).clamp(
      0.0,
      kMaxContentWidth,
    );

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
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTrialBanner(context),
                  const SizedBox(height: kGapM),
                  _buildAppBar(context),
                  const SizedBox(height: kGapM),
                  _buildControls(),
                  const SizedBox(height: kGapL),
                  Expanded(child: _buildNotificationsList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrialBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kTrialBannerBg,
        border: Border.all(color: kTrialBannerBorder, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: kHeadlineColor, size: 20),
          const SizedBox(width: kGapS),
          const Expanded(
            child: Text(
              'Trial: 7 days remaining',
              style: TextStyle(
                color: kHeadlineColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/choose-plan'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: kBadgePurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
            child: const Icon(
              Icons.arrow_back,
              color: kHeadlineColor,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: kGapM),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: kHeadlineColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Stay updated on your loved one\'s day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kSubtextColor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _markAllAsRead,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kBadgePurple, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Mark All Read',
              style: TextStyle(
                color: kBadgePurple,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        Expanded(child: _buildFilterDropdown()),
        const SizedBox(width: kGapS),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: kBadgePurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '$_unreadCount unread',
            style: const TextStyle(
              color: kBadgePurple,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return PopupMenuButton<String>(
      initialValue: _selectedFilter,
      onSelected: (value) {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [kCardShadow],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedFilter,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kHeadlineColor,
              ),
            ),
            const SizedBox(width: kGapXS),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: kSubtextColor,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        'All Notifications',
        'Unread',
        'Positive',
        'Attention',
        'System',
      ].map((filter) {
        return PopupMenuItem<String>(value: filter, child: Text(filter));
      }).toList(),
    );
  }

  Widget _buildNotificationsList() {
    final filteredList = _filteredNotifications;

    if (filteredList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: kSubtextColor),
            SizedBox(height: kGapM),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kSubtextColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: kGapL),
      itemCount: filteredList.length,
      separatorBuilder: (context, index) => const SizedBox(height: kGapM),
      itemBuilder: (context, index) {
        final notification = filteredList[index];
        final originalIndex = _notifications.indexOf(notification);

        if (originalIndex < 0 ||
            originalIndex >= _animationControllers.length) {
          return _buildNotificationCard(notification, index);
        }

        return FadeTransition(
          opacity: _fadeAnimations[originalIndex],
          child: SlideTransition(
            position: _slideAnimations[originalIndex],
            child: _buildNotificationCard(notification, index),
          ),
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        _markAsRead(notification.id);
        return false;
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.check, color: Colors.green, size: 32),
      ),
      child: Semantics(
        label:
            '${notification.title} notification, ${notification.time}, ${_getTypeLabel(notification.type)}',
        child: _NotificationCard(
          notification: notification,
          onTap: () => context.push('/notification/${notification.id}'),
          onLongPress: () => _showNotificationMenu(context, notification),
        ),
      ),
    );
  }

  void _showNotificationMenu(
    BuildContext context,
    NotificationItem notification,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  notification.unread
                      ? Icons.mark_email_read
                      : Icons.mark_email_unread,
                  color: kBadgePurple,
                ),
                title: Text(
                  notification.unread ? 'Mark as Read' : 'Mark as Unread',
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _toggleReadStatus(notification.id);
                },
              ),
              ListTile(
                leading: const Icon(Icons.snooze, color: kSystemTagColor),
                title: const Text('Snooze'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Snoozed for 1 hour')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _showDeleteConfirmation(context, notification.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'positive':
        return 'Positive Event';
      case 'attention':
        return 'Attention';
      case 'system':
        return 'System';
      default:
        return '';
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isHighlighted = notification.unread &&
        (notification.type == 'positive' || notification.type == 'attention');

    Color bgColor = kCardBackgroundWhite;
    Color? borderColor;

    if (isHighlighted) {
      if (notification.type == 'positive') {
        bgColor = kPositiveCardBg;
        borderColor = kPositiveCardBorder;
      } else if (notification.type == 'attention') {
        bgColor = kAttentionCardBg;
        borderColor = kAttentionCardBorder;
      }
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(kCardRadius),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.5)
              : null,
          boxShadow: const [kCardShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconBadge(),
            const SizedBox(width: kGapS),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(),
                  const SizedBox(height: kGapXS),
                  Text(
                    notification.body,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: kHeadlineColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: kGapS),
                  _buildMetaRow(),
                ],
              ),
            ),
            const SizedBox(width: kGapS),
            Column(
              children: [
                if (notification.unread)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: kUnreadDotPurple,
                      shape: BoxShape.circle,
                    ),
                  ),
                const SizedBox(height: 8),
                const Icon(Icons.chevron_right, color: kMetaColor, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBadge() {
    String assetPath;
    switch (notification.type) {
      case 'positive':
        assetPath = 'assets/designs/icon_heart.png';
        break;
      case 'attention':
        assetPath = 'assets/designs/icon_warning.png';
        break;
      case 'system':
        assetPath = 'assets/designs/icon_gear.png';
        break;
      default:
        assetPath = 'assets/designs/icon_heart.png';
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) {
            IconData iconData;
            Color iconColor;
            switch (notification.type) {
              case 'positive':
                iconData = Icons.favorite;
                iconColor = kPositiveTagColor;
                break;
              case 'attention':
                iconData = Icons.warning_amber_rounded;
                iconColor = kAttentionTagColor;
                break;
              case 'system':
                iconData = Icons.settings;
                iconColor = kSystemTagColor;
                break;
              default:
                iconData = Icons.notifications;
                iconColor = kMetaColor;
            }
            return Icon(iconData, color: iconColor, size: 24);
          },
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            notification.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kHeadlineColor,
            ),
          ),
        ),
        if (notification.unread) ...[
          const SizedBox(width: kGapXS),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: kBadgePurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'New',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetaRow() {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 14, color: kMetaColor),
        const SizedBox(width: 4),
        Text(
          notification.time,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: kMetaColor,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('·', style: TextStyle(color: kMetaColor, fontSize: 13)),
        ),
        _TagChip(label: _getTypeLabel(), color: _getTypeColor()),
      ],
    );
  }

  String _getTypeLabel() {
    switch (notification.type) {
      case 'positive':
        return 'Positive Event';
      case 'attention':
        return 'Attention';
      case 'system':
        return 'System';
      default:
        return '';
    }
  }

  Color _getTypeColor() {
    switch (notification.type) {
      case 'positive':
        return kPositiveTagColor;
      case 'attention':
        return kAttentionTagColor;
      case 'system':
        return kSystemTagColor;
      default:
        return kMetaColor;
    }
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
    );
  }
}
