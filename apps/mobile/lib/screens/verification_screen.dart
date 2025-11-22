// Generated from design - TrackPose (source: file:///mnt/data/verification_screen.png)
// TODO: Add assets/designs/verify_mail.png to pubspec.yaml
// TODO: Integrate Firebase Auth / custom verification API to send and verify the 6-digit code. Replace the mock delay with real verification.
// TODO: Wire Firebase and server-side verification; securely store any tokens in flutter_secure_storage

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

// Design tokens - TODO: Move to theme.dart
const Color _kBgGradientStart = Color(0xFFE6F0FF);
const Color _kBgGradientEnd = Color(0xFFFFF0E6);
const Color _kHeadlineColor = Color(0xFF0F1724);
const Color _kBodyColor = Color(0xFF6B7280);
const Color _kPrimaryPurple = Color(0xFF7A3FF2);
const Color _kPrimaryPink = Color(0xFFFF2E7A);
const Color _kInputBg = Color(0xFFF3F4F6);
const Color _kGDPRBg = Color(0xFFE8FBEE);
const Color _kGDPRIcon = Color(0xFF00C853);
const double _kButtonRadius = 28.0;
const double _kButtonHeight = 56.0;
const double _kGapXS = 8.0;
const double _kGapS = 12.0;
const double _kGapM = 20.0;
const double _kGapL = 28.0;
const double _kOtpBoxSize = 48.0;
const double _kOtpBoxHeight = 56.0;

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  final String email = 'user@example.com'; // Demo email
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _animController.dispose();
    super.dispose();
  }

  Future<void> _verifyEmail() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6 || !RegExp(r'^\d{6}$').hasMatch(code)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit code')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      // Call auth provider to verify email
      final auth = ref.read(authProvider.notifier);
      await auth.verifyEmail(code);
      
      if (!mounted) return;
      
      setState(() => _isLoading = false);
      
      // Get user role from auth provider
      final userRole = ref.read(authProvider).role?.toUpperCase() ?? 'PARENT';
      
      // Navigate based on user role
      if (userRole == 'ADMIN' || userRole == 'MANAGER') {
        // Admin/Manager flow: email verification -> admin dashboard
        context.go('/admin-dashboard');
      } else if (userRole == 'STAFF' || userRole == 'CAREGIVER') {
        // Staff/Caregiver flow: email verification -> staff dashboard
        context.go('/staff-dashboard');
      } else {
        // Parent/Family flow: email verification -> facility choice
        context.go('/facility-choice');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: ${e.toString()}'),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }

  void _resendCode() {
    // TODO: Call Firebase resend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification code resent')),
    );
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
            child: SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: _kGapM, vertical: _kGapL),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon badge
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [_kPrimaryPurple, _kPrimaryPink],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(15, 23, 36, 0.06),
                                  blurRadius: 36,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.mail_outline,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: _kGapL),

                          // Headline
                          const Text(
                            'Verify Your Email',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: _kHeadlineColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: _kGapS),

                          // Subtitle
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 16, color: _kBodyColor),
                              children: [
                                const TextSpan(
                                    text: "We've sent a 6-digit code to\n"),
                                TextSpan(
                                  text: email,
                                  style: const TextStyle(
                                    color: _kPrimaryPurple,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: _kGapL),

                          // Label
                          const Text(
                            'Enter Verification Code',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _kHeadlineColor,
                            ),
                          ),
                          const SizedBox(height: _kGapS),

                          // OTP boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index < 5 ? _kGapS : 0,
                                ),
                                child: _OtpBox(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 5) {
                                      _focusNodes[index + 1].requestFocus();
                                    }
                                  },
                                  onBackspace: () {
                                    if (index > 0) {
                                      _focusNodes[index - 1].requestFocus();
                                    }
                                  },
                                  index: index,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: _kGapL),

                          // CTA button
                          Semantics(
                            button: true,
                            label: 'Verify Email',
                            child: SizedBox(
                              width: double.infinity,
                              height: _kButtonHeight,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [_kPrimaryPurple, _kPrimaryPink],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_kButtonRadius),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(15, 23, 36, 0.06),
                                      blurRadius: 36,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _verifyEmail,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(_kButtonRadius),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Verify Email',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: _kGapM),

                          // Resend link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive the code? ",
                                style:
                                    TextStyle(color: _kBodyColor, fontSize: 14),
                              ),
                              TextButton(
                                onPressed: _resendCode,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(
                                    color: _kPrimaryPurple,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: _kGapL),

                          // GDPR badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _kGDPRBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_user,
                                    color: _kGDPRIcon, size: 20),
                                SizedBox(width: _kGapXS),
                                Text(
                                  'GDPR Compliant · Secure Verification',
                                  style: TextStyle(
                                    color: _kGDPRIcon,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
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
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final int index;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Verification digit ${index + 1}',
      child: SizedBox(
        width: _kOtpBoxSize,
        height: _kOtpBoxHeight,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: _kHeadlineColor,
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: _kInputBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _kPrimaryPurple, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: onChanged,
          onTap: () {
            if (controller.text.isNotEmpty) {
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            }
          },
          onEditingComplete: () {
            if (controller.text.isEmpty && index > 0) {
              onBackspace();
            }
          },
        ),
      ),
    );
  }
}
