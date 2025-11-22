// Generated from design - TrackPose (source: file:///mnt/data/facility_setup_choice.png)
// TODO: Add assets to pubspec.yaml: assets/designs/icon_own_home.png, assets/designs/icon_connect_facility.png
// TODO: Implement backend flows: access-code verification, facility creation, and Render MySQL API calls.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Move these constants to theme.dart
const _kBgGradientColors = [Color(0xFFE6F0FF), Color(0xFFFFF0E6)];
const _kHeadlineColor = Color(0xFF0F1724);
const _kBodyColor = Color(0xFF6B7280);
const _kCardBg = Color(0xFFFFFFFF);
const _kCardRadius = 20.0;
const _kPurpleBorder = Color(0xFFA76BFF);
const _kPrimaryCTAGradient = [Color(0xFF7A3FF2), Color(0xFFFF2E7A)];
const _kSecondaryCTAGradient = [Color(0xFF2B9CFF), Color(0xFF5A62FF)];
const _kPrivacyBg = Color(0xFFE8FBEE);
const _kPrivacyIcon = Color(0xFF00C853);
const _kShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);
const _kPagePadding = 20.0;
const _kHeadlineSize = 34.0;
const _kSubtitleSize = 16.0;
const _kCardTitleSize = 20.0;
const _kCardBodySize = 16.0;
const _kButtonRadius = 28.0;
const _kButtonHeight = 56.0;
const _gapXS = 8.0;
const _gapS = 12.0;
const _gapM = 20.0;
const _gapL = 28.0;

class FacilitySetupChoiceScreen extends StatefulWidget {
  const FacilitySetupChoiceScreen({super.key});

  @override
  State<FacilitySetupChoiceScreen> createState() =>
      _FacilitySetupChoiceScreenState();
}

class _FacilitySetupChoiceScreenState extends State<FacilitySetupChoiceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeCard1;
  late Animation<double> _fadeCard2;
  late Animation<Offset> _slideCard1;
  late Animation<Offset> _slideCard2;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeCard1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _fadeCard2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideCard1 = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideCard2 = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showAccessCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => const _AccessCodeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 40).clamp(0.0, 920.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _kBgGradientColors,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: _kPagePadding,
              vertical: _gapL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => GoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: _kBodyColor),
                    label: const Text(
                      'Back',
                      style: TextStyle(color: _kBodyColor),
                    ),
                  ),
                ),
                const SizedBox(height: _gapM),

                // Headline
                const Text(
                  'Choose Your Facility Setup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _kHeadlineSize,
                    fontWeight: FontWeight.w700,
                    color: _kHeadlineColor,
                  ),
                ),
                const SizedBox(height: _gapS),

                // Subtitle
                const Text(
                  'Select how you want to monitor your loved ones',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _kSubtitleSize,
                    color: _kBodyColor,
                  ),
                ),
                const SizedBox(height: _gapL),

                // Card A - Own Home Facility
                FadeTransition(
                  opacity: _fadeCard1,
                  child: SlideTransition(
                    position: _slideCard1,
                    child: _FacilityCard(
                      width: cardWidth,
                      iconAsset: 'assets/designs/icon_own_home.png',
                      title: 'Own Home Facility',
                      description:
                          'Set up monitoring at home for elderly parents, family members, or personal use. Upload your own videos for AI analysis.',
                      features: const [
                        'Upload pre-recorded videos',
                        'AI emotional analysis',
                        'Activity insights & reports',
                        'No facility connection needed',
                      ],
                      ctaText: 'Set Up Home Monitoring',
                      ctaGradient: _kPrimaryCTAGradient,
                      secondaryPillText: 'Perfect for caregivers at home',
                      onCtaPressed: () {
                        // Parent flow: facility setup choice -> home facility setup -> dashboard
                        GoRouter.of(context).go('/home-facility-setup');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: _gapM),

                // Card B - Connect to Facility
                FadeTransition(
                  opacity: _fadeCard2,
                  child: SlideTransition(
                    position: _slideCard2,
                    child: _FacilityCard(
                      width: cardWidth,
                      iconAsset: 'assets/designs/icon_connect_facility.png',
                      title: 'Connect to Facility',
                      description:
                          'Link to childcare centers, schools, care homes, or assisted living facilities to monitor your loved ones remotely.',
                      features: const [
                        'Live video monitoring',
                        'Real-time emotional alerts',
                        'Staff messaging',
                        'Daily activity reports',
                      ],
                      ctaText: 'Connect to Facility',
                      ctaGradient: _kSecondaryCTAGradient,
                      secondaryPillText: 'Requires facility access code',
                      secondaryPillColor: Colors.lightBlue.shade50,
                      onSecondaryPillPressed: _showAccessCodeDialog,
                      onCtaPressed: () {
                        // Parent flow: facility setup choice -> external facility setup -> dashboard
                        GoRouter.of(context).go('/external-facility-setup');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: _gapL),

                // Privacy & Security Panel
                _PrivacyPanel(width: cardWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FacilityCard extends StatefulWidget {
  final double width;
  final String iconAsset;
  final String title;
  final String description;
  final List<String> features;
  final String ctaText;
  final List<Color> ctaGradient;
  final String secondaryPillText;
  final Color? secondaryPillColor;
  final VoidCallback? onSecondaryPillPressed;
  final VoidCallback onCtaPressed;

  const _FacilityCard({
    required this.width,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.features,
    required this.ctaText,
    required this.ctaGradient,
    required this.secondaryPillText,
    this.secondaryPillColor,
    this.onSecondaryPillPressed,
    required this.onCtaPressed,
  });

  @override
  State<_FacilityCard> createState() => _FacilityCardState();
}

class _FacilityCardState extends State<_FacilityCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(_kCardRadius),
          boxShadow: const [_kShadow],
        ),
        child: Column(
          children: [
            // Icon badge
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: widget.ctaGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Image.asset(
                  widget.iconAsset,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stack) =>
                      const Icon(Icons.home, color: Colors.white, size: 40),
                ),
              ),
            ),
            const SizedBox(height: _gapM),

            // Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: _kCardTitleSize,
                fontWeight: FontWeight.w700,
                color: _kHeadlineColor,
              ),
            ),
            const SizedBox(height: _gapS),

            // Description
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: _kCardBodySize,
                color: _kBodyColor,
              ),
            ),
            const SizedBox(height: _gapM),

            // Feature bullets
            ...widget.features.map((feature) => _FeatureBullet(text: feature)),
            const SizedBox(height: _gapM),

            // CTA Button
            GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) {
                setState(() => _isPressed = false);
                widget.onCtaPressed();
              },
              onTapCancel: () => setState(() => _isPressed = false),
              child: Semantics(
                button: true,
                label: widget.ctaText,
                child: Container(
                  width: double.infinity,
                  height: _kButtonHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.ctaGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(_kButtonRadius),
                    boxShadow: const [_kShadow],
                  ),
                  child: Center(
                    child: Text(
                      widget.ctaText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: _gapS),

            // Secondary pill
            GestureDetector(
              onTap: widget.onSecondaryPillPressed,
              child: Semantics(
                button: widget.onSecondaryPillPressed != null,
                label: widget.secondaryPillText,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: widget.secondaryPillColor ?? Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.secondaryPillText,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.onSecondaryPillPressed != null
                          ? _kPurpleBorder
                          : _kBodyColor,
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
}

class _FeatureBullet extends StatefulWidget {
  final String text;

  const _FeatureBullet({required this.text});

  @override
  State<_FeatureBullet> createState() => _FeatureBulletState();
}

class _FeatureBulletState extends State<_FeatureBullet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: _gapXS),
      child: Row(
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: _kPrivacyBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: _kPrivacyIcon,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: _gapS),
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 15,
                color: _kHeadlineColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyPanel extends StatelessWidget {
  final double width;

  const _PrivacyPanel({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kPrivacyBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: _kPrivacyIcon, size: 24),
              SizedBox(width: _gapS),
              Text(
                'Privacy & Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _kHeadlineColor,
                ),
              ),
            ],
          ),
          SizedBox(height: _gapS),
          Text(
            'You can add multiple facilities later. All data is encrypted and you only have access to your own family members\' profiles.',
            style: TextStyle(
              fontSize: 14,
              color: _kBodyColor,
            ),
          ),
          SizedBox(height: _gapXS),
          Text(
            'Note: You can switch between home monitoring and facility connections anytime from Settings.',
            style: TextStyle(
              fontSize: 14,
              color: _kBodyColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessCodeDialog extends StatefulWidget {
  const _AccessCodeDialog();

  @override
  State<_AccessCodeDialog> createState() => _AccessCodeDialogState();
}

class _AccessCodeDialogState extends State<_AccessCodeDialog> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyCode() async {
    if (_codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an access code')),
      );
      return;
    }

    setState(() => _isLoading = true);
    // TODO: Replace with real access-code verification backend call
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Access code verified successfully')),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Enter Access Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Please enter the access code provided by your facility',
            style: TextStyle(fontSize: 14, color: _kBodyColor),
          ),
          const SizedBox(height: _gapM),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              hintText: 'Enter code',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _verifyCode,
          style: ElevatedButton.styleFrom(
            backgroundColor: _kPurpleBorder,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Verify', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
