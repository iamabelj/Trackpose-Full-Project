// TrackPose Design System - Brand Colors & Constants
// Centralized design tokens for consistent UI across all screens

import 'package:flutter/material.dart';

class BrandColors {
  // Primary Gradient Colors
  static const Color primaryPurple = Color(0xFF7A3FF2);
  static const Color primaryPink = Color(0xFFFF2E7A);
  
  // Background Gradients
  static const Color bgGradientStart = Color(0xFFE6F0FF);
  static const Color bgGradientEnd = Color(0xFFFFF0E6);
  
  // Text Colors
  static const Color headlineColor = Color(0xFF0F1724);
  static const Color bodyColor = Color(0xFF6B7280);
  static const Color mutedColor = Color(0xFF9CA3AF);
  
  // UI Colors
  static const Color cardBackground = Colors.white;
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);
  
  // Accent Colors
  static const Color ownHomeBlue = Color(0xFF2B9CFF);
  static const Color ownHomeActionBlue = Color(0xFF1E88FF);
  static const Color connectPurple = Color(0xFFA76BFF);
  static const Color connectActionPurple = Color(0xFFA347FF);
  
  // Border & Shadow
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color shadowColor = Color.fromRGBO(15, 23, 36, 0.06);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPurple, primaryPink],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bgGradientStart, bgGradientEnd],
  );
  
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ownHomeBlue, ownHomeActionBlue],
  );
  
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [connectPurple, connectActionPurple],
  );
}

class BrandRadius {
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double xlarge = 20.0;
  static const double xxlarge = 24.0;
  static const double circular = 28.0;
}

class BrandSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
}

class BrandShadows {
  static List<BoxShadow> get card => [
    const BoxShadow(
      color: BrandColors.shadowColor,
      blurRadius: 40,
      offset: Offset(0, 10),
    ),
  ];
  
  static List<BoxShadow> get elevated => [
    const BoxShadow(
      color: BrandColors.shadowColor,
      blurRadius: 48,
      offset: Offset(0, 12),
    ),
  ];
  
  static List<BoxShadow> purpleGlow(double alpha) => [
    BoxShadow(
      color: BrandColors.primaryPurple.withValues(alpha: alpha),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
  
  static List<BoxShadow> pinkGlow(double alpha) => [
    BoxShadow(
      color: BrandColors.primaryPink.withValues(alpha: alpha),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
  
  static List<BoxShadow> successGlow(double alpha) => [
    BoxShadow(
      color: BrandColors.successColor.withValues(alpha: alpha),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
}

class BrandTypography {
  static const TextStyle headline1 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: BrandColors.headlineColor,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: BrandColors.headlineColor,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: BrandColors.headlineColor,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: BrandColors.bodyColor,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    color: BrandColors.bodyColor,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: BrandColors.bodyColor,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}

// Reusable Widget Components
class BrandWidgets {
  // Gradient Icon Container
  static Widget gradientIcon({
    required IconData icon,
    double size = 100,
    double iconSize = 50,
    bool withAnimation = true,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: BrandColors.primaryGradient,
        boxShadow: BrandShadows.purpleGlow(0.4),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }
  
  // Gradient Button
  static Widget gradientButton({
    required String text,
    required VoidCallback onPressed,
    double height = 56,
    double borderRadius = 28,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: BrandColors.primaryGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: BrandShadows.purpleGlow(0.4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(text, style: BrandTypography.buttonText),
          ),
        ),
      ),
    );
  }
  
  // Card with gradient background
  static Widget card({
    required Widget child,
    EdgeInsets? padding,
    double borderRadius = 24,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: BrandColors.cardBackground,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: BrandShadows.card,
      ),
      child: child,
    );
  }
  
  // Input Field with brand styling
  static InputDecoration inputDecoration({
    required String label,
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BrandRadius.large),
        borderSide: const BorderSide(color: BrandColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BrandRadius.large),
        borderSide: const BorderSide(color: BrandColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BrandRadius.large),
        borderSide: const BorderSide(
          color: BrandColors.primaryPurple,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BrandRadius.large),
        borderSide: const BorderSide(color: BrandColors.errorColor),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }
}
