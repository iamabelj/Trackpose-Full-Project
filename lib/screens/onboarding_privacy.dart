// Generated from design - TrackPose (onboarding_privacy.png)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class OnboardingPrivacy extends StatefulWidget {
  const OnboardingPrivacy({super.key});

  @override
  State<OnboardingPrivacy> createState() => _OnboardingPrivacyState();
}

class _OnboardingPrivacyState extends State<OnboardingPrivacy>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _shieldController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shieldPulseAnimation;

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
    
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _shieldController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
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

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut,
      ),
    );

    _shieldPulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _shieldController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations in sequence
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 150), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _shieldController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _shieldController.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // Privacy Features Card with Animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.xxl),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(AppRadius.xlarge),
                            boxShadow: [
                              AppShadows.card,
                              BoxShadow(
                                color: AppColors.successColor.withValues(alpha: 0.1),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Animated Shield Icon
                              ScaleTransition(
                                scale: _shieldPulseAnimation,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: AppColors.successColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.successColor.withValues(alpha: 0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.verified_user,
                                    size: 50,
                                    color: AppColors.successColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xl),

                              // Animated Features
                              _buildFeatureBadge(
                                'GDPR-compliant protection',
                                const Color(0xFFE8FBEE),
                                0,
                              ),
                              const SizedBox(height: AppSpacing.m),
                              _buildFeatureBadge(
                                'Enterprise-grade security',
                                const Color(0xFFE6F0FF),
                                200,
                              ),
                              const SizedBox(height: AppSpacing.m),
                              _buildFeatureBadge(
                                'End-to-end encryption',
                                const Color(0xFFF5F3FF),
                                400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxxl),

                    // Animated Headline
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Your Privacy Matters',
                          style: AppTypography.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // Animated Subtitle
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "GDPR-compliant, enterprise-grade security — protecting your data and your loved ones' moments.",
                          style: AppTypography.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxxl),

                    // Page Indicator
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIndicator(false),
                          const SizedBox(width: AppSpacing.s),
                          _buildIndicator(false),
                          const SizedBox(width: AppSpacing.s),
                          _buildIndicator(true),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Continue Button with Animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: AppButton(
                          text: 'Continue',
                          onPressed: () => context.go('/choose-role'),
                        ),
                      ),
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

  Widget _buildFeatureBadge(String text, Color bgColor, int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.l,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppRadius.circular),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.successColor.withValues(alpha: 0.1 * value),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.successColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: AppTypography.body2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headlineColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
