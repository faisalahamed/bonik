import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../widgets/signup_form_card.dart';

class SignupOtpPage extends StatefulWidget {
  const SignupOtpPage({super.key, required this.signupData});

  final SignupFormData? signupData;

  @override
  State<SignupOtpPage> createState() => _SignupOtpPageState();
}

class _SignupOtpPageState extends State<SignupOtpPage> {
  static const int _codeLength = 4;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleCodeChanged(String value, int index) {
    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    final signupData = widget.signupData;
    if (signupData == null) {
      _showMessage('সাইনআপ তথ্য পাওয়া যায়নি। আবার সাইনআপ করুন।');
      context.go(AppRoutes.signup);
      return;
    }

    final otp = _controllers.map((controller) => controller.text).join();
    if (otp.length != _codeLength) {
      _showMessage('৪ ডিজিটের ওটিপি লিখুন।');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repository = AuthRepositoryImpl(
        AuthRemoteDataSource(const ApiClient()),
      );

      await repository.verifySignupOtp(
        email: signupData.email,
        otp: otp,
        shopName: signupData.shopName,
        fullName: signupData.fullName,
        phone: signupData.phone,
        password: signupData.password,
        confirmPassword: signupData.confirmPassword,
      );

      if (!mounted) {
        return;
      }

      _showMessage('অ্যাকাউন্ট তৈরি হয়েছে। লগইন করুন।');
      context.go(AppRoutes.login);
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage(error.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SoftBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.xs,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => context.pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: EdgeInsets.zero,
                        textStyle: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back_rounded, size: 28),
                      label: const Text('ফিরে যান'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.xxl,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Column(
                          children: [
                            const _BrandMark(),
                            const SizedBox(height: 40),
                            _OtpCard(
                              controllers: _controllers,
                              focusNodes: _focusNodes,
                              onChanged: _handleCodeChanged,
                              isSubmitting: _isSubmitting,
                              onVerify: _verifyOtp,
                            ),
                            const SizedBox(height: 56),
                            const _DecorativeBlock(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(28),
            boxShadow: AppShadows.button,
          ),
          child: const Icon(
            Icons.water_drop_outlined,
            color: AppColors.onPrimary,
            size: 46,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'ভূঁইয়া স্যানিটারি',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _OtpCard extends StatelessWidget {
  const _OtpCard({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.isSubmitting,
    required this.onVerify,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(String value, int index) onChanged;
  final bool isSubmitting;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 38, 32, 34),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Text(
            'ওটিপি ভেরিফিকেশন',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'আপনার ইমেইলে একটি ৪ ডিজিটের কোড পাঠানো হয়েছে। অনুগ্রহ করে নিচে কোডটি লিখুন।',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 34),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.sm;
              final fieldWidth = ((constraints.maxWidth - (gap * 3)) / 4)
                  .clamp(52.0, 64.0)
                  .toDouble();
              final fieldHeight = (fieldWidth * 1.22)
                  .clamp(68.0, 78.0)
                  .toDouble();

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controllers.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      right: index == controllers.length - 1 ? 0 : gap,
                    ),
                    child: _OtpDigitField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      autofocus: index == 0,
                      width: fieldWidth,
                      height: fieldHeight,
                      onChanged: (value) => onChanged(value, index),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 34),
          Text.rich(
            TextSpan(
              text: 'কোড পাননি?  ',
              children: [
                TextSpan(
                  text: '২:০০ সেকেন্ড পর আবার চেষ্টা করুন',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 34),
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onVerify,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
                elevation: 14,
                shadowColor: AppColors.primary.withValues(alpha: 0.24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.onPrimary,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ভেরিফাই করুন',
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Icon(Icons.verified_outlined, size: 28),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              textStyle: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            child: const Text('লগইন এ ফিরে যান'),
          ),
        ],
      ),
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  const _OtpDigitField({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.width,
    required this.height,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final double width;
  final double height;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: textTheme.headlineMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.surfaceContainerLow,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
            borderSide: const BorderSide(color: Color(0xFFC9DBD6), width: 2),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class _DecorativeBlock extends StatelessWidget {
  const _DecorativeBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 104,
      color: AppColors.surfaceContainerHighest.withValues(alpha: 0.72),
    );
  }
}

class _SoftBackground extends StatelessWidget {
  const _SoftBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.7, -0.95),
          radius: 1.1,
          colors: [
            AppColors.primary.withValues(alpha: 0.05),
            AppColors.surface.withValues(alpha: 0),
          ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}
