import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class DuesLedgerPage extends StatelessWidget {
  const DuesLedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _DuesTopBar(),
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
                    AppSpacing.lg,
                  ),
                  children: const [
                    _ReceivablePayableRow(),
                    SizedBox(height: AppSpacing.lg),
                    _DuesSearchBox(),
                    SizedBox(height: AppSpacing.md),
                    _DuesFilterRow(),
                    SizedBox(height: AppSpacing.lg),
                    _DuesSectionTitle(title: 'সাম্প্রতিক লেনদেন'),
                    SizedBox(height: AppSpacing.md),
                    _DuesPersonCard(
                      initials: 'আ',
                      name: 'আবুুর রহমান',
                      phone: '০১৭০০-০০০০০০',
                      timeText: '২ ঘন্টা',
                      dateText: 'আজ',
                      amountLabel: 'পাবে',
                      amount: '৳ ১২,৫০০',
                      amountBackground: Color(0xFFD8F8E8),
                      amountColor: AppColors.primary,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _DuesPersonCard(
                      initials: 'ম',
                      name: 'স্যানিটারি সিস্টেমস',
                      phone: '০১৮০০-১১১২২২',
                      timeText: '৩ ঘন্টা',
                      dateText: 'গতকাল',
                      amountLabel: 'দিবে',
                      amount: '৳ ৪৫,০০০',
                      amountBackground: Color(0xFFFFE3E3),
                      amountColor: Color(0xFFD9534F),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _DuesPersonCard(
                      initials: 'ক',
                      name: 'কামরুল ইসলাম',
                      phone: '০১৯০০-৩৩৬৮৮৮',
                      timeText: '১৫ মে, ২০২৪',
                      dateText: '',
                      amountLabel: 'পাবে',
                      amount: '৳ ২,২০০',
                      amountBackground: Color(0xFFD8F8E8),
                      amountColor: AppColors.primary,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _DuesPersonCard(
                      initials: 'জ',
                      name: 'জাকির হক',
                      phone: '০১৬০০-৫৫৫৬৬৬',
                      timeText: '১০ মে, ২০২৪',
                      dateText: '',
                      amountLabel: 'পাবে',
                      amount: '৳ ৮৫০',
                      amountBackground: Color(0xFFD8F8E8),
                      amountColor: AppColors.primary,
                      mutedAvatar: true,
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

class _DuesTopBar extends StatelessWidget {
  const _DuesTopBar();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
        boxShadow: AppShadows.soft,
      ),
      child: SafeArea(
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
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    'বাকির খাতা',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReceivablePayableRow extends StatelessWidget {
  const _ReceivablePayableRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _AmountSummaryCard(
            title: 'পাবে (RECEIVABLE)',
            amount: '৳ ৪,৫০,০০০',
            accentColor: AppColors.secondary,
            amountColor: AppColors.primary,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _AmountSummaryCard(
            title: 'দিবে (PAYABLE)',
            amount: '৳ ১,২০,০০০',
            accentColor: Color(0xFFD9534F),
            amountColor: Color(0xFFD9534F),
          ),
        ),
      ],
    );
  }
}

class _AmountSummaryCard extends StatelessWidget {
  const _AmountSummaryCard({
    required this.title,
    required this.amount,
    required this.accentColor,
    required this.amountColor,
  });

  final String title;
  final String amount;
  final Color accentColor;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: amountColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DuesSearchBox extends StatelessWidget {
  const _DuesSearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'কাস্টমারের নাম বা মোবাইল নম্বর দিয়ে খুঁজুন',
          prefixIcon: Icon(Icons.group_add_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _DuesFilterRow extends StatelessWidget {
  const _DuesFilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _DuesFilterChip(label: '∞ সব', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _DuesFilterChip(label: '↙ পাবে')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _DuesFilterChip(label: '↗ দিবে')),
        SizedBox(width: AppSpacing.sm),
        _DuesSortChip(),
      ],
    );
  }
}

class _DuesFilterChip extends StatelessWidget {
  const _DuesFilterChip({
    required this.label,
    this.active = false,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        gradient: active ? AppGradients.primaryButton : null,
        color: active ? null : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg),
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

class _DuesSortChip extends StatelessWidget {
  const _DuesSortChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: const Icon(
        Icons.tune_rounded,
        color: AppColors.primary,
      ),
    );
  }
}

class _DuesSectionTitle extends StatelessWidget {
  const _DuesSectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _DuesPersonCard extends StatelessWidget {
  const _DuesPersonCard({
    required this.initials,
    required this.name,
    required this.phone,
    required this.timeText,
    required this.dateText,
    required this.amountLabel,
    required this.amount,
    required this.amountBackground,
    required this.amountColor,
    this.mutedAvatar = false,
  });

  final String initials;
  final String name;
  final String phone;
  final String timeText;
  final String dateText;
  final String amountLabel;
  final String amount;
  final Color amountBackground;
  final Color amountColor;
  final bool mutedAvatar;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(AppRoutes.duesLedgerDetails),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            children: [
              Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: mutedAvatar
                  ? const Color(0xFFEAEAE8)
                  : const Color(0xFFB9F3E7),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$phone ${dateText.isNotEmpty ? '•' : ''} $timeText'.trim(),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (dateText.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    dateText,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
              const SizedBox(width: AppSpacing.sm),
              Container(
            width: 98,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: amountBackground,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amountLabel,
                  style: textTheme.labelSmall?.copyWith(
                    color: amountColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  textAlign: TextAlign.right,
                  style: textTheme.titleLarge?.copyWith(
                    color: amountColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
