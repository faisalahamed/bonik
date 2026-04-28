import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class PurchaseReportPage extends StatelessWidget {
  const PurchaseReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _PurchaseReportTopBar(),
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
                    _PurchaseReportFilterTabs(),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportDateCard(),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportHeroCard(),
                    SizedBox(height: AppSpacing.lg),
                    _PurchaseReportSectionHeader(),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportEntryCard(
                      code: '#NGTRAB',
                      amount: '৳ ১২,০০০',
                      time: '১০:১০ এএম',
                      statusText: 'বাকি',
                      statusColor: Color(0xFFD9534F),
                      statusBackground: Color(0xFFFFE7E7),
                      accentColor: Color(0xFFF3B3B3),
                      trailingIcon: Icons.shopping_bag_rounded,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportEntryCard(
                      code: '#TRXP92',
                      amount: '৳ ২৫,৮০০',
                      time: '১০:১০ এএম',
                      statusText: 'নগদ টাকা',
                      statusColor: Color(0xFF138E7A),
                      statusBackground: Color(0xFFE4FBF6),
                      accentColor: Color(0xFF9EDFD5),
                      trailingIcon: Icons.payments_rounded,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportEntryCard(
                      code: '#NGTX31',
                      amount: '৳ ৪,৫৬০',
                      time: '০৯:৪০ এএম',
                      statusText: 'নগদ টাকা',
                      statusColor: Color(0xFF138E7A),
                      statusBackground: Color(0xFFE4FBF6),
                      accentColor: Color(0xFFC2E7E1),
                      trailingIcon: Icons.receipt_long_rounded,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _PurchaseReportEntryCard(
                      code: '#NGTX44',
                      amount: '৳ ২৩,০০০',
                      time: '০৩:৪০ এএম',
                      statusText: 'বাকি',
                      statusColor: Color(0xFFD9534F),
                      statusBackground: Color(0xFFFFE7E7),
                      accentColor: Color(0xFFF0C3C3),
                      trailingIcon: Icons.handyman_rounded,
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

class _PurchaseReportTopBar extends StatelessWidget {
  const _PurchaseReportTopBar();

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
                  'ক্রয় প্রতিবেদন',
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
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseReportFilterTabs extends StatelessWidget {
  const _PurchaseReportFilterTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _PurchaseReportChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.xs),
        Expanded(child: _PurchaseReportChip(label: 'মাস')),
        SizedBox(width: AppSpacing.xs),
        Expanded(child: _PurchaseReportChip(label: 'বছর')),
        SizedBox(width: AppSpacing.xs),
        Expanded(child: _PurchaseReportChip(label: 'সব সময়')),
        SizedBox(width: AppSpacing.xs),
        Expanded(child: _PurchaseReportChip(label: 'কাস্টম')),
      ],
    );
  }
}

class _PurchaseReportChip extends StatelessWidget {
  const _PurchaseReportChip({
    required this.label,
    this.active = false,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: active ? AppColors.surfaceContainerLowest : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: active ? AppShadows.soft : null,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
      ),
    );
  }
}

class _PurchaseReportDateCard extends StatelessWidget {
  const _PurchaseReportDateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
          const Spacer(),
          const Icon(
            Icons.calendar_today_rounded,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '০৭ এপ্রিল ২০২৬',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _PurchaseReportHeroCard extends StatelessWidget {
  const _PurchaseReportHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.button,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'মোট কেনা (PURCHASE SUMMARY)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                    children: [
                      const TextSpan(text: '৳ ৬৫,৪৫০'),
                      TextSpan(
                        text: ' / মোট খরচ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white.withOpacity(0.72),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              6,
              (_) => Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseReportSectionHeader extends StatelessWidget {
  const _PurchaseReportSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            'লেনদেনের বিবরণ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
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
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '৪টি রেকর্ড',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class _PurchaseReportEntryCard extends StatelessWidget {
  const _PurchaseReportEntryCard({
    required this.code,
    required this.amount,
    required this.time,
    required this.statusText,
    required this.statusColor,
    required this.statusBackground,
    required this.accentColor,
    required this.trailingIcon,
  });

  final String code;
  final String amount;
  final String time;
  final String statusText;
  final Color statusColor;
  final Color statusBackground;
  final Color accentColor;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 122,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.xl),
                bottomLeft: Radius.circular(AppRadii.xl),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              code,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.textMuted,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusBackground,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                statusText,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          amount,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 15,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.textMuted,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: Icon(
                      trailingIcon,
                      color: AppColors.primary,
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
