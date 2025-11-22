// Generated from design - TrackPose (source: file:///mnt/data/1.png)
// TODO: Add assets/designs/intro_welcome.png to pubspec.yaml

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design tokens - TODO: Move to theme.dart
const Color _kBackgroundGradientStart = Color(0xFF7A3FF2);
const Color _kBackgroundGradientEnd = Color(0xFFFF2E7A);
const Color _kHeadlineColor = Color(0xFFFFFFFF);
const Color _kSubtitleColor = Color(0xFFFFFFFF);
const Color _kLinkColor = Color(0xFFFFFFFF);

const double _kLogoSize = 120.0;
const double _kHeadlineFontSize = 34.0;
const double _kSubtitleFontSize = 16.0;
const double _kCtaButtonHeight = 56.0;
const double _kCtaButtonRadius = 28.0;
const double _kPageHorizontalPadding = 24.0;
const double _kPageVerticalPadding = 24.0;

const String _kHeadlineText = 'Welcome to TrackPose';
const String _kSubtitleText =
    'TrackPose helps families, caregivers, and managers monitor wellbeing with AI insights and care transparency.';
const String _kCtaButtonText = 'Get Started';
const String _kLoginLinkText = 'Log In';

class IntroWelcomeScreen extends StatefulWidget {
  const IntroWelcomeScreen({super.key});

  @override
  State<IntroWelcomeScreen> createState() => _IntroWelcomeScreenState();
}

class _IntroWelcomeScreenState extends State<IntroWelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kBackgroundGradientStart, _kBackgroundGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _kPageHorizontalPadding,
                  vertical: _kPageVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildAnimatedLogo(),
                    const SizedBox(height: 40),
                    _buildAnimatedHeadline(),
                    const SizedBox(height: 16),
                    _buildAnimatedSubtitle(),
                    const SizedBox(height: 48),
                    _buildAnimatedFeatures(),
                    const SizedBox(height: 48),
                    _buildAnimatedCta(context),
                    const SizedBox(height: 16),
                    _buildAnimatedLoginLink(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Semantics(
          label: 'TrackPose logo',
          child: Container(
            width: _kLogoSize,
            height: _kLogoSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.2),
                  blurRadius: 50,
                  spreadRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF7A3FF2), Color(0xFFFF2E7A)],
                ).createShader(bounds),
                child: const Icon(
                  Icons.track_changes_rounded,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeadline() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: const Text(
          _kHeadlineText,
          style: TextStyle(
            fontSize: _kHeadlineFontSize,
            fontWeight: FontWeight.w700,
            color: _kHeadlineColor,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _kSubtitleText,
            style: TextStyle(
              fontSize: _kSubtitleFontSize,
              color: _kSubtitleColor.withValues(alpha: 0.9),
              height: 1.5,
              shadows: const [
                Shadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedFeatures() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFeatureItem(
            icon: Icons.security_rounded,
            delay: 200,
          ),
          _buildFeatureItem(
            icon: Icons.insights_rounded,
            delay: 400,
          ),
          _buildFeatureItem(
            icon: Icons.people_rounded,
            delay: 600,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.1),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Colors.white],
          ).createShader(bounds),
          child: Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCta(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Semantics(
          button: true,
          label: 'Get Started — begin onboarding',
          child: _GradientButton(
            onPressed: () {
              context.push('/onboarding-1');
            },
            text: _kCtaButtonText,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLoginLink(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Semantics(
        button: true,
        label: 'Log In',
        child: TextButton(
          onPressed: () {
            context.push('/login');
          },
          child: const Text(
            _kLoginLinkText,
            style: TextStyle(
              fontSize: 16,
              color: _kLinkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const _GradientButton({
    required this.onPressed,
    required this.text,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        width: double.infinity,
        height: _kCtaButtonHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_kCtaButtonRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(_kCtaButtonRadius),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF7A3FF2), Color(0xFFFF2E7A)],
                ).createShader(bounds),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
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
