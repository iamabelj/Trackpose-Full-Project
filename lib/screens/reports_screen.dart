// Generated from design - TrackPose (source: file:///mnt/data/reports_screen.png)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Add assets to pubspec.yaml
// TODO: Implement server-side report generation, Render object storage for export files, and Stripe entitlement checks.
// TODO: Secure temporary URLs and store export metadata in Render-managed MySQL.

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedRange = 'Last 7 days';
  final bool _isPro = false; // Mock subscription status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Insights'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _handleExport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'AI-driven summaries, exportable reports, and facility analytics',
                style: TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(height: 20),
            _buildDateRangePicker(),
            const SizedBox(height: 20),
            _buildOverviewCard(),
            const SizedBox(height: 20),
            _buildReportCard(
                'Session Summary',
                'Key moments and AI-detected events from recent sessions.',
                Icons.summarize),
            _buildReportCard('Emotional Trends',
                'Mood trends over the selected period.', Icons.trending_up),
            _buildReportCard('Activity Breakdown',
                'Time spent active vs sedentary.', Icons.pie_chart),
            _buildReportCard('Interaction & Social',
                'Frequency and quality of social interactions.', Icons.people),
            _buildReportCard('Safety & Alerts',
                'Falls, inactivity alerts and flagged events.', Icons.warning,
                isPro: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Date Range',
        border: const OutlineInputBorder(),
        hintText: _selectedRange,
      ),
      initialValue: _selectedRange,
      items: ['Last 7 days', 'Last 30 days', 'This month', 'Custom Range']
          .map((r) => DropdownMenuItem<String>(value: r, child: Text(r)))
          .toList(),
      onChanged: (val) => setState(() => _selectedRange = val!),
    );
  }

  Widget _buildOverviewCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircularProgressIndicator(
                value: 0.87, strokeWidth: 8, backgroundColor: Colors.grey),
            const SizedBox(height: 8),
            const Text('8.7',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
            const Text('Overall Wellbeing Score'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statPill('Avg Mood', '8.5'),
                _statPill('Avg Activity', '7.2'),
                _statPill('Engagement', '9.1'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statPill(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      ],
    );
  }

  Widget _buildReportCard(String title, String subtitle, IconData icon,
      {bool isPro = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF7A3FF2)),
        title: Row(
          children: [
            Text(title),
            if (isPro) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFA76BFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Pro',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ],
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (isPro && !_isPro) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Upgrade to Pro to unlock this report')),
            );
          } else {
            // Navigate to detail
          }
        },
      ),
    );
  }

  Future<void> _handleExport() async {
    if (!_isPro) {
      final upgrade = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Upgrade to Pro'),
          content:
              const Text('Export full reports requires a Pro subscription.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Upgrade')),
          ],
        ),
      );
      if (upgrade == true && mounted) {
        context.push('/choose-plan');
      }
      return;
    }

    // TODO: Call backend export API
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report generated — Download started')),
      );
    }
  }
}
