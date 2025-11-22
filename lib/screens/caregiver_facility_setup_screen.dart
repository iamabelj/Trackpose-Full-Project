// Generated from design - TrackPose (source: file:///mnt/data/caregiver_facility_setup.png)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

// TODO: Add assets to pubspec.yaml: assets/designs/icon_staff.png
// TODO: Integrate with backend: Render-managed MySQL, access control, and secure token storage
// TODO: Ensure GDPR erasure endpoint and audit logging implemented server-side.

// ============================================================================
// DESIGN TOKENS - TODO: move to theme.dart
// ============================================================================

const Color kPageBgStartColor = Color(0xFFE6F0FF);
const Color kPageBgEndColor = Color(0xFFFFF0E6);
const Color kHeadlineColor = Color(0xFF0F1724);
const Color kSubtextColor = Color(0xFF6B7280);
const Color kCardBgColor = Color(0xFFFFFFFF);
const Color kPrimaryGradientStart = Color(0xFF7A3FF2);
const Color kPrimaryGradientEnd = Color(0xFFFF2E7A);
const Color kRolePillBgStart = Color(0xFFFFF0F8);
const Color kRolePillBgEnd = Color(0xFFF5F0FF);
const Color kInfoGreenBg = Color(0xFFE8FBEE);
const Color kInfoGreenBorder = Color(0xFFDFF6E6);
const Color kInfoGreenCheck = Color(0xFF00C853);
const Color kInputBg = Color(0xFFF3F4F6);
const Color kGdprInfoBg = Color(0xFFF1F8FF);
const Color kGdprInfoBorder = Color(0xFFDFF3FF);

const double kCardRadius = 20.0;
const double kInputRadius = 14.0;
const double kButtonRadius = 28.0;
const double kInputHeight = 56.0;
const double kButtonHeight = 56.0;
const double kPagePadding = 20.0;
const double kGapXS = 8.0;
const double kGapS = 12.0;
const double kGapM = 20.0;
const double kGapL = 28.0;

const BoxShadow kCardShadow = BoxShadow(
  color: Color.fromRGBO(15, 23, 36, 0.06),
  blurRadius: 36,
  offset: Offset(0, 8),
);

// ============================================================================
// DATA MODELS
// ============================================================================

class FacilityType {
  final String key;
  final String label;

  const FacilityType({required this.key, required this.label});
}

// Facility types as requested
const List<FacilityType> kFacilityTypes = [
  FacilityType(key: 'school', label: 'School'),
  FacilityType(key: 'care_home', label: 'Care Home'),
  FacilityType(key: 'assisted_living', label: 'Assisted Living Center'),
  FacilityType(key: 'childcare_center', label: 'Childcare Center'),
  FacilityType(key: 'play_center', label: 'Play Center'),
];

// ============================================================================
// CAREGIVER FACILITY SETUP SCREEN
// ============================================================================

class CaregiverFacilitySetupScreen extends StatefulWidget {
  const CaregiverFacilitySetupScreen({super.key});

  @override
  State<CaregiverFacilitySetupScreen> createState() =>
      _CaregiverFacilitySetupScreenState();
}

class _CaregiverFacilitySetupScreenState
    extends State<CaregiverFacilitySetupScreen> with TickerProviderStateMixin {
  FacilityType? _selectedFacilityType;
  String? _validationError;
  bool _isVerifying = false;
  late AnimationController _cardController;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyFacility() async {
    setState(() {
      _validationError = null;
    });

    // Validation
    if (_selectedFacilityType == null) {
      setState(() {
        _validationError = 'Please select a facility type.';
      });
      _shakeCard();
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    // Mock verification with random success/failure (10% failure rate for demo)
    // TODO: Replace mock verification with real API call to Render-managed MySQL
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    // Simulate 10% failure rate (seeded for demo)
    final random = math.Random();
    final shouldFail = random.nextInt(10) == 0;

    setState(() {
      _isVerifying = false;
    });

    if (shouldFail) {
      setState(() {
        _validationError =
            'Verification failed. Please check your facility details or contact admin.';
      });
      _shakeCard();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facility verified — access granted'),
          ),
        );
        // Staff/Caregiver flow: caregiver facility setup -> dashboard
        context.go('/dashboard');
      }
    }
  }

  void _shakeCard() {
    _shakeController.reset();
    _shakeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contentWidth = math.min(size.width - 40, 920.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPageBgStartColor, kPageBgEndColor],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Padding(
                      padding: const EdgeInsets.all(kPagePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: kGapL),
                          _buildHeader(),
                          const SizedBox(height: kGapL),
                          _buildMainCard(),
                          const SizedBox(height: 100), // Space for FAB
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildFloatingVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Facility & Access Setup',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: kHeadlineColor,
          ),
        ),
        SizedBox(height: kGapS),
        Text(
          'Connect to your facility to get started',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: kSubtextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardController,
        curve: Curves.easeOut,
      )),
      child: FadeTransition(
        opacity: _cardController,
        child: AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            final sineValue = math.sin(_shakeController.value * math.pi * 4) *
                (1 - _shakeController.value);
            return Transform.translate(
              offset: Offset(sineValue * 10, 0),
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kCardBgColor,
              borderRadius: BorderRadius.circular(kCardRadius),
              boxShadow: const [kCardShadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRolePill(),
                const SizedBox(height: kGapL),
                _buildInfoPanel(),
                const SizedBox(height: kGapL),
                _buildFacilityTypeField(),
                const SizedBox(height: kGapL),
                _buildGdprPanel(),
                if (_validationError != null) ...[
                  const SizedBox(height: kGapM),
                  _buildErrorMessage(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRolePill() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kRolePillBgStart, kRolePillBgEnd],
        ),
        borderRadius: BorderRadius.circular(kInputRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kPrimaryGradientStart, kPrimaryGradientEnd],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: kGapM),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Staff/Caregiver',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kHeadlineColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Setting up your access',
                  style: TextStyle(
                    fontSize: 14,
                    color: kSubtextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPanel() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kInfoGreenBg,
          borderRadius: BorderRadius.circular(kInputRadius),
          border: Border.all(color: kInfoGreenBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: kInfoGreenCheck,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: kGapM),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Staff members receive full access automatically',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kHeadlineColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'As a verified facility employee, you\'ll have unlimited access to all features',
                    style: TextStyle(
                      fontSize: 13,
                      color: kSubtextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Facility Type *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kHeadlineColor,
          ),
        ),
        const SizedBox(height: kGapS),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _showFacilityTypePicker,
            borderRadius: BorderRadius.circular(kInputRadius),
            child: Container(
              height: kInputHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: kInputBg,
                borderRadius: BorderRadius.circular(kInputRadius),
                border: _validationError != null
                    ? Border.all(color: Colors.red, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedFacilityType?.label ?? 'Select facility type',
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedFacilityType != null
                            ? kHeadlineColor
                            : kSubtextColor,
                      ),
                    ),
                  ),
                  const Icon(Icons.expand_more, color: kSubtextColor),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: kGapXS),
        const Text(
          'Choose the type of facility you\'re connecting to',
          style: TextStyle(
            fontSize: 13,
            color: kSubtextColor,
          ),
        ),
      ],
    );
  }

  void _showFacilityTypePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: kGapM),
            const Text(
              'Select Facility Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 32),
            ...kFacilityTypes.map((type) => ListTile(
                  title: Text(type.label),
                  trailing: _selectedFacilityType?.key == type.key
                      ? const Icon(Icons.check, color: kPrimaryGradientStart)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFacilityType = type;
                      _validationError = null;
                    });
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: kGapM),
          ],
        ),
      ),
    );
  }

  Widget _buildGdprPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kGdprInfoBg,
        borderRadius: BorderRadius.circular(kInputRadius),
        border: Border.all(color: kGdprInfoBorder),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: kPrimaryGradientStart,
            size: 20,
          ),
          SizedBox(width: kGapS),
          Expanded(
            child: Text(
              'Your information is encrypted and securely stored in compliance with GDPR regulations.',
              style: TextStyle(
                fontSize: 13,
                color: kSubtextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(kInputRadius),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: kGapS),
          Expanded(
            child: Text(
              _validationError!,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingVerifyButton() {
    return Positioned(
      right: kPagePadding,
      bottom: kPagePadding + 20,
      child: AnimatedScale(
        scale: _isVerifying ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(kButtonRadius),
          child: InkWell(
            onTap: _isVerifying ? null : _handleVerifyFacility,
            borderRadius: BorderRadius.circular(kButtonRadius),
            child: Ink(
              decoration: BoxDecoration(
                gradient: _isVerifying
                    ? const LinearGradient(
                        colors: [Colors.grey, Colors.grey],
                      )
                    : const LinearGradient(
                        colors: [kPrimaryGradientStart, kPrimaryGradientEnd],
                      ),
                borderRadius: BorderRadius.circular(kButtonRadius),
              ),
              child: Container(
                height: kButtonHeight,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                alignment: Alignment.center,
                child: _isVerifying
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Verify Facility',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 20),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
