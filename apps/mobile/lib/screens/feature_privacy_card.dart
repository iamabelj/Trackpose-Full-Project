// Generated from uploaded designs - TrackPose

import 'package:flutter/material.dart';

// Generated from uploaded designs - TrackPose
class PrivacyFeatureCard extends StatelessWidget {
  const PrivacyFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const CircleAvatar(
                radius: 34,
                backgroundColor: Colors.green,
                child: Icon(Icons.lock, color: Colors.white)),
            const SizedBox(height: 16),
            _row('GDPR-compliant protection', Colors.greenAccent),
            const SizedBox(height: 8),
            _row('Enterprise-grade security', Colors.lightBlueAccent),
            const SizedBox(height: 8),
            _row('End-to-end encryption', Colors.purpleAccent),
          ])),
    );
  }

  Widget _row(String text, Color bg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(40)),
      child: Row(children: [
        const Icon(Icons.check_circle),
        const SizedBox(width: 8),
        Expanded(child: Text(text))
      ]));
}
