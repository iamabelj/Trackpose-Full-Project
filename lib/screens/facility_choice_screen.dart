// Generated from design - TrackPose (source: file:///mnt/data/facility_choice_screen.png)
// TODO: Add assets/designs/icon_own_home.png and assets/designs/icon_connect.png to pubspec.yaml
// TODO: Ensure signup button pushes to '/verify-email' and verification success pushes to '/choose-facility'. Use Firebase to verify then route.
// TODO: Implement real facility creation/lookup APIs and access-code flows

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design tokens - TODO: Move to theme.dart
const Color _kBgGradientStart = Color(0xFFE6F0FF);
const Color _kBgGradientEnd = Color(0xFFFFF0E6);
const Color _kHeadlineColor = Color(0xFF0F1724);
const Color _kBodyColor = Color(0xFF6B7280);
const Color _kOwnHomeBlue = Color(0xFF2B9CFF);
const Color _kOwnHomeActionBlue = Color(0xFF1E88FF);
const Color _kConnectPurple = Color(0xFFA76BFF);
const Color _kConnectActionPurple = Color(0xFFA347FF);
const double _kCardRadius = 20.0;
const double _kGapS = 12.0;
const double _kGapM = 20.0;
const double _kGapL = 28.0;

class FacilityChoiceScreen extends StatefulWidget {
  const FacilityChoiceScreen({super.key});

  @override
  State<FacilityChoiceScreen> createState() => _FacilityChoiceScreenState();
}

class _FacilityChoiceScreenState extends State<FacilityChoiceScreen>
    with TickerProviderStateMixin {
  String? _selectedType;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 150), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
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
            colors: [_kBgGradientStart, _kBgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: _kGapM, vertical: _kGapL),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Headline
                        const Text(
                          'Choose Your Setup',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: _kHeadlineColor,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapS),

                        // Subtitle
                        const Text(
                          'How would you like to use TrackPose?',
                          style: TextStyle(
                            fontSize: 16,
                            color: _kBodyColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapL * 1.5),

                        // Card A: Own Home Facility
                        _FacilityCard(
                          type: 'own_home',
                          isSelected: _selectedType == 'own_home',
                          iconAsset: 'assets/designs/icon_own_home.png',
                          title: 'OWN HOME FACILITY',
                          description:
                              'Set up monitoring for your own home or personal care environment',
                          actionText: 'Get Started',
                          borderColor: _kOwnHomeBlue,
                          actionColor: _kOwnHomeActionBlue,
                          delay: 0,
                          onTap: () {
                            setState(() => _selectedType = 'own_home');
                            // Parent flow: facility choice -> plan choice
                            GoRouter.of(context).go('/choose-plan');
                          },
                        ),
                        const SizedBox(height: _kGapM),

                        // Card B: Connect to Other Facilities
                        _FacilityCard(
                          type: 'connect',
                          isSelected: _selectedType == 'connect',
                          iconAsset: 'assets/designs/icon_connect.png',
                          title: 'CONNECT TO OTHER FACILITIES',
                          description:
                              'Link to childcare, school, care homes, or assisted living facilities',
                          actionText: 'Get Started',
                          borderColor: _kConnectPurple,
                          actionColor: _kConnectActionPurple,
                          delay: 200,
                          onTap: () {
                            setState(() => _selectedType = 'connect');
                            // Parent flow: facility choice -> plan choice
                            GoRouter.of(context).go('/choose-plan');
                          },
                        ),
                      ],
                    ),
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

class _FacilityCard extends StatefulWidget {
  final String type;
  final bool isSelected;
  final String iconAsset;
  final String title;
  final String description;
  final String actionText;
  final Color borderColor;
  final Color actionColor;
  final VoidCallback onTap;
  final int delay;

  const _FacilityCard({
    required this.type,
    required this.isSelected,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.actionText,
    required this.borderColor,
    required this.actionColor,
    required this.onTap,
    required this.delay,
  });

  @override
  State<_FacilityCard> createState() => _FacilityCardState();
}

class _FacilityCardState extends State<_FacilityCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + widget.delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Semantics(
              label: '${widget.title} - ${widget.description}',
              button: true,
              child: GestureDetector(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: widget.onTap,
                child: AnimatedScale(
                  scale: _isPressed ? 0.98 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_kCardRadius),
                      border: Border.all(
                        color: widget.isSelected
                            ? widget.borderColor
                            : Colors.grey.shade200,
                        width: widget.isSelected ? 3 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(15, 23, 36, 0.06),
                          blurRadius: widget.isSelected ? 48 : 36,
                          offset: const Offset(0, 8),
                        ),
                        if (widget.isSelected)
                          BoxShadow(
                            color: widget.borderColor.withValues(alpha: 0.2),
                            blurRadius: 24,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon badge with animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 1000 + widget.delay),
                          curve: Curves.elasticOut,
                          builder: (context, iconValue, child) {
                            return Transform.scale(
                              scale: iconValue,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: widget.type == 'own_home'
                                        ? [_kOwnHomeBlue, _kOwnHomeActionBlue]
                                        : [_kConnectPurple, _kConnectActionPurple],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.type == 'own_home'
                                          ? _kOwnHomeBlue.withValues(alpha: 0.3)
                                          : _kConnectPurple.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    widget.type == 'own_home'
                                        ? Icons.home_rounded
                                        : Icons.link,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: _kGapM + 4),

                        // Title - centered
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _kHeadlineColor,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapS),

                        // Description - centered
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: _kBodyColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapM + 4),

                        // Action text with chevron - centered
                        Semantics(
                          label: 'Get Started — ${widget.title.toLowerCase()}',
                          button: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.actionText,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: widget.actionColor,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: widget.actionColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
