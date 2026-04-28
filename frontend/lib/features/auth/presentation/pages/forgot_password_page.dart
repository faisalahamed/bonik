import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/forgot_password_form_card.dart';
import '../widgets/login_background.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthTopBar(title: 'পাসওয়ার্ড পুনরুদ্ধার'),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LoginBackground(),
          SafeArea(
            top: false,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xxl,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 420),
                  child: ForgotPasswordFormCard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
