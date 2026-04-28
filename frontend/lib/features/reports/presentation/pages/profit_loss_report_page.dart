import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class ProfitLossReportPage extends StatelessWidget {
  const ProfitLossReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SummaryTopBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: const [
                _RangeCard(),
                SizedBox(height: AppSpacing.md),
                _FilterRow(),
                SizedBox(height: AppSpacing.xl),
                _SectionTitleRow(
                  leftTitle: 'লাভ সম্পর্কে বিস্তারিত',
                  rightTitle: 'মোট',
                ),
                SizedBox(height: AppSpacing.md),
                _ProfitSectionCard(),
                SizedBox(height: AppSpacing.xl),
                _StandaloneTitle(title: 'অন্যান্য আয়'),
                SizedBox(height: AppSpacing.md),
                _IncomeSectionCard(),
                SizedBox(height: AppSpacing.xl),
                _StandaloneTitle(title: 'অন্যান্য খরচ'),
                SizedBox(height: AppSpacing.md),
                _ExpenseSectionCard(),
                SizedBox(height: AppSpacing.xxl),
                _NetProfitCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryTopBar extends StatelessWidget {
  const _SummaryTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 76,
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
                    'লাভ ক্ষতি রিপোর্ট',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

class _RangeCard extends StatelessWidget {
  const _RangeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Row(
        children: [
          const Icon(Icons.chevron_left_rounded, color: Colors.white),
          const Spacer(),
          Text(
            '০১ এপ্রিল, ২০২৪ - ৩০ এপ্রিল, ২০২৪',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _FilterChip(label: 'দিন'),
          SizedBox(width: AppSpacing.sm),
          _FilterChip(label: 'মাস', active: true),
          SizedBox(width: AppSpacing.sm),
          _FilterChip(label: 'বছর'),
          SizedBox(width: AppSpacing.sm),
          _FilterChip(label: 'সব সময়'),
          SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'ক্যালেন্ডার',
            icon: Icons.calendar_month_rounded,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.active = false,
    this.icon,
  });

  final String label;
  final bool active;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: active ? AppColors.primary : const Color(0xFFD9E3DE),
        ),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: active ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitleRow extends StatelessWidget {
  const _SectionTitleRow({
    required this.leftTitle,
    required this.rightTitle,
  });

  final String leftTitle;
  final String rightTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            leftTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Text(
          rightTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _StandaloneTitle extends StatelessWidget {
  const _StandaloneTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _ProfitSectionCard extends StatelessWidget {
  const _ProfitSectionCard();

  @override
  Widget build(BuildContext context) {
    return const _SummarySectionCard(
      heading: 'বেচা-বিক্রির লাভ',
      rows: [
        _AmountRow(label: 'বেচা-বিক্রি', value: '২৮,০৫০.৪ ৳'),
        _AmountRow(
          label: 'পণ্যের ক্রয়মূল্য',
          value: '(-) ১৯,৩৬৫.৯ ৳',
          negative: true,
        ),
        _AmountRow(
          label: 'ডেলিভারি চার্জ',
          value: '(-) ০ ৳',
          negative: true,
        ),
      ],
      totalLabel: 'বেচা-বিক্রির লাভ',
      totalValue: '(+) ৮,৬৮৪.৮ ৳',
      trailingHint: '(বাকি) ৭,৫৮৮.৫ ৳',
    );
  }
}

class _IncomeSectionCard extends StatelessWidget {
  const _IncomeSectionCard();

  @override
  Widget build(BuildContext context) {
    return const _SummarySectionCard(
      rows: [
        _AmountRow(label: 'INCOME', value: '(+) ২৩,৫৪৫.৮ ৳'),
        _AmountRow(label: 'COMMISSION', value: '(+) ৫০০ ৳'),
      ],
      totalLabel: 'মোট আয় (অন্যান্য)',
      totalValue: '(+) ২৪,০৪৫.৮ ৳',
    );
  }
}

class _ExpenseSectionCard extends StatelessWidget {
  const _ExpenseSectionCard();

  @override
  Widget build(BuildContext context) {
    return const _SummarySectionCard(
      rows: [
        _AmountRow(
          label: 'EXPENSE',
          value: '(-) ৫,৩৬৬.৮ ৳',
          negative: true,
        ),
      ],
      totalLabel: 'মোট খরচ',
      totalValue: '(-) ৫,৩৬৬.৮ ৳',
      totalNegative: true,
    );
  }
}

class _SummarySectionCard extends StatelessWidget {
  const _SummarySectionCard({
    this.heading,
    required this.rows,
    required this.totalLabel,
    required this.totalValue,
    this.trailingHint,
    this.totalNegative = false,
  });

  final String? heading;
  final List<_AmountRow> rows;
  final String totalLabel;
  final String totalValue;
  final String? trailingHint;
  final bool totalNegative;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null) ...[
            Text(
              heading!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          for (var i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i != rows.length - 1)
              const Divider(height: AppSpacing.xl, color: Color(0xFFE5ECE8)),
          ],
          const Divider(height: AppSpacing.xl, color: Color(0xFFE5ECE8)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  totalLabel,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalValue,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: totalNegative
                              ? const Color(0xFFE53935)
                              : AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  if (trailingHint != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      trailingHint!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _DetailsButton(
            onTap: () => context.push(AppRoutes.reportProfitLossDetails),
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.value,
    this.negative = false,
  });

  final String label;
  final String value;
  final bool negative;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: negative
                      ? const Color(0xFFE53935)
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class _DetailsButton extends StatelessWidget {
  const _DetailsButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.xl),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          'বিস্তারিত দেখুন  →',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _NetProfitCard extends StatelessWidget {
  const _NetProfitCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FBF1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFB9EACD)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'সর্বমোট লাভ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '(বেচা বিক্রির লাভ + অন্যান্য আয়) - মোট খরচ',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            '২৭,৩৬৩.৭ ৳',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}
