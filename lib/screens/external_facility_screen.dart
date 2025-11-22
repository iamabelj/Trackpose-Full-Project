// Generated from design - TrackPose (source: file:///mnt/data/external_facility.png)
// TODO: Add assets to pubspec.yaml: assets/designs/icon_connect_facility.png
// TODO: Replace mock verification with backend call to Render-managed MySQL / facility lookup API; use signed requests and secure storage.
// TODO: Integrate flutter_secure_storage for token management.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Design tokens - TODO: move to theme.dart
const _kPageBgGradientStart = Color(0xFFE6F0FF);
const _kPageBgGradientEnd = Color(0xFFFFF0E6);
const _kHeadlineColor = Color(0xFF0F1724);
const _kBodyColor = Color(0xFF6B7280);
const _kCardBg = Color(0xFFFFFFFF);
const _kCardRadius = 20.0;
const _kInputBg = Color(0xFFF3F4F6);
const _kInputRadius = 14.0;
const _kInputHeight = 56.0;
const _kInfoCardBg = Color(0xFFF1F8FF);
const _kInfoCardRadius = 16.0;
const _kPrivacyBg = Color(0xFFE8FBEE);
const _kPrivacyRadius = 12.0;
const _kCtaGradientStart = Color(0xFF7A9BFF);
const _kCtaGradientEnd = Color(0xFFA676FF);
const _kCtaRadius = 28.0;
const _kCtaHeight = 56.0;
const _kLinkBlue = Color(0xFF1E88FF);
const _kCheckColor = Color(0xFF00C853);
const _kPagePadding = 20.0;
const _kGapXS = 8.0;
const _kGapS = 12.0;
const _kGapM = 20.0;
const _kGapL = 28.0;

class ExternalFacilityScreen extends StatefulWidget {
  const ExternalFacilityScreen({super.key});

  @override
  State<ExternalFacilityScreen> createState() => _ExternalFacilityScreenState();
}

class _ExternalFacilityScreenState extends State<ExternalFacilityScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _loading = false;
  String? _errorMsg;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _connectToFacility() async {
    setState(() => _errorMsg = null);
    final code = _codeController.text.trim().toUpperCase();

    if (code.length < 5 || code.length > 10) {
      setState(
        () => _errorMsg = 'Invalid access code. Please check and try again.',
      );
      _shakeController.forward(from: 0.0);
      return;
    }

    setState(() => _loading = true);

    // TODO: Replace with real backend verification
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _loading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Connection request sent')));

    // TODO: Replace with real server flow
    // Parent flow: external facility setup -> dashboard
    GoRouter.of(context).go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final shake = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kPageBgGradientStart, _kPageBgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(_kPagePadding),
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => GoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, size: 20),
                    label: const Text('Back to options'),
                    style: TextButton.styleFrom(foregroundColor: _kBodyColor),
                  ),
                ),
                const SizedBox(height: _kGapL),

                // Main card
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 40 < 920
                        ? MediaQuery.of(context).size.width - 40
                        : 920,
                  ),
                  decoration: BoxDecoration(
                    color: _kCardBg,
                    borderRadius: BorderRadius.circular(_kCardRadius),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(15, 23, 36, 0.06),
                        blurRadius: 36,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Icon badge
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [_kCtaGradientStart, _kCtaGradientEnd],
                            ),
                          ),
                          child: const Icon(
                            Icons.link,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: _kGapL),

                        // Headline
                        const Text(
                          'Connect to Facility',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: _kHeadlineColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapS),

                        // Subtitle
                        const Text(
                          'Enter the 6-digit access code provided by your facility',
                          style: TextStyle(fontSize: 16, color: _kBodyColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: _kGapL),

                        // Access code input
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Facility Access Code',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _kHeadlineColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: _kGapXS),
                        AnimatedBuilder(
                          animation: shake,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                shake.value *
                                    (_shakeController.value < 0.5 ? 1 : -1),
                                0,
                              ),
                              child: child,
                            );
                          },
                          child: Semantics(
                            label: 'Facility access code input',
                            child: Container(
                              height: _kInputHeight,
                              decoration: BoxDecoration(
                                color: _kInputBg,
                                borderRadius: BorderRadius.circular(
                                  _kInputRadius,
                                ),
                              ),
                              child: TextField(
                                controller: _codeController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  hintText: 'ABC123',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 16.0,
                                  ),
                                  errorText: _errorMsg,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2.0,
                                ),
                                onChanged: (value) {
                                  if (_errorMsg != null) {
                                    setState(() => _errorMsg = null);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        if (_errorMsg != null)
                          Padding(
                            padding: const EdgeInsets.only(top: _kGapXS),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _errorMsg!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: _kGapXS),
                        const Text(
                          'This code is provided by your childcare center, school, or care facility',
                          style: TextStyle(fontSize: 12, color: _kBodyColor),
                        ),
                        const SizedBox(height: _kGapL),

                        // What happens next card
                        _NumberedInfoCard(),
                        const SizedBox(height: _kGapM),

                        // Privacy panel
                        _PrivacyPanel(),
                        const SizedBox(height: _kGapL),

                        // CTA button
                        Semantics(
                          button: true,
                          label: 'Connect to Facility',
                          child: SizedBox(
                            width: double.infinity,
                            height: _kCtaHeight,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _connectToFacility,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    _kCtaRadius,
                                  ),
                                ),
                                elevation: 8,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      _kCtaGradientStart,
                                      _kCtaGradientEnd,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    _kCtaRadius,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: _loading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          'Connect to Facility',
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: _kGapM),

                // Footer link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an access code? ",
                      style: TextStyle(color: _kBodyColor, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement contact facility flow
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Contact facility feature coming soon',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Contact your facility',
                        style: TextStyle(
                          color: _kLinkBlue,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
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
    );
  }
}

class _NumberedInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kGapM),
      decoration: BoxDecoration(
        color: _kInfoCardBg,
        borderRadius: BorderRadius.circular(_kInfoCardRadius),
        border: Border.all(color: _kLinkBlue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What Happens Next?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kHeadlineColor,
            ),
          ),
          const SizedBox(height: _kGapM),
          _buildNumberedItem(
            1,
            "We'll verify your access code with the facility",
          ),
          const SizedBox(height: _kGapS),
          _buildNumberedItem(
            2,
            "Your child's profile will be linked to your account",
          ),
          const SizedBox(height: _kGapS),
          _buildNumberedItem(
            3,
            "You'll gain access to live monitoring and daily reports",
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedItem(int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: _kLinkBlue, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: _kGapS),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: _kHeadlineColor),
          ),
        ),
      ],
    );
  }
}

class _PrivacyPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _kPrivacyBg,
        borderRadius: BorderRadius.circular(_kPrivacyRadius),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: _kCheckColor, size: 20),
              SizedBox(width: _kGapXS),
              Text(
                'Privacy Protected:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kHeadlineColor,
                ),
              ),
            ],
          ),
          SizedBox(height: _kGapXS),
          Text(
            "You will only see your own child's profiles and activities. All access is logged and monitored by the facility.",
            style: TextStyle(fontSize: 13, color: _kBodyColor),
          ),
          SizedBox(height: _kGapXS),
          Text(
            'Facility staff will be notified of your connection request.',
            style: TextStyle(
              fontSize: 12,
              color: _kBodyColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
