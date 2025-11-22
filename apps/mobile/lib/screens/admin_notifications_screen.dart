// Generated from design - TrackPose (source: file:///mnt/data/admin_notifications_screen.png)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Add assets to pubspec.yaml: assets/designs/icon_heart.png, assets/designs/icon_warning.png, assets/designs/icon_gear.png
// TODO: Integrate with backend for persistent notification state (Render-managed MySQL) and secure APIs.

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  // This is a simplified version - reuses same logic as user notifications
  // In production, admin notifications would have different types and sources

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked read')),
              );
            },
            child: const Text('Mark All Read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Stay updated on your loved one\'s day',
              style: TextStyle(color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          _buildNotificationCard(
            'Ella Joined Playtime',
            'Ella joined playtime at 2:30 PM.',
            '2:30 PM',
            'Positive Event',
            Colors.green,
            isNew: true,
          ),
          _buildNotificationCard(
            'Happy Moment Captured',
            'Emma was detected smiling during arts and crafts activity.',
            '1:15 PM',
            'Positive Event',
            Colors.green,
            isNew: true,
          ),
          _buildNotificationCard(
            'Low Activity Detected',
            'Low activity detected at 3:00 PM.',
            '3:00 PM',
            'Attention',
            Colors.orange,
            isNew: true,
          ),
          _buildNotificationCard(
            'Camera Zone 2 Offline',
            'Camera Zone 2 offline.',
            '12:45 PM',
            'System',
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
      String title, String body, String time, String tag, Color tagColor,
      {bool isNew = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Marked read')));
        },
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: tagColor.withValues(alpha: 0.2),
            child: Icon(
              tag == 'Positive Event'
                  ? Icons.favorite
                  : tag == 'Attention'
                      ? Icons.warning
                      : Icons.settings,
              color: tagColor,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
              if (isNew)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA76BFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('New',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 12, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 4),
                  Text('$time · $tag',
                      style: TextStyle(fontSize: 12, color: tagColor)),
                ],
              ),
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(
              '/admin/notification/${DateTime.now().millisecondsSinceEpoch}'),
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.mark_email_read),
                      title: const Text('Mark as Read'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.snooze),
                      title: const Text('Snooze'),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text('Delete',
                          style: TextStyle(color: Colors.red)),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
