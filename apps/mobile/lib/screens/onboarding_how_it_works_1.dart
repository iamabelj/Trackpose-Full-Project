// Generated from design - TrackPose (how_it_works_1.png)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class OnboardingHowItWorks1 extends StatefulWidget {
  const OnboardingHowItWorks1({super.key});

  @override
  State<OnboardingHowItWorks1> createState() => _OnboardingHowItWorks1State();
}

class _OnboardingHowItWorks1State extends State<OnboardingHowItWorks1>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _iconController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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

    _iconScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.elasticOut,
      ),
    );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _iconController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                  vertical: AppSpacing.pageVertical,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    
                    // Animated Icon Card
                    SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: _buildIconCard(),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Headline
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        'How It Works',
                        style: AppTypography.headline1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: AppSpacing.l),
                    
                    // Subtitle
                    SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'AI detects emotional wellbeing, analyzes daily trends, and helps you stay connected.',
                          style: AppTypography.bodyLarge.copyWith(height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // Feature Icons Row
                    SlideTransition(
                      position: _slideAnimation,
                      child: _buildFeatureIcons(),
                    ),
                    
                    const SizedBox(height: 80),
                    
                    // Next Button
                    SlideTransition(
                      position: _slideAnimation,
                      child: AppButton(
                        text: 'Next',
                        onPressed: () => context.push('/onboarding-2'),
                      ),
                    ),
                    
                    const SizedBox(height: AppSpacing.xxl),
                    
                    // Page Indicators
                    Center(
                      child: _buildPageIndicators(),
                    ),
                    
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            shape: BoxShape.circle,
            boxShadow: [
              AppShadows.elevated,
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.15 + (0.1 * value)),
                blurRadius: 40 + (20 * value),
                spreadRadius: 10 + (5 * value),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated outer ring
              Transform.rotate(
                angle: value * 6.28, // Full rotation
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryPurple.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              // Inner gradient circle with pulse
              Transform.scale(
                scale: 1.0 + (0.05 * value),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryPurple,
                        AppColors.primaryPink,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.psychology_outlined,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureIcon(
          Icons.trending_up,
          'Analyze',
        ),
        const SizedBox(width: 32),
        _buildFeatureIcon(
          Icons.favorite_border,
          'Detect',
        ),
        const SizedBox(width: 32),
        _buildFeatureIcon(
          Icons.notifications_active_outlined,
          'Alert',
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryPurple.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: AppColors.primaryPurple,
                ),
              ),
              const SizedBox(height: AppSpacing.m),
              Text(
                label,
                style: TextStyle(
                  fontSize: AppTypography.body3,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headlineColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIndicator(true),
        const SizedBox(width: AppSpacing.s),
        _buildIndicator(false),
        const SizedBox(width: AppSpacing.s),
        _buildIndicator(false),
      ],
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryPink : AppColors.borderColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
