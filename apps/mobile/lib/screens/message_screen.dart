// Generated from design - TrackPose (source: file:///mnt/data/message_screen.png)
// TODO: Add assets to pubspec.yaml: assets/designs/thumb1.png, assets/designs/avatar_sj.png
// TODO: Integrate real-time messaging backend and media uploads (Render object storage). Secure tokens in flutter_secure_storage.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Move these to theme.dart
const _kPageGradientColors = [Color(0xFFE6F0FF), Color(0xFFFFF0E6)];
const _kTrialBannerGradient = [Color(0xFF7A3FF2), Color(0xFFFF2E7A)];
const _kOutgoingBubbleGradient = [Color(0xFF7A3FF2), Color(0xFFFF2E7A)];
const _kIncomingBubbleBg = Color(0xFFFFFFFF);
const _kTimestampColor = Color(0xFF9CA3AF);
const _kQuickReplyBg = Color(0xFFFFF2FF);
const _kQuickReplyText = Color(0xFFA76BFF);
const _kComposerBg = Color(0xFFF3F4F6);
const _kPrimaryPurple = Color(0xFF7A3FF2);
const _kOnlineGreen = Color(0xFF00C853);

const _kBubbleRadius = 16.0;
const _kComposerRadius = 28.0;
const _kQuickReplyRadius = 20.0;
const _kThumbnailRadius = 12.0;
const _kAvatarRadius = 18.0;

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Message> _messages = [
    _Message(
      text:
          "Good morning! Emma had a wonderful start to the day. She arrived happy and immediately joined her friends in the play area.",
      sender: "Sarah Johnson",
      time: "9:15 AM",
      isOutgoing: false,
    ),
    _Message(
      text: "That's great to hear! How's her mood been throughout the morning?",
      sender: "You",
      time: "9:30 AM",
      isOutgoing: true,
    ),
    _Message(
      text: "Here she is working on her painting!",
      sender: "Sarah Johnson",
      time: "10:46 AM",
      isOutgoing: false,
      imageCaption: "Arts & Crafts Time",
      hasImage: true,
    ),
    _Message(
      text: "Love it! Thank you so much for keeping me updated 💙",
      sender: "You",
      time: "11:00 AM",
      isOutgoing: true,
    ),
  ];

  bool _showQuickReplies = true;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _showQuickReplies = _messageController.text.isEmpty;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_Message(
        text: text,
        sender: "You",
        time: _formatCurrentTime(),
        isOutgoing: true,
      ));
    });

    _messageController.clear();

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _kPageGradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TrialBanner(),
              _ChatHeader(),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _MessageBubble(
                      message: _messages[index],
                      onImageTap: _messages[index].hasImage
                          ? () => _showImagePreview(context)
                          : null,
                    );
                  },
                ),
              ),
              if (_showQuickReplies) _QuickReplies(onReplyTap: _sendMessage),
              _Composer(
                controller: _messageController,
                onSend: () => _sendMessage(_messageController.text),
                onAttachment: () {
                  // TODO: Integrate file picker & upload to Render object storage
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('File picker not yet implemented')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.image, size: 80)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _Message {
  final String text;
  final String sender;
  final String time;
  final bool isOutgoing;
  final String? imageCaption;
  final bool hasImage;

  _Message({
    required this.text,
    required this.sender,
    required this.time,
    required this.isOutgoing,
    this.imageCaption,
    this.hasImage = false,
  });
}

class _TrialBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: _kTrialBannerGradient),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '7 days remaining in your free trial — Upgrade for full access',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/choose-plan'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(
                  color: _kPrimaryPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 36, 0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F1724)),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          const CircleAvatar(
            radius: _kAvatarRadius,
            backgroundColor: Color(0xFFEAE8FF),
            child: Text('EC',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Emma's Care Team",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F1724)),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: _kOnlineGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('dsa · Online',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _Message message;
  final VoidCallback? onImageTap;

  const _MessageBubble({required this.message, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: message.isOutgoing
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isOutgoing) ...[
            const CircleAvatar(
              radius: _kAvatarRadius,
              backgroundColor: Color(0xFFEEF7FF),
              child: Text('SJ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isOutgoing
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!message.isOutgoing)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      message.sender,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280)),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    gradient: message.isOutgoing
                        ? const LinearGradient(colors: _kOutgoingBubbleGradient)
                        : null,
                    color: message.isOutgoing ? null : _kIncomingBubbleBg,
                    borderRadius: BorderRadius.circular(_kBubbleRadius),
                    boxShadow: message.isOutgoing
                        ? []
                        : [
                            const BoxShadow(
                              color: Color.fromRGBO(15, 23, 36, 0.06),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.hasImage) ...[
                        GestureDetector(
                          onTap: onImageTap,
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(_kThumbnailRadius),
                            ),
                            child: const Center(
                                child: Icon(Icons.image, size: 50)),
                          ),
                        ),
                        if (message.imageCaption != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            message.imageCaption!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: message.isOutgoing
                                  ? Colors.white
                                  : const Color(0xFF0F1724),
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                      ],
                      SelectableText(
                        message.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: message.isOutgoing
                              ? Colors.white
                              : const Color(0xFF0F1724),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                  child: Text(
                    message.time,
                    style:
                        const TextStyle(fontSize: 11, color: _kTimestampColor),
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

class _QuickReplies extends StatelessWidget {
  final Function(String) onReplyTap;

  const _QuickReplies({required this.onReplyTap});

  @override
  Widget build(BuildContext context) {
    final replies = ["How's their day?", "Any updates?", "Thank you! 💙"];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: replies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onReplyTap(replies[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _kQuickReplyBg,
                borderRadius: BorderRadius.circular(_kQuickReplyRadius),
              ),
              child: Center(
                child: Text(
                  replies[index],
                  style: const TextStyle(
                      color: _kQuickReplyText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachment;

  const _Composer({
    required this.controller,
    required this.onSend,
    required this.onAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 36, 0.06),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Semantics(
            label: 'Attach file',
            button: true,
            child: IconButton(
              icon: const Icon(Icons.attach_file, color: _kPrimaryPurple),
              onPressed: onAttachment,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _kComposerBg,
                borderRadius: BorderRadius.circular(_kComposerRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      ),
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Color(0xFF6B7280)),
                    onPressed: () {
                      // TODO: Implement emoji picker
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            label: 'Send message',
            button: true,
            child: GestureDetector(
              onTap: onSend,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: _kOutgoingBubbleGradient),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
