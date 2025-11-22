// Generated from design - TrackPose (source: file:///mnt/data/notifications_screen.png)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Add assets to pubspec.yaml: assets/designs/icon_heart.png, assets/designs/icon_warning.png, assets/designs/icon_gear.png
// TODO: Integrate with backend for persistent notification state and mark-read API (Render-managed MySQL).

// ============================================================================
// DESIGN TOKENS - TODO: move to theme.dart
// ============================================================================

const Color kPageBgStartColor = Color(0xFFE6F0FF);
const Color kPageBgEndColor = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBgColor = Color(0xFFFFFFFF);
const Color kPositiveCardBg = Color(0xFFEFFCF2);
const Color kPositiveCardBorder = Color(0xFFDFF6E6);
const Color kAttentionCardBg = Color(0xFFFFF7EE);
const Color kAttentionCardBorder = Color(0xFFFFE8D8);
const Color kSystemCardBorder = Color(0xFFF3F4F6);
const Color kNewBadgeColor = Color(0xFFA76BFF);
const Color kUnreadDotColor = Color(0xFFA76BFF);
const Color kMetaColor = Color(0xFF9CA3AF);
const Color kPositiveTagColor = Color(0xFF00C853);
const Color kAttentionTagColor = Color(0xFFFF8A00);
const Color kSystemTagColor = Color(0xFF4AA3FF);

const double kCardRadius = 16.0;
const double kSmallRadius = 12.0;
const double kPagePadding = 20.0;
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;

const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// ============================================================================
// DATA MODELS & MOCKS
// ============================================================================

enum NotificationType { positive, attention, system }

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String time;
  final NotificationType type;
  bool isUnread;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.isUnread = false,
  });
}

final List<NotificationItem> _mockNotifications = [
  NotificationItem(
    id: '1',
    title: 'Ella Joined Playtime',
    body: 'Ella joined playtime at 2:30 PM.',
    time: '2:30 PM',
    type: NotificationType.positive,
    isUnread: true,
  ),
  NotificationItem(
    id: '2',
    title: 'Happy Moment Captured',
    body: 'Emma was detected smiling during arts and crafts activity.',
    time: '1:15 PM',
    type: NotificationType.positive,
    isUnread: true,
  ),
  NotificationItem(
    id: '3',
    title: 'Low Activity Detected',
    body: 'Low activity detected at 3:00 PM.',
    time: '3:00 PM',
    type: NotificationType.attention,
    isUnread: true,
  ),
  NotificationItem(
    id: '4',
    title: 'Camera Zone 2 Offline',
    body: 'Camera Zone 2 offline.',
    time: '12:45 PM',
    type: NotificationType.system,
    isUnread: false,
  ),
  NotificationItem(
    id: '5',
    title: 'Social Interaction',
    body: 'Emma engaged in collaborative play with Lucas and Mia.',
    time: '11:20 AM',
    type: NotificationType.positive,
    isUnread: false,
  ),
  NotificationItem(
    id: '6',
    title: 'Emotional Change Detected',
    body: 'Mood changed from active to calm during transition to quiet time.',
    time: '10:50 AM',
    type: NotificationType.attention,
    isUnread: false,
  ),
  NotificationItem(
    id: '7',
    title: 'Daily Report Ready',
    body: 'Your daily wellbeing report for Emma is now available.',
    time: '9:00 AM',
    type: NotificationType.system,
    isUnread: false,
  ),
  NotificationItem(
    id: '8',
    title: 'Morning Arrival',
    body: 'Lucas arrived happy and energetic at 8:30 AM.',
    time: '8:30 AM',
    type: NotificationType.positive,
    isUnread: false,
  ),
];

// ============================================================================
// NOTIFICATIONS SCREEN
// ============================================================================

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  late List<NotificationItem> _notifications;
  String _selectedFilter = 'All Notifications';

  @override
  void initState() {
    super.initState();
    _notifications = List.from(_mockNotifications);
  }

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  List<NotificationItem> get _filteredNotifications {
    switch (_selectedFilter) {
      case 'Unread':
        return _notifications.where((n) => n.isUnread).toList();
      case 'Positive':
        return _notifications
            .where((n) => n.type == NotificationType.positive)
            .toList();
      case 'Attention':
        return _notifications
            .where((n) => n.type == NotificationType.attention)
            .toList();
      case 'System':
        return _notifications
            .where((n) => n.type == NotificationType.system)
            .toList();
      default:
        return _notifications;
    }
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isUnread = false;
      }
    });
    // TODO: Call backend API to mark read
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Marked read')),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isUnread = false;
      }
    });
    // TODO: Call backend API to mark all read
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked read')),
    );
  }

  void _deleteNotification(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content:
            const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _notifications.removeWhere((n) => n.id == id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification deleted')),
        );
      }
    }
  }

  void _toggleReadStatus(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isUnread = !_notifications[index].isUnread;
      }
    });
    // TODO: Call backend API
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              _buildAppBar(),
              _buildControls(),
              Expanded(
                child: _filteredNotifications.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(kPagePadding),
                        itemCount: _filteredNotifications.length,
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration:
                                Duration(milliseconds: 300 + (index * 80)),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: _buildNotificationCard(
                              _filteredNotifications[index],
                              index,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(kPagePadding),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: kGapS),
          const Expanded(
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: kHeadlineColor,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _markAllAsRead,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: kNewBadgeColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Mark All Read',
                  style: TextStyle(
                    color: kNewBadgeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPagePadding, vertical: kGapS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stay updated on your loved one\'s day',
            style: TextStyle(
              fontSize: 16,
              color: kSubtextColor,
            ),
          ),
          const SizedBox(height: kGapM),
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(),
              ),
              const SizedBox(width: kGapS),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: kNewBadgeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_unreadCount unread',
                  style: const TextStyle(
                    color: kNewBadgeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kGapM),
                  const Text(
                    'Filter Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(height: 32),
                  ...[
                    'All Notifications',
                    'Unread',
                    'Positive',
                    'Attention',
                    'System'
                  ].map((filter) => ListTile(
                        title: Text(filter),
                        trailing: _selectedFilter == filter
                            ? const Icon(Icons.check, color: kNewBadgeColor)
                            : null,
                        onTap: () {
                          setState(() => _selectedFilter = filter);
                          Navigator.pop(context);
                        },
                      )),
                  const SizedBox(height: kGapM),
                ],
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedFilter,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kHeadlineColor,
                  ),
                ),
              ),
              const Icon(Icons.expand_more, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    final cardBgColor = notification.isUnread
        ? (notification.type == NotificationType.positive
            ? kPositiveCardBg
            : notification.type == NotificationType.attention
                ? kAttentionCardBg
                : kCardBgColor)
        : kCardBgColor;

    final borderColor = notification.isUnread
        ? (notification.type == NotificationType.positive
            ? kPositiveCardBorder
            : notification.type == NotificationType.attention
                ? kAttentionCardBorder
                : kSystemCardBorder)
        : kSystemCardBorder;

    return Padding(
      padding: const EdgeInsets.only(bottom: kGapM),
      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          _markAsRead(notification.id);
          return false;
        },
        background: Container(
          decoration: BoxDecoration(
            color: kPositiveTagColor,
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.push('/notification/${notification.id}'),
            onLongPress: () => _showNotificationMenu(notification),
            borderRadius: BorderRadius.circular(kCardRadius),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(kCardRadius),
                border: Border.all(color: borderColor),
                boxShadow: const [kCardShadow],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNotificationIcon(notification.type),
                  const SizedBox(width: kGapM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: kHeadlineColor,
                                ),
                              ),
                            ),
                            if (notification.isUnread)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: kNewBadgeColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'New',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notification.body,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kSubtextColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: kMetaColor),
                            const SizedBox(width: 4),
                            Text(
                              notification.time,
                              style: const TextStyle(
                                fontSize: 12,
                                color: kMetaColor,
                              ),
                            ),
                            const Text(' · ',
                                style: TextStyle(color: kMetaColor)),
                            _buildTypeTag(notification.type),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: kGapS),
                  Column(
                    children: [
                      if (notification.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: kUnreadDotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 8),
                      const Icon(Icons.chevron_right,
                          color: kSubtextColor, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationType type) {
    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.positive:
        icon = Icons.favorite;
        color = kPositiveTagColor;
        break;
      case NotificationType.attention:
        icon = Icons.warning;
        color = kAttentionTagColor;
        break;
      case NotificationType.system:
        icon = Icons.settings;
        color = kSystemTagColor;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildTypeTag(NotificationType type) {
    String label;
    Color color;

    switch (type) {
      case NotificationType.positive:
        label = 'Positive Event';
        color = kPositiveTagColor;
        break;
      case NotificationType.attention:
        label = 'Attention';
        color = kAttentionTagColor;
        break;
      case NotificationType.system:
        label = 'System';
        color = kSystemTagColor;
        break;
    }

    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _showNotificationMenu(NotificationItem notification) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                notification.isUnread
                    ? Icons.mark_email_read
                    : Icons.mark_email_unread,
              ),
              title: Text(
                  notification.isUnread ? 'Mark as Read' : 'Mark as Unread'),
              onTap: () {
                Navigator.pop(context);
                _toggleReadStatus(notification.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.snooze),
              title: const Text('Snooze'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Notification snoozed for 1 hour')),
                );
                // TODO: Implement snooze
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteNotification(notification.id);
              },
            ),
            const SizedBox(height: kGapM),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: kSubtextColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: kGapM),
          const Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              color: kSubtextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kGapS),
          const Text(
            'You\'re all caught up!',
            style: TextStyle(
              fontSize: 14,
              color: kSubtextColor,
            ),
          ),
        ],
      ),
    );
  }
}
