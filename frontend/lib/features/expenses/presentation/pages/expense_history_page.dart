import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class ExpenseHistoryPage extends StatelessWidget {
  const ExpenseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ExpenseHistoryTopBar(),
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
                    _ExpenseHeroCard(),
                    SizedBox(height: AppSpacing.md),
                    _ExpenseFilterTabs(),
                    SizedBox(height: AppSpacing.lg),
                    _RecentExpenseHeader(),
                    SizedBox(height: AppSpacing.md),
                    _ExpenseHistoryItemCard(
                      icon: Icons.water_drop_rounded,
                      iconBackground: Color(0xFFE8F6EF),
                      iconColor: AppColors.primary,
                      category: 'কারণ: পানি',
                      subtitle: 'Monthly পানি expense',
                      dateTime: '27 January 2026 | 12:00',
                      amount: '২,৬২৯.৭ ৳',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ExpenseHistoryItemCard(
                      icon: Icons.bolt_rounded,
                      iconBackground: Color(0xFFEAF1FF),
                      iconColor: Color(0xFF2C66BE),
                      category: 'কারণ: বিদ্যুৎ বিল',
                      subtitle: 'দোকানের মাসিক বিদ্যুৎ বিল',
                      dateTime: '26 January 2026 | 15:30',
                      amount: '৪,৫২০.০ ৳',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ExpenseHistoryItemCard(
                      icon: Icons.storefront_rounded,
                      iconBackground: Color(0xFFEAF7F2),
                      iconColor: AppColors.primaryContainer,
                      category: 'কারণ: শপিং কর্ন',
                      subtitle: 'নতুন স্যানিটারি মাল কেনা',
                      dateTime: '25 January 2026 | 10:15',
                      amount: '২৫,০০০.০ ৳',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ExpenseHistoryItemCard(
                      icon: Icons.fastfood_rounded,
                      iconBackground: Color(0xFFFFF0E6),
                      iconColor: Color(0xFFCE6D1D),
                      category: 'কারণ: পরোটা',
                      subtitle: 'কর্মচারীদের বিকালের নাস্তা',
                      dateTime: '24 January 2026 | 17:45',
                      amount: '৭৭১.৯ ৳',
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

class _ExpenseHistoryTopBar extends StatelessWidget {
  const _ExpenseHistoryTopBar();

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
                    'ব্যয় বিবরণী',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
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

class _ExpenseHeroCard extends StatelessWidget {
  const _ExpenseHeroCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        children: [
          Text(
            'মোট খরচ',
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.82),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 30,
              ),
              Expanded(
                child: Text(
                  '৩৬,১৯২.৬ ৳',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'জানুয়ারি ২০২৬',
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.white.withOpacity(0.92),
                    fontWeight: FontWeight.w700,
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

class _ExpenseFilterTabs extends StatelessWidget {
  const _ExpenseFilterTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _ExpenseFilterChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ExpenseFilterChip(label: 'মাস')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ExpenseFilterChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _ExpenseFilterChip(label: 'কাস্টম রেঞ্জ')),
      ],
    );
  }
}

class _ExpenseFilterChip extends StatelessWidget {
  const _ExpenseFilterChip({
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
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: active ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _RecentExpenseHeader extends StatelessWidget {
  const _RecentExpenseHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'সাম্প্রতিক ব্যয়',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const Icon(
          Icons.filter_alt_outlined,
          color: AppColors.primary,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          'ফিল্টার করুন',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _ExpenseHistoryItemCard extends StatelessWidget {
  const _ExpenseHistoryItemCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.category,
    required this.subtitle,
    required this.dateTime,
    required this.amount,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String category;
  final String subtitle;
  final String dateTime;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: 'EXPENSE • ',
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: category),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateTime,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            children: [
              Text(
                amount,
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
