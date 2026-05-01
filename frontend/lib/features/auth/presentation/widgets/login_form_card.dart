import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../application/auth_controller.dart';

class LoginFormCard extends ConsumerStatefulWidget {
  const LoginFormCard({super.key});

  @override
  ConsumerState<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends ConsumerState<LoginFormCard> {
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authState = ref.watch(authControllerProvider);
    _identityController.text = 'a@a.com';
    _passwordController.text = '123456';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('মোবাইল নম্বর বা ইমেইল', style: textTheme.labelMedium),
          const SizedBox(height: AppSpacing.xs),
          TextField(
            controller: _identityController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person_rounded,
                color: AppColors.textMuted,
              ),
              hintText: 'উদা: 017XXXXXXXX',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('পাসওয়ার্ড', style: textTheme.labelMedium),
          const SizedBox(height: AppSpacing.xs),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_rounded,
                color: AppColors.textMuted,
              ),
              hintText: '••••••••',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.push(AppRoutes.forgotPassword),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('পাসওয়ার্ড ভুলে গেছেন?'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppGradients.primaryButton,
              borderRadius: BorderRadius.circular(AppRadii.md),
              boxShadow: AppShadows.button,
            ),
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: authState.isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.onPrimary,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (authState.isSubmitting) ...[
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        authState.submitMessage ?? 'অপেক্ষা করুন',
                        style: textTheme.labelLarge,
                      ),
                    ] else ...[
                      Text('লগইন করুন', style: textTheme.labelLarge),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final identity = _identityController.text.trim();
    final password = _passwordController.text;

    if (identity.isEmpty || password.isEmpty) {
      _showMessage('ইমেইল/মোবাইল এবং পাসওয়ার্ড দিন।');
      return;
    }

    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(identity: identity, password: password);
      if (!mounted) {
        return;
      }

      final warningMessage = ref.read(authControllerProvider).warningMessage;
      if (warningMessage != null) {
        _showMessage(warningMessage);
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage(error.toString());
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
