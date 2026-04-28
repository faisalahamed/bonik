import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class StockReportPage extends StatelessWidget {
  const StockReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _StockReportTopBar(),
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
                    _StockReportDateCard(),
                    SizedBox(height: AppSpacing.md),
                    _StockReportHeroCard(),
                    SizedBox(height: AppSpacing.md),
                    _StockReportFilters(),
                    SizedBox(height: AppSpacing.md),
                    _StockReportSearchBox(),
                    SizedBox(height: AppSpacing.lg),
                    _StockReportSectionHeader(),
                    SizedBox(height: AppSpacing.md),
                    _StockReportItemCard(
                      indexLabel: '০১',
                      title: 'ম্যাঙ্গোসুম (৫ পিস)',
                      subtitle: 'ক্যাটাগরি: ফলমূল',
                      stockInText: '৫৫০ টি',
                      stockOutText: '১২০ টি',
                      purchaseText: '৳ ৪৪,৯৯৯',
                      salesText: '৳ ৮৮,২৯৯',
                      expanded: true,
                      highlightLeft: true,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _StockReportItemCard(
                      indexLabel: '০২',
                      title: 'টেস্ট প্রজেক্ট ১',
                      subtitle: 'ক্যাটাগরি: সেরামিক',
                      stockInText: '৩০০ টি',
                      stockOutText: '৮৫ টি',
                      purchaseText: '৳ ১০,০০০.০০',
                      salesText: '৳ ২৫,০০০.০০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _StockReportItemCard(
                      indexLabel: '০৩',
                      title: 'প্রিমিয়াম হার্ডওয়্যার',
                      subtitle: 'ক্যাটাগরি: স্যানিটারি',
                      stockInText: '১৫০ টি',
                      stockOutText: '৪৫ টি',
                      purchaseText: '৳ ১৮,৪০০.০০',
                      salesText: '৳ ৩২,৭০০.০০',
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

class _StockReportTopBar extends StatelessWidget {
  const _StockReportTopBar();

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
                    'স্টক রিপোর্ট',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.picture_as_pdf_rounded,
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

class _StockReportDateCard extends StatelessWidget {
  const _StockReportDateCard();

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
          const Icon(Icons.chevron_left_rounded, color: AppColors.primary),
          const Spacer(),
          const Icon(
            Icons.calendar_today_rounded,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '০১ জানুয়ারি, ২০ - ০৫ এপ্রিল, ২৪',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _StockReportHeroCard extends StatelessWidget {
  const _StockReportHeroCard();

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
          Text(
            'স্টক সামারি (মোট কেনা)',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '৳ ১,৪৫,৬১৭.০০',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '২২৪টি পণ্য',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StockReportFilters extends StatelessWidget {
  const _StockReportFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _StockReportChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _StockReportChip(label: 'মাস')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _StockReportChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _StockReportChip(label: 'সব সময়')),
        SizedBox(width: AppSpacing.sm),
        _StockReportFilterAction(),
      ],
    );
  }
}

class _StockReportChip extends StatelessWidget {
  const _StockReportChip({
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

class _StockReportFilterAction extends StatelessWidget {
  const _StockReportFilterAction();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.tune_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 2),
          Text(
            'ক্যা',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _StockReportSearchBox extends StatelessWidget {
  const _StockReportSearchBox();

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
          hintText: 'পণ্য খুঁজুন...',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _StockReportSectionHeader extends StatelessWidget {
  const _StockReportSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            'পণ্যের তালিকা',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}

class _StockReportItemCard extends StatelessWidget {
  const _StockReportItemCard({
    required this.indexLabel,
    required this.title,
    required this.subtitle,
    required this.stockInText,
    required this.stockOutText,
    required this.purchaseText,
    required this.salesText,
    this.expanded = false,
    this.highlightLeft = false,
  });

  final String indexLabel;
  final String title;
  final String subtitle;
  final String stockInText;
  final String stockOutText;
  final String purchaseText;
  final String salesText;
  final bool expanded;
  final bool highlightLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: highlightLeft
                        ? const Color(0xFFE8FFF7)
                        : const Color(0xFFF0F3F2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    indexLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: highlightLeft
                              ? AppColors.primaryContainer
                              : AppColors.textMuted,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          if (expanded)
            Container(
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                0,
                AppSpacing.sm,
                AppSpacing.md,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF343434),
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _StockSummaryCell(
                      label: 'স্টকড',
                      quantity: '৮৫০ টি',
                      value: '৳ ৮৪,২৯৯',
                      valueColor: Colors.white70,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 56,
                    color: Colors.white12,
                  ),
                  Expanded(
                    child: _StockSummaryCell(
                      label: 'বেচাকৃত',
                      quantity: '২০৫ টি',
                      value: '৳ ৩৪,৯১৯',
                      valueColor: Colors.white70,
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _StockMetricText(
                    label: 'স্টক হয়েছে',
                    quantity: stockInText,
                    value: purchaseText,
                    quantityColor: AppColors.primary,
                    valueColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StockMetricText(
                    label: 'স্টক বের হয়েছে',
                    quantity: stockOutText,
                    value: salesText,
                    quantityColor: const Color(0xFFD9534F),
                    valueColor: const Color(0xFFD9534F),
                    alignEnd: true,
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

class _StockMetricText extends StatelessWidget {
  const _StockMetricText({
    required this.label,
    required this.quantity,
    required this.value,
    required this.quantityColor,
    required this.valueColor,
    this.alignEnd = false,
  });

  final String label;
  final String quantity;
  final String value;
  final Color quantityColor;
  final Color valueColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          quantity,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: quantityColor,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _StockSummaryCell extends StatelessWidget {
  const _StockSummaryCell({
    required this.label,
    required this.quantity,
    required this.value,
    required this.valueColor,
    this.alignEnd = false,
  });

  final String label;
  final String quantity;
  final String value;
  final Color valueColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFF7FE4C2),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          quantity,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
