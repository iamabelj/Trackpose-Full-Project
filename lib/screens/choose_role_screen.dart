// Generated from design - TrackPose (role_selection.png)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String _selected = '';

  Widget _roleCard(String key, String title, String desc, IconData icon) {
    final bool selected = _selected == key;
    return GestureDetector(
      onTap: () => setState(() => _selected = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5F3FF) : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: selected ? AppColors.primaryPurple : AppColors.borderColor,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? AppColors.primaryPurple.withValues(alpha: 0.15)
                  : AppColors.shadowColor,
              blurRadius: selected ? 16 : 12,
              offset: Offset(0, selected ? 8 : 4),
            )
          ],
        ),
        child: Row(
          children: [
            // Icon Avatar
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primaryPurple.withValues(alpha: 0.1)
                    : const Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color:
                    selected ? AppColors.primaryPurple : AppColors.subtextColor,
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppTypography.h5,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? AppColors.primaryPurple
                          : AppColors.headlineColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: AppTypography.body3,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtextColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Selection Indicator
            AnimatedOpacity(
              opacity: selected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.primaryPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
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
                  const SizedBox(height: AppSpacing.s),
                  // Progress Indicator
                  Center(
                    child: Text(
                      'Role → Facility → Account Setup',
                      style: TextStyle(
                        fontSize: AppTypography.caption,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryPurple.withValues(alpha: 0.7),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
          
                  // Headline
                  Text(
                    'Choose Your Role',
                    style: AppTypography.headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.m),
          
                  // Subtitle
                  Text(
                    'Select the option that best describes you',
                    style: AppTypography.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
          
                  // Role Cards
                  _roleCard(
                    'parent',
                    'Parents/Family',
                    'Monitor your loved ones in childcare, school, play centers, care homes, or assisted living facilities',
                    Icons.family_restroom,
                  ),
                  const SizedBox(height: AppSpacing.l),
          
                  _roleCard(
                    'staff',
                    'Staff/Caregiver',
                    'Provide care, get updates, and access wellbeing analytics for children, residents & managers at your facility',
                    Icons.medical_services_outlined,
                  ),
                  const SizedBox(height: AppSpacing.l),
          
                  _roleCard(
                    'admin',
                    'Admin / Manager',
                    'Manage facilities, staff, and oversee wellbeing analytics',
                    Icons.admin_panel_settings_outlined,
                  ),
          
                  const SizedBox(height: AppSpacing.xxxl),
          
                  // Continue Button
                  AppButton(
                    text: 'Continue',
                    onPressed: _selected.isEmpty
                        ? null
                        : () {
                            // Navigate based on selected role and pass role as parameter
                            if (_selected == 'parent') {
                              // Parent/Family flow: signup -> email verification -> facility choice
                              context.go('/signup?role=parent');
                            } else if (_selected == 'staff') {
                              // Staff/Caregiver flow: directly to caregiver facility setup
                              context.go('/caregiver-facility-setup');
                            } else if (_selected == 'admin') {
                              // Admin flow: signup -> email verification -> admin dashboard
                              context.go('/signup?role=admin');
                            }
                          },
                    isDisabled: _selected.isEmpty,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
