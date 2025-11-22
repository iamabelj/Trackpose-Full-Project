// Generated from design - TrackPose (source: login_screen.png)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../config/app_theme.dart';

// Test credentials for dev: admin@trackpose.test / Admin1234!

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authProvider.notifier);
    try {
      await auth.login(_emailCtrl.text.trim(), _passCtrl.text);

      if (!mounted) return;

      // Navigate based on auth state
      final authState = ref.read(authProvider);
      if (!authState.isEmailVerified) {
        context.go('/email-verification');
      } else {
        // Navigate to role-adaptive dashboard
        final role = authState.role ?? 'PARENT';
        if (role == 'ADMIN' || role == 'MANAGER') {
          context.go('/admin-dashboard');
        } else if (role == 'STAFF' || role == 'CAREGIVER') {
          context.go('/staff-dashboard');
        } else {
          context.go('/parent-dashboard');
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    final re = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!re.hasMatch(v)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

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
                    // Logo and Title - Gradient Icon
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: AppColors.primaryGradient,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPurple.withValues(alpha: 0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.account_circle_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Title
                    Text(
                      'Welcome Back',
                      style: AppTypography.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      'Sign in to continue monitoring your loved ones',
                      style: AppTypography.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.huge),

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
                      hintText: 'Enter your password',
                      obscureText: _obscurePassword,
                      validator: _validatePass,
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
                    const SizedBox(height: AppSpacing.m),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: AppTypography.body3,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Login Button
                    AppButton(
                      text: 'Login',
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.push('/signup'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: AppTypography.body2,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Dev credentials
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.m),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Test Credentials',
                            style: TextStyle(
                              fontSize: AppTypography.caption,
                              fontWeight: FontWeight.w600,
                              color: AppColors.headlineColor,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                            'admin@trackpose.test',
                            style: TextStyle(
                              fontSize: AppTypography.small,
                              color: AppColors.subtextColor,
                            ),
                          ),
                          Text(
                            'Admin1234!',
                            style: TextStyle(
                              fontSize: AppTypography.small,
                              color: AppColors.subtextColor,
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
    );
  }
}
