import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class ProfitLossReportDetailsPage extends StatelessWidget {
  const ProfitLossReportDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ProfitLossTopBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: -80,
                  right: -70,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.backgroundGlowTop,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -120,
                  left: -70,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.backgroundGlowBottom,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  children: const [
                    _ProfitLossDateCard(),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossFilters(),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossHeroCard(),
                    SizedBox(height: AppSpacing.xl),
                    _ProfitLossSectionHeader(),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossRecordCard(
                      code: '#539902',
                      time: '12:00 PM',
                      name: 'রুহাইয়া সুলতানা',
                      leftValue: '৩৬,৪৮০',
                      rightValue: '২৮,৮৮০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossRecordCard(
                      code: '#539891',
                      time: '11:15 AM',
                      name: 'আরিফুল হক',
                      leftValue: '৯১,৮০০',
                      rightValue: '৮৯,২০০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossRecordCard(
                      code: '#539884',
                      time: '09:45 AM',
                      name: 'মোশারফ কামরীর হার্ডওয়্যার',
                      leftValue: '৭২,১০০',
                      rightValue: '৮,৪২০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ProfitLossRecordCard(
                      code: '#539880',
                      time: 'YESTERDAY',
                      name: 'তাসিন উদ্দিন',
                      leftValue: '৮৬,৬০০',
                      rightValue: '৯১,০৫০',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfitLossTopBar extends StatelessWidget {
  const _ProfitLossTopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Text(
                  'লাভ ও ক্ষতি প্রতিবেদন',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfitLossDateCard extends StatelessWidget {
  const _ProfitLossDateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          const Icon(Icons.chevron_left_rounded, color: AppColors.primary),
          const Spacer(),
          Column(
            children: [
              Text(
                'সময়সীমা',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '০১ এপ্রিল, ২৬ - ৩০ এপ্রিল, ২৬',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _ProfitLossFilters extends StatelessWidget {
  const _ProfitLossFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _ProfitLossChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ProfitLossChip(label: 'মাস')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ProfitLossChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ProfitLossChip(label: 'সব সময়')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ProfitLossChip(label: 'কাস্টম')),
      ],
    );
  }
}

class _ProfitLossChip extends StatelessWidget {
  const _ProfitLossChip({
    required this.label,
    this.active = false,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: active ? AppGradients.primaryButton : null,
        color: active ? null : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: active ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _ProfitLossHeroCard extends StatelessWidget {
  const _ProfitLossHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'মোট-নিটের লাভ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '৮,৬৩৪.৮ ৳',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Text(
                  'বাকি ( বেচা )',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                '৭,৫৮৮.৫ ৳',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfitLossSectionHeader extends StatelessWidget {
  const _ProfitLossSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'লেনদেন রেকর্ডসমূহ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F4EE),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '৬৩টি লেনদেন',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}

class _ProfitLossRecordCard extends StatelessWidget {
  const _ProfitLossRecordCard({
    required this.code,
    required this.time,
    required this.name,
    required this.leftValue,
    required this.rightValue,
  });

  final String code;
  final String time;
  final String name;
  final String leftValue;
  final String rightValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$code  •  $time',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _MiniMetric(
                      label: 'বেচা',
                      value: leftValue,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _MiniMetric(
                      label: 'কেনা',
                      value: rightValue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
