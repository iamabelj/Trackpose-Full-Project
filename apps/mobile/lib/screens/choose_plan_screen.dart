// Generated from design - TrackPose (source: file:///mnt/data/choose_plan.png)
// TODO: Add assets/designs/icon_verified.png, icon_ai.png, icon_peace.png, icon_support.png to pubspec.yaml
// TODO: Add go_router package to pubspec.yaml

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Color tokens - TODO: move to theme.dart
const _kBgGradientStart = Color(0xFFE6F0FF);
const _kBgGradientEnd = Color(0xFFFFF0E6);
const _kHeadlineColor = Color(0xFF0F1724);
const _kBodyColor = Color(0xFF6B7280);
const _kCardBg = Color(0xFFFFFFFF);
const _kPurplePrimary = Color(0xFF7A3FF2);
const _kPinkAccent = Color(0xFFFF2E7A);
const _kRibbonPurple = Color(0xFFA347FF);
const _kBorderPurple = Color(0xFFE9DFFF);
const _kVerifiedGreen = Color(0xFF00C853);
const _kVerifiedBg = Color(0xFFE8FBEE);

// Size tokens - TODO: move to theme.dart
const _kCardRadius = 20.0;
const _kButtonRadius = 28.0;
const _kButtonHeight = 56.0;
const _kPagePadding = 20.0;
const _gapS = 12.0;
const _gapM = 20.0;
const _gapL = 28.0;

// Shadow token - TODO: move to theme.dart
const _kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isTrialLoading = false;
  bool _isFullAccessLoading = false;

  // Demo email for verified badge
  final String email = 'user@example.com';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // TODO: Replace stub with API call to backend (Render-managed MySQL) to create Trial subscription and enforce trial limits server-side.
  // TODO: Enforce TRIAL LIMITS server-side (1 child profile, 1 facility connection, one-time upload). Do not rely on client-only checks.
  Future<void> _startTrial() async {
    setState(() => _isTrialLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isTrialLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trial started')),
    );
    // Parent flow: plan choice -> facility setup choice -> facility setup -> dashboard
    GoRouter.of(context).go('/facility-setup-choice');
  }

  // TODO: Integrate with Stripe Checkout or Stripe Subscriptions server-side; implement webhook to mark subscription active and generate access code.
  // TODO: Use Render-managed MySQL for subscriptions and user records; file uploads to Render object storage or S3. Secure tokens in flutter_secure_storage.
  // TODO: Stripe integration: implement server-side Checkout session creation, webhook verification, and access code generation on successful payment.
  void _getFullAccess() {
    setState(() => _isFullAccessLoading = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subscription flow started')),
    );
    // Parent flow: plan choice -> facility setup choice -> facility setup -> dashboard
    GoRouter.of(context).go('/facility-setup-choice');
  }

  // TODO: implement platform pay SDKs (Apple Pay, Google Pay)
  void _showAlternatePaymentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Continue with',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            _PaymentOptionTile(
              icon: Icons.apple,
              label: 'Apple Pay',
              onTap: () {
                // TODO: integrate Apple Pay SDK
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _PaymentOptionTile(
              icon: Icons.android,
              label: 'Google Pay',
              onTap: () {
                // TODO: integrate Google Pay SDK
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kBgGradientStart, _kBgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: _kPagePadding, vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Verified badge
                      _VerifiedBadge(email: email),
                      const SizedBox(height: _gapL),

                      // Headline
                      const Text(
                        'Choose Your Plan',
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
                        'Start with a free trial or unlock full access immediately',
                        style: TextStyle(fontSize: 16, color: _kBodyColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: _gapL),

                      // Free Trial Plan
                      _PlanCard(
                        title: 'Free Trial',
                        subtitle: '14 Days',
                        price: '\$0',
                        priceSubtext: 'for 14 days',
                        priceNote: 'No credit card required',
                        sectionTitle: 'Free trial includes:',
                        features: const [
                          '1 child profile',
                          '1 facility connection',
                          'Limited AI insights',
                          'One-time video upload for AI analytics',
                        ],
                        notePill: 'Perfect for trying out TrackPose risk-free',
                        ctaText: 'Start Free Trial',
                        onPressed: _startTrial,
                        isLoading: _isTrialLoading,
                        delay: 0,
                      ),
                      const SizedBox(height: _gapM),

                      // Full Access Plan
                      _PlanCard(
                        title: 'Full Access',
                        subtitle: 'Unlimited',
                        price: '\$29',
                        priceSubtext: '/month',
                        priceNote: 'Billed monthly, cancel anytime',
                        sectionTitle: 'Everything in Trial, Plus:',
                        features: const [
                          'Unlimited live monitoring',
                          'Unlimited facility connections',
                          'Unlimited child profiles',
                          'Unlimited video uploads',
                          'Advanced AI analytics & trends',
                          'Priority support & chat',
                          'Export reports & insights',
                          'Custom notifications',
                        ],
                        notePill: '30-day money-back guarantee',
                        ctaText: 'Get Full Access',
                        onPressed: _getFullAccess,
                        isLoading: _isFullAccessLoading,
                        showMostPopular: true,
                        delay: 80,
                      ),
                      const SizedBox(height: _gapL),

                      // Continue with... button
                      Semantics(
                        button: true,
                        label: 'Continue with alternate payment options',
                        child: InkWell(
                          onTap: _showAlternatePaymentOptions,
                          child: Container(
                            width: double.infinity,
                            height: _kButtonHeight,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [_kPurplePrimary, _kPinkAccent],
                              ),
                              borderRadius:
                                  BorderRadius.circular(_kButtonRadius),
                              boxShadow: const [_kCardShadow],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Continue with ...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: _gapL),

                      // Why Choose Full Access card
                      _WhyCard(),
                      const SizedBox(height: _gapL),
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
}

class _VerifiedBadge extends StatelessWidget {
  final String email;

  const _VerifiedBadge({required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _kVerifiedBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: _kVerifiedGreen, size: 20),
          const SizedBox(width: 8),
          Text(
            'Account Verified: $email',
            style: const TextStyle(
              color: _kVerifiedGreen,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String priceSubtext;
  final String priceNote;
  final String sectionTitle;
  final List<String> features;
  final String notePill;
  final String ctaText;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool showMostPopular;
  final int delay;

  const _PlanCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.priceSubtext,
    required this.priceNote,
    required this.sectionTitle,
    required this.features,
    required this.notePill,
    required this.ctaText,
    required this.onPressed,
    required this.isLoading,
    this.showMostPopular = false,
    this.delay = 0,
  });

  @override
  State<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<_PlanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 8.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.995 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(_kCardRadius),
              border: Border.all(color: _kBorderPurple, width: 2),
              boxShadow: const [_kCardShadow],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and subtitle
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _kHeadlineColor,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(fontSize: 16, color: _kBodyColor),
                    ),
                    const SizedBox(height: _gapM),

                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: _kHeadlineColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.priceSubtext,
                          style:
                              const TextStyle(fontSize: 18, color: _kBodyColor),
                        ),
                      ],
                    ),
                    Text(
                      widget.priceNote,
                      style: const TextStyle(fontSize: 14, color: _kBodyColor),
                    ),
                    const SizedBox(height: _gapM),

                    // Section title
                    Text(
                      widget.sectionTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kHeadlineColor,
                      ),
                    ),
                    const SizedBox(height: _gapS),

                    // Features
                    ...widget.features
                        .map((feature) => _FeatureBullet(text: feature)),
                    const SizedBox(height: _gapM),

                    // Note pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.notePill,
                        style:
                            const TextStyle(fontSize: 13, color: _kBodyColor),
                      ),
                    ),
                    const SizedBox(height: _gapM),

                    // CTA button
                    Semantics(
                      button: true,
                      label: widget.ctaText,
                      child: InkWell(
                        onTap: widget.onPressed,
                        child: Container(
                          width: double.infinity,
                          height: _kButtonHeight,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_kPurplePrimary, _kPinkAccent],
                            ),
                            borderRadius: BorderRadius.circular(_kButtonRadius),
                            boxShadow: const [_kCardShadow],
                          ),
                          alignment: Alignment.center,
                          child: widget.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
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
                  ],
                ),

                // Most Popular ribbon
                if (widget.showMostPopular)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _MostPopularRibbon(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureBullet extends StatelessWidget {
  final String text;

  const _FeatureBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: _kPurplePrimary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, color: _kHeadlineColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MostPopularRibbon extends StatefulWidget {
  @override
  State<_MostPopularRibbon> createState() => _MostPopularRibbonState();
}

class _MostPopularRibbonState extends State<_MostPopularRibbon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 200), () {
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
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(
          color: _kRibbonPurple,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(_kCardRadius),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: const Text(
          'Most Popular',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: const [_kCardShadow],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Full Access?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _kHeadlineColor,
            ),
          ),
          SizedBox(height: _gapM),
          _WhyItem(
            icon: Icons.psychology,
            title: 'Advanced AI',
            description:
                'Get deeper insights with trend analysis and predictive wellbeing scoring',
          ),
          SizedBox(height: _gapM),
          _WhyItem(
            icon: Icons.favorite,
            title: 'Peace of Mind',
            description:
                'Monitor unlimited facilities and family members without restrictions',
          ),
          SizedBox(height: _gapM),
          _WhyItem(
            icon: Icons.support_agent,
            title: 'Priority Support',
            description:
                'Get help when you need it with dedicated support team',
          ),
        ],
      ),
    );
  }
}

class _WhyItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _WhyItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title: $description',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, _kPinkAccent],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kHeadlineColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: _kBodyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PaymentOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
