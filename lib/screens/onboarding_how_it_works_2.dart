// Generated from design - TrackPose
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _kCardCorner = 20.0;
const _kIconBg = Color(0xFFF3F6FF);
const _kMuted = Color(0xFF6B7280);
const _kPagerActive = Color(0xFFFF3BAC);
const _kHeadlineColor = Color(0xFF0F1724);
const _kButtonPrimary = Color(0xFF7A3FF2);

class OnboardingHowItWorks2 extends StatefulWidget {
  const OnboardingHowItWorks2({super.key});

  @override
  State<OnboardingHowItWorks2> createState() => _OnboardingHowItWorks2State();
}

class _OnboardingHowItWorks2State extends State<OnboardingHowItWorks2>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _cardController;
  late AnimationController _pulseController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _buttonPulseAnimation;

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
    
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _cardScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Curves.easeOutBack,
      ),
    );

    _buttonPulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _cardController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'brain':
        return Icons.psychology_outlined;
      case 'chart':
        return Icons.trending_up;
      case 'connect':
        return Icons.link;
      default:
        return Icons.check_circle_outline;
    }
  }

  Widget _featureRow(String iconName, String title, String subtitle, int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _kIconBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _kButtonPrimary.withValues(alpha: 0.1 * value),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    _getIcon(iconName),
                    size: 28,
                    color: _kButtonPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _kHeadlineColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _kMuted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // Animated Card
                  SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _cardScaleAnimation,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_kCardCorner),
                        ),
                        elevation: 8,
                        shadowColor: _kButtonPrimary.withValues(alpha: 0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              _featureRow(
                                'brain',
                                'AI detects emotional wellbeing',
                                'Real-time mood analysis',
                                0,
                              ),
                              const SizedBox(height: 16),
                              _featureRow(
                                'chart',
                                'Analyzes daily trends',
                                'Track patterns over time',
                                200,
                              ),
                              const SizedBox(height: 16),
                              _featureRow(
                                'connect',
                                'Helps you stay connected',
                                'Updates & insights instantly',
                                400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Animated Headline
                  SlideTransition(
                    position: _slideAnimation,
                    child: const Text(
                      'How It Works',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: _kHeadlineColor,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Animated Subtitle
                  SlideTransition(
                    position: _slideAnimation,
                    child: const Text(
                      'AI detects emotional wellbeing, analyzes daily trends, and helps you stay connected.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: _kMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Page Indicators
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIndicator(false),
                        const SizedBox(width: 8),
                        _buildIndicator(true),
                        const SizedBox(width: 8),
                        _buildIndicator(false),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Animated Next Button
                  ScaleTransition(
                    scale: _buttonPulseAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.push('/onboarding-privacy'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 8,
                            shadowColor: _kButtonPrimary.withValues(alpha: 0.4),
                            backgroundColor: _kButtonPrimary,
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? _kPagerActive : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
