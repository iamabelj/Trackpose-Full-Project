// Generated from design - TrackPose (source: sign_up.png)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../config/app_theme.dart';

class SignupScreen extends ConsumerStatefulWidget {
  final String? role;
  
  const SignupScreen({super.key, this.role});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String _getPasswordStrength(String password) {
    if (password.length < 8) return 'Weak';
    if (password.length < 12 && !RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Weak';
    }
    if (password.length >= 12 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Strong';
    }
    return 'Medium';
  }

  Color _getStrengthColor(String strength) {
    switch (strength) {
      case 'Weak':
        return AppColors.errorColor;
      case 'Medium':
        return AppColors.warningColor;
      case 'Strong':
        return AppColors.successColor;
      default:
        return AppColors.textLight;
    }
  }

  double _getStrengthProgress(String strength) {
    switch (strength) {
      case 'Weak':
        return 0.33;
      case 'Medium':
        return 0.66;
      case 'Strong':
        return 1.0;
      default:
        return 0.0;
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authProvider.notifier);
    // Determine role from widget parameter or default to PARENT
    final userRole = widget.role?.toUpperCase() ?? 'PARENT';
    
    try {
      await auth.signup(
        fullName: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        role: userRole,
      );

      if (!mounted) return;
      context.go('/email-verification');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${e.toString()}'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  String? _validateName(String? v) {
    if (v == null || v.isEmpty) return 'Full name is required';
    if (v.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    final re = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!re.hasMatch(v)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != _passCtrl.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final passwordStrength = _getPasswordStrength(_passCtrl.text);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
                vertical: AppSpacing.pageVertical,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        color: AppColors.headlineColor,
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // Logo
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(AppRadius.large),
                          boxShadow: [AppShadows.card],
                        ),
                        child: const Icon(
                          Icons.person_add_outlined,
                          size: 56,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Title
                    Text(
                      'Create Account',
                      style: AppTypography.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      'Join TrackPose to start monitoring wellbeing',
                      style: AppTypography.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Full Name Field
                    AppTextField(
                      controller: _nameCtrl,
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                      keyboardType: TextInputType.name,
                      validator: _validateName,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Email Field
                    AppTextField(
                      controller: _emailCtrl,
                      label: 'Email Address',
                      hintText: 'your.email@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Password Field
                    AppTextField(
                      controller: _passCtrl,
                      label: 'Password',
                      hintText: 'Create a strong password',
                      obscureText: _obscurePassword,
                      validator: _validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.subtextColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    // Password Strength Indicator
                    if (_passCtrl.text.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.m),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.small),
                              child: LinearProgressIndicator(
                                value: _getStrengthProgress(passwordStrength),
                                backgroundColor: AppColors.borderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStrengthColor(passwordStrength),
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.m),
                          Text(
                            passwordStrength,
                            style: TextStyle(
                              fontSize: AppTypography.caption,
                              fontWeight: FontWeight.w600,
                              color: _getStrengthColor(passwordStrength),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Use 8+ characters with a mix of letters, numbers & symbols',
                        style: TextStyle(
                          fontSize: AppTypography.small,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),

                    // Confirm Password Field
                    AppTextField(
                      controller: _confirmCtrl,
                      label: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      obscureText: _obscureConfirm,
                      validator: _validateConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.subtextColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Sign Up Button
                    AppButton(
                      text: 'Create Account',
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // Terms Text
                    const Text(
                      'By creating an account, you agree to our Terms of Service and Privacy Policy',
                      style: TextStyle(
                        fontSize: AppTypography.small,
                        color: AppColors.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: AppTypography.body2,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
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
