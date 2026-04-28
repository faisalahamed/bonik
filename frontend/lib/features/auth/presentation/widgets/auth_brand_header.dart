import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryButton,
            borderRadius: BorderRadius.circular(AppRadii.md),
            boxShadow: AppShadows.button,
          ),
          child: const Icon(
            Icons.sanitizer_outlined,
            color: Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'BHUIYAN SANITARY',
          style: textTheme.labelMedium?.copyWith(
            letterSpacing: 4.2,
            color: AppColors.primary.withOpacity(0.55),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          title,
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
