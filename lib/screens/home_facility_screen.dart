// Generated from design - TrackPose (source: file:///mnt/data/home_facility.png)
// TODO: Add referenced assets to pubspec.yaml: assets/designs/icon_own_home.png

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Move to theme.dart
const _kBgGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFE6F0FF), Color(0xFFFFF0E6)],
);
const _kCardBg = Color(0xFFFFFFFF);
const _kCardRadius = 20.0;
const _kCardPadding = EdgeInsets.all(24.0);
const _kPageHPadding = 20.0;
const _kIconBadgeSize = 72.0;
const _kHeadlineColor = Color(0xFF0F1724);
const _kSubtitleColor = Color(0xFF6B7280);
const _kInputBg = Color(0xFFF3F4F6);
const _kInputRadius = 14.0;
const _kFeatureCardBg = Color(0xFFF9F1FB);
const _kFeatureCardRadius = 16.0;
const _kFeatureCardPadding = 20.0;
const _kCheckBg = Color(0xFFE8FBEE);
const _kCheckColor = Color(0xFF00C853);
const _kPrivacyBg = Color(0xFFE8F7FF);
const _kPrivacyRadius = 12.0;
const _kCtaGradient = LinearGradient(
  colors: [Color(0xFF7A3FF2), Color(0xFFFF2E7A)],
);
const _kCtaRadius = 28.0;
const _kCtaHeight = 56.0;
const _kCtaTextColor = Color(0xFFFFFFFF);
const _kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);
const _gapXS = 8.0;
const _gapS = 12.0;
const _gapM = 20.0;
const _gapL = 28.0;

// TODO: Integrate with backend (Render-managed MySQL) to create facility record and store facility_id.
// TODO: Implement local video processing / MediaPipe or TFLite plugin; do not upload raw video unless user opts in and consents.
// TODO: Store any tokens/identifiers in flutter_secure_storage; do not log secrets.

class HomeFacilityScreen extends StatefulWidget {
  const HomeFacilityScreen({super.key});

  @override
  State<HomeFacilityScreen> createState() => _HomeFacilityScreenState();
}

class _HomeFacilityScreenState extends State<HomeFacilityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value != null && value.trim().isNotEmpty && value.trim().length > 60) {
      return 'Name must be 60 characters or less';
    }
    return null;
  }

  Future<void> _completeSetup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    // Mock backend call
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _loading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Home facility created')));

    // TODO: Replace mock with backend call to create facility in Render-managed MySQL and optionally upload initial settings; store IDs securely.
    // Parent flow: home facility setup -> dashboard
    GoRouter.of(context).go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _kBgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _kPageHPadding,
                  vertical: _gapS,
                ),
                child: Row(
                  children: [
                    Semantics(
                      button: true,
                      label: 'Back to options button',
                      child: InkWell(
                        onTap: () => GoRouter.of(context).pop(),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back, color: _kHeadlineColor),
                            SizedBox(width: _gapXS),
                            Text(
                              'Back to options',
                              style: TextStyle(
                                color: _kHeadlineColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _kPageHPadding,
                  ),
                  child: _AnimatedCard(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _kCardBg,
                        borderRadius: BorderRadius.circular(_kCardRadius),
                        boxShadow: const [_kCardShadow],
                      ),
                      padding: _kCardPadding,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon badge
                            Container(
                              width: _kIconBadgeSize,
                              height: _kIconBadgeSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: _kCtaGradient,
                              ),
                              child: const Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: _gapM),

                            // Headline
                            const Text(
                              'Set Up Home Monitoring',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: _kHeadlineColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: _gapS),

                            // Subtitle
                            const Text(
                              'Create your personal home facility for AI-powered wellbeing monitoring',
                              style: TextStyle(
                                fontSize: 16,
                                color: _kSubtitleColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: _gapL),

                            // Input field
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Facility Name (Optional)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _kHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: _gapXS),
                            Semantics(
                              label: 'Facility name input',
                              child: TextFormField(
                                controller: _nameController,
                                validator: _validateName,
                                decoration: InputDecoration(
                                  hintText:
                                      'e.g., Smith Family Home, Grandma\'s House',
                                  filled: true,
                                  fillColor: _kInputBg,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      _kInputRadius,
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: _gapXS),
                            const Text(
                              'Give your home facility a recognizable name',
                              style: TextStyle(
                                fontSize: 12,
                                color: _kSubtitleColor,
                              ),
                            ),
                            const SizedBox(height: _gapL),

                            // What You Can Do card
                            const _InfoCard(
                              title: 'What You Can Do',
                              children: [
                                _FeatureBullet(
                                  text:
                                      'Upload pre-recorded videos of your loved ones',
                                ),
                                _FeatureBullet(
                                  text:
                                      'Get AI-powered emotional analysis and activity insights',
                                ),
                                _FeatureBullet(
                                  text:
                                      'Track wellbeing trends over time with detailed reports',
                                ),
                                _FeatureBullet(
                                  text:
                                      'Manage multiple family member profiles independently',
                                ),
                              ],
                            ),
                            const SizedBox(height: _gapM),

                            // Privacy panel
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _kPrivacyBg,
                                borderRadius: BorderRadius.circular(
                                  _kPrivacyRadius,
                                ),
                                border: Border.all(
                                  color: const Color(0xFFB3D9FF),
                                  width: 1,
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.privacy_tip,
                                        color: Color(0xFF2B9CFF),
                                        size: 20,
                                      ),
                                      SizedBox(width: _gapXS),
                                      Text(
                                        'Privacy First:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: _kHeadlineColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: _gapXS),
                                  Text(
                                    'All videos are processed locally with end-to-end encryption. Only you have access to your uploads and insights.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: _kSubtitleColor,
                                    ),
                                  ),
                                  SizedBox(height: _gapXS),
                                  Text(
                                    'Videos are automatically deleted after analysis unless you choose to save them.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _kSubtitleColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: _gapL),

                            // CTA button
                            _GradientButton(
                              onPressed: _loading ? null : _completeSetup,
                              loading: _loading,
                              label: 'Complete Setup & Continue',
                            ),
                            const SizedBox(height: _gapS),

                            // Secondary pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E8FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Perfect for caregivers at home',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF7A3FF2),
                                ),
                              ),
                            ),
                          ],
                        ),
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

class _AnimatedCard extends StatefulWidget {
  final Widget child;

  const _AnimatedCard({required this.child});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.98,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kFeatureCardPadding),
      decoration: BoxDecoration(
        color: _kFeatureCardBg,
        borderRadius: BorderRadius.circular(_kFeatureCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kHeadlineColor,
            ),
          ),
          const SizedBox(height: _gapS),
          ...children,
        ],
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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 50), () {
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
      padding: const EdgeInsets.only(bottom: _gapS),
      child: ScaleTransition(
        scale: _animation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: _kCheckBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: _kCheckColor, size: 16),
            ),
            const SizedBox(width: _gapS),
            Expanded(
              child: Semantics(
                label: widget.text,
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 14, color: _kHeadlineColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final String label;

  const _GradientButton({
    required this.onPressed,
    required this.loading,
    required this.label,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${widget.label} button',
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: _kCtaHeight,
          decoration: BoxDecoration(
            gradient: _kCtaGradient,
            borderRadius: BorderRadius.circular(_kCtaRadius),
            boxShadow: _pressed
                ? []
                : [
                    BoxShadow(
                      color: const Color(0xFF7A3FF2).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              onTapDown: (_) => setState(() => _pressed = true),
              onTapUp: (_) => setState(() => _pressed = false),
              onTapCancel: () => setState(() => _pressed = false),
              borderRadius: BorderRadius.circular(_kCtaRadius),
              child: Center(
                child: widget.loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: _kCtaTextColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.label,
                        style: const TextStyle(
                          color: _kCtaTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
