import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class SignupFormCard extends StatefulWidget {
  const SignupFormCard({super.key, this.onSubmit});

  final Future<void> Function(SignupFormData data)? onSubmit;

  @override
  State<SignupFormCard> createState() => _SignupFormCardState();
}

class _SignupFormCardState extends State<SignupFormCard> {
  final _shopNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _shopNameController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
          _SignupField(
            label: 'দোকানের নাম',
            controller: _shopNameController,
            hintText: 'আপনার দোকানের নাম লিখুন',
            icon: Icons.storefront_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          _SignupField(
            label: 'পূর্ণ নাম',
            controller: _fullNameController,
            hintText: 'আপনার নাম লিখুন',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          _SignupField(
            label: 'মোবাইল নম্বর',
            controller: _phoneController,
            hintText: '০১৮XXXXXXXX',
            icon: Icons.smartphone_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          _SignupField(
            label: 'ইমেল',
            controller: _emailController,
            hintText: 'example@mail.com',
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),
          _SignupField(
            label: 'পাসওয়ার্ড',
            controller: _passwordController,
            hintText: '••••••••',
            icon: Icons.lock_rounded,
            obscureText: _obscurePassword,
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
          const SizedBox(height: AppSpacing.md),
          _SignupField(
            label: 'পাসওয়ার্ড নিশ্চিত করুন',
            controller: _confirmPasswordController,
            hintText: '••••••••',
            icon: Icons.verified_user_rounded,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppGradients.primaryButton,
              borderRadius: BorderRadius.circular(AppRadii.md),
              boxShadow: AppShadows.button,
            ),
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.onPrimary,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.onPrimary,
                        ),
                      )
                    : Text('অ্যাকাউন্ট তৈরি করুন', style: textTheme.labelLarge),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final data = SignupFormData(
      shopName: _shopNameController.text.trim(),
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (data.shopName.isEmpty || data.fullName.isEmpty || data.phone.isEmpty) {
      _showMessage('দোকানের নাম, নাম ও মোবাইল নম্বর দিন।');
      return;
    }

    if (!_looksLikeEmail(data.email)) {
      _showMessage('একটি সঠিক ইমেইল দিন।');
      return;
    }

    if (data.password.length < 6) {
      _showMessage('পাসওয়ার্ড কমপক্ষে ৬ অক্ষরের হতে হবে।');
      return;
    }

    if (data.password != data.confirmPassword) {
      _showMessage('পাসওয়ার্ড মিলছে না।');
      return;
    }

    if (widget.onSubmit == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await widget.onSubmit!(data);

      if (!mounted) {
        return;
      }

      _showMessage('ওটিপি ইমেইল পাঠানো হয়েছে।');
      context.push(AppRoutes.signupOtp, extra: data);
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

  bool _looksLikeEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class SignupFormData {
  const SignupFormData({
    required this.shopName,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String shopName;
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
}

class _SignupField extends StatelessWidget {
  const _SignupField({
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: textTheme.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textMuted),
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
