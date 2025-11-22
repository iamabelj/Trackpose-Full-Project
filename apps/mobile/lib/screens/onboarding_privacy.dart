// Generated from design - TrackPose (onboarding_privacy.png)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class OnboardingPrivacy extends StatelessWidget {
  const OnboardingPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
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

                  // Privacy Features Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(AppRadius.xlarge),
                      boxShadow: [AppShadows.card],
                    ),
                    child: Column(
                      children: [
                        // Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color:
                                AppColors.successColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.security,
                            size: 40,
                            color: AppColors.successColor,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Features
                        _buildFeatureBadge(
                          'GDPR-compliant protection',
                          const Color(0xFFE8FBEE),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        _buildFeatureBadge(
                          'Enterprise-grade security',
                          const Color(0xFFE6F0FF),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        _buildFeatureBadge(
                          'End-to-end encryption',
                          const Color(0xFFF5F3FF),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  // Headline
                  Text(
                    'Your Privacy Matters',
                    style: AppTypography.headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.l),

                  // Subtitle
                  Text(
                    "GDPR-compliant, enterprise-grade security — protecting your data and your loved ones' moments.",
                    style: AppTypography.bodyLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIndicator(false),
                      const SizedBox(width: AppSpacing.s),
                      _buildIndicator(false),
                      const SizedBox(width: AppSpacing.s),
                      _buildIndicator(true),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Continue Button
                  AppButton(
                    text: 'Continue',
                    onPressed: () => context.go('/choose-role'),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBadge(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.l,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.circular),
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
