// TrackPose Design System - Centralized Theme Configuration
// Based on design files in apps/mobile/designs/

import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primaryPurple = Color(0xFF7A3FF2);
  static const Color primaryPink = Color(0xFFFF2E7A);

  // Background Gradients
  static const Color bgGradientStart = Color(0xFFE6F0FF);
  static const Color bgGradientEnd = Color(0xFFFFF0E6);

  // Text Colors
  static const Color headlineColor = Color(0xFF0F1724);
  static const Color subtextColor = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // UI Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF9FAFB);
  static const Color borderColor = Color(0xFFE5E7EB);

  // Status Colors
  static const Color liveBadgeBg = Color(0xFFE8FBEE);
  static const Color liveDotColor = Color(0xFF00C853);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);

  // Chart Colors
  static const Color chartCalmColor = Color(0xFF4AA3FF);
  static const Color chartHappyColor = Color(0xFFFFC857);
  static const Color chartJoyfulColor = Color(0xFFA76BFF);

  // Shadow
  static const Color shadowColor = Color.fromRGBO(15, 23, 36, 0.06);

  // Gradients
  static const List<Color> primaryGradient = [primaryPurple, primaryPink];

  static LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [bgGradientStart, bgGradientEnd],
      );

  static LinearGradient get buttonGradient => const LinearGradient(
        colors: primaryGradient,
      );
}

class AppTypography {
  // Font Family
  static const String fontFamily = 'Inter'; // or default system font

  // Font Sizes
  static const double h1 = 34.0;
  static const double h2 = 28.0;
  static const double h3 = 22.0;
  static const double h4 = 20.0;
  static const double h5 = 18.0;
  static const double body1 = 16.0;
  static const double body2 = 15.0;
  static const double body3 = 14.0;
  static const double caption = 13.0;
  static const double small = 12.0;
  static const double tiny = 11.0;
  static const double micro = 10.0;

  // Text Styles
  static TextStyle get headline1 => const TextStyle(
        fontSize: h1,
        fontWeight: FontWeight.w700,
        color: AppColors.headlineColor,
        height: 1.2,
      );

  static TextStyle get headline2 => const TextStyle(
        fontSize: h2,
        fontWeight: FontWeight.w700,
        color: AppColors.headlineColor,
        height: 1.3,
      );

  static TextStyle get headline3 => const TextStyle(
        fontSize: h3,
        fontWeight: FontWeight.w600,
        color: AppColors.headlineColor,
        height: 1.3,
      );

  static TextStyle get headline4 => const TextStyle(
        fontSize: h4,
        fontWeight: FontWeight.w600,
        color: AppColors.headlineColor,
        height: 1.3,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: body1,
        fontWeight: FontWeight.w400,
        color: AppColors.subtextColor,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: body2,
        fontWeight: FontWeight.w400,
        color: AppColors.subtextColor,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: body3,
        fontWeight: FontWeight.w400,
        color: AppColors.subtextColor,
        height: 1.4,
      );

  static TextStyle get captionText => const TextStyle(
        fontSize: caption,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
        height: 1.4,
      );

  static TextStyle get buttonText => const TextStyle(
        fontSize: h5,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;

  // Page Padding
  static const double pageHorizontal = 20.0;
  static const double pageVertical = 24.0;
}

class AppRadius {
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double xlarge = 20.0;
  static const double button = 28.0;
  static const double circular = 999.0;
}

class AppShadows {
  static BoxShadow get card => const BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 36,
        offset: Offset(0, 8),
      );

  static BoxShadow get button => const BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 24,
        offset: Offset(0, 4),
      );

  static BoxShadow get elevated => const BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 48,
        offset: Offset(0, 12),
      );
}

class AppDimensions {
  static const double buttonHeight = 56.0;
  static const double inputHeight = 52.0;
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 48.0;
  static const double avatarLarge = 64.0;
  static const double logoSize = 160.0;
  static const double maxContentWidth = 920.0;
}

// Reusable Widget Components
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      decoration: BoxDecoration(
        gradient: isSecondary || isDisabled ? null : AppColors.buttonGradient,
        color: isSecondary
            ? Colors.white
            : isDisabled
                ? AppColors.borderColor
                : null,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: isSecondary
            ? Border.all(color: AppColors.primaryPurple, width: 2)
            : null,
        boxShadow: isDisabled ? [] : [AppShadows.button],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading || isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isSecondary ? AppColors.primaryPurple : Colors.white,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: AppTypography.buttonText.copyWith(
                      color:
                          isSecondary ? AppColors.primaryPurple : Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppTypography.body3,
            fontWeight: FontWeight.w600,
            color: AppColors.headlineColor,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.textLight),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: const BorderSide(
                color: AppColors.primaryPurple,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: const BorderSide(color: AppColors.errorColor),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.l,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
