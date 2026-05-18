import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _ProfitLossPeriod { day, month, year, allTime }

class _ProfitLossDateRange {
  const _ProfitLossDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

final _profitLossPeriodProvider = StateProvider<_ProfitLossPeriod>(
  (ref) => _ProfitLossPeriod.month,
);

final _profitLossAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _profitLossDateRangeProvider = Provider<_ProfitLossDateRange?>((ref) {
  final period = ref.watch(_profitLossPeriodProvider);
  final anchor = ref.watch(_profitLossAnchorDateProvider).toLocal();

  switch (period) {
    case _ProfitLossPeriod.day:
      final start = DateTime(anchor.year, anchor.month, anchor.day);
      return _ProfitLossDateRange(
        start: start.toUtc(),
        end: start.add(const Duration(days: 1)).toUtc(),
      );
    case _ProfitLossPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1);
      return _ProfitLossDateRange(start: start.toUtc(), end: end.toUtc());
    case _ProfitLossPeriod.year:
      final start = DateTime(anchor.year);
      final end = DateTime(anchor.year + 1);
      return _ProfitLossDateRange(start: start.toUtc(), end: end.toUtc());
    case _ProfitLossPeriod.allTime:
      return null;
  }
});

final _profitLossSummaryProvider = StreamProvider<LocalProfitLossSummary>((
  ref,
) {
  final range = ref.watch(_profitLossDateRangeProvider);
  return ref
      .watch(appDatabaseProvider)
      .watchProfitLossSummaryForCurrentShop(
        start: range?.start,
        end: range?.end,
      );
});

class ProfitLossReportPage extends ConsumerWidget {
  const ProfitLossReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(_profitLossSummaryProvider).valueOrNull;

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
              children: [
                _SuppliersHeroCard(summary: summary),
                const SizedBox(height: AppSpacing.lg),
                const _RangeCard(),
                const SizedBox(height: AppSpacing.md),
                const _FilterRow(),
                const SizedBox(height: AppSpacing.xl),
                const _SectionTitleRow(
                  leftTitle: 'লাভ সম্পর্কে বিস্তারিত',
                  rightTitle: 'মোট',
                ),
                const SizedBox(height: AppSpacing.md),
                _ProfitSectionCard(summary: summary),
                const SizedBox(height: AppSpacing.xl),
                _StandaloneTitle(title: 'অন্যান্য আয়'),
                SizedBox(height: AppSpacing.md),
                _IncomeSectionCard(summary: summary),
                SizedBox(height: AppSpacing.xl),
                _StandaloneTitle(title: 'অন্যান্য খরচ'),
                SizedBox(height: AppSpacing.md),
                _ExpenseSectionCard(summary: summary),
                SizedBox(height: AppSpacing.xxl),
                _NetProfitCard(summary: summary),
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
      decoration: const BoxDecoration(gradient: AppGradients.primaryButton),
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

class _RangeCard extends ConsumerWidget {
  const _RangeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_profitLossPeriodProvider);
    final anchorDate = ref.watch(_profitLossAnchorDateProvider);
    final label = _rangeLabel(period, anchorDate);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: period == _ProfitLossPeriod.allTime
                ? null
                : () => _moveRange(ref, -1),
            child: Icon(
              Icons.chevron_left_rounded,
              color: period == _ProfitLossPeriod.allTime
                  ? Colors.white38
                  : Colors.white,
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 6,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: period == _ProfitLossPeriod.allTime
                ? null
                : () => _moveRange(ref, 1),
            child: Icon(
              Icons.chevron_right_rounded,
              color: period == _ProfitLossPeriod.allTime
                  ? Colors.white38
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends ConsumerWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_profitLossPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _FilterChip(
            label: 'দিন',
            active: selectedPeriod == _ProfitLossPeriod.day,
            onTap: () => _selectPeriod(ref, _ProfitLossPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'মাস',
            active: selectedPeriod == _ProfitLossPeriod.month,
            onTap: () => _selectPeriod(ref, _ProfitLossPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'বছর',
            active: selectedPeriod == _ProfitLossPeriod.year,
            onTap: () => _selectPeriod(ref, _ProfitLossPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'সব সময়',
            active: selectedPeriod == _ProfitLossPeriod.allTime,
            onTap: () => _selectPeriod(ref, _ProfitLossPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'ক্যালেন্ডার',
            icon: Icons.calendar_month_rounded,
            onTap: () => _pickAnchorDate(context, ref),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.active = false,
    this.icon,
    this.onTap,
  });

  final String label;
  final bool active;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          gradient: active ? AppGradients.primaryButton : null,
          color: active ? null : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: active ? Colors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: active ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitleRow extends StatelessWidget {
  const _SectionTitleRow({required this.leftTitle, required this.rightTitle});

  final String leftTitle;
  final String rightTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
        const SizedBox(width: AppSpacing.md),
        Text(
          rightTitle,
          textAlign: TextAlign.end,
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
  const _ProfitSectionCard({required this.summary});

  final LocalProfitLossSummary? summary;

  @override
  Widget build(BuildContext context) {
    final data = summary ?? _emptyProfitLossSummary;

    return _SummarySectionCard(
      heading: 'বেচা-বিক্রির লাভ',
      rows: [
        _AmountRow(label: 'বেচা-বিক্রি', value: _money(data.salesTotal)),
        _AmountRow(
          label: 'পণ্যের ক্রয়মূল্য',
          value: '(-) ${_money(data.productCost)}',
          negative: true,
        ),
        _AmountRow(
          label: 'ডেলিভারি চার্জ',
          value: '(-) ${_money(data.deliveryCharge)}',
          negative: true,
        ),
      ],
      totalLabel: 'বেচা-বিক্রির লাভ',
      totalValue: _signedMoney(data.salesProfit),
      trailingHint: '(বাকি) ${_money(data.dueAmount)}',
      totalNegative: data.salesProfit < 0,
    );
  }
}

class _IncomeSectionCard extends StatelessWidget {
  const _IncomeSectionCard({required this.summary});

  final LocalProfitLossSummary? summary;

  @override
  Widget build(BuildContext context) {
    final data = summary ?? _emptyProfitLossSummary;

    return _SummarySectionCard(
      rows: [
        _AmountRow(label: 'INCOME', value: _signedMoney(data.otherIncome)),
      ],
      totalLabel: 'মোট আয় (অন্যান্য)',
      totalValue: _signedMoney(data.otherIncome),
      totalNegative: data.otherIncome < 0,
    );
  }
}

class _ExpenseSectionCard extends StatelessWidget {
  const _ExpenseSectionCard({required this.summary});

  final LocalProfitLossSummary? summary;

  @override
  Widget build(BuildContext context) {
    final data = summary ?? _emptyProfitLossSummary;

    return _SummarySectionCard(
      rows: [
        _AmountRow(
          label: 'EXPENSE',
          value: '(-) ${_money(data.expenseTotal)}',
          negative: true,
        ),
      ],
      totalLabel: 'মোট খরচ',
      totalValue: '(-) ${_money(data.expenseTotal)}',
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
          LayoutBuilder(
            builder: (context, constraints) {
              final valueColumn = Column(
                crossAxisAlignment: constraints.maxWidth < 340
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    totalValue,
                    textAlign: constraints.maxWidth < 340
                        ? TextAlign.start
                        : TextAlign.end,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                      textAlign: constraints.maxWidth < 340
                          ? TextAlign.start
                          : TextAlign.end,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              );

              if (constraints.maxWidth < 340) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalLabel,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    valueColumn,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      totalLabel,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 116),
                    child: valueColumn,
                  ),
                ],
              );
            },
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final labelStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        );
        final valueStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: negative ? const Color(0xFFE53935) : AppColors.textPrimary,
          fontWeight: FontWeight.w800,
        );

        if (constraints.maxWidth < 320) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: labelStyle),
              const SizedBox(height: 4),
              Text(value, style: valueStyle),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: Text(label, style: labelStyle)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 4,
              child: Text(value, textAlign: TextAlign.end, style: valueStyle),
            ),
          ],
        );
      },
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
  const _NetProfitCard({required this.summary});

  final LocalProfitLossSummary? summary;

  @override
  Widget build(BuildContext context) {
    final data = summary ?? _emptyProfitLossSummary;
    final netProfit = data.netProfit;
    final isLoss = netProfit < 0;
    final titleColor = isLoss ? const Color(0xFFD9534F) : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isLoss ? const Color(0xFFFFEFEF) : const Color(0xFFE9FBF1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isLoss ? const Color(0xFFD9534F) : const Color(0xFFB9EACD),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoss ? 'সর্বমোট ক্ষতি' : 'সর্বমোট লাভ',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: titleColor,
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
          );
          final amount = Text(
            _money(netProfit.abs()),
            textAlign: constraints.maxWidth < 360
                ? TextAlign.start
                : TextAlign.end,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.w900,
            ),
          );

          if (constraints.maxWidth < 360) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                copy,
                const SizedBox(height: AppSpacing.md),
                amount,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: copy),
              const SizedBox(width: AppSpacing.md),
              Flexible(child: amount),
            ],
          );
        },
      ),
    );
  }
}

class _SuppliersHeroCard extends StatelessWidget {
  const _SuppliersHeroCard({required this.summary});

  final LocalProfitLossSummary? summary;

  @override
  Widget build(BuildContext context) {
    final data = summary ?? _emptyProfitLossSummary;
    final totalProfit =
        data.salesProfit -
        data.dueAmount +
        data.otherIncome -
        data.expenseTotal;

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
            'মোট লাভ হয়েছে',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            _money(totalProfit),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${_bnNumber(data.itemCount)} টি পণ্য',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
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

void _selectPeriod(WidgetRef ref, _ProfitLossPeriod period) {
  ref.read(_profitLossPeriodProvider.notifier).state = period;
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_profitLossPeriodProvider);
  final anchor = ref.read(_profitLossAnchorDateProvider).toLocal();

  final next = switch (period) {
    _ProfitLossPeriod.day => anchor.add(Duration(days: direction)),
    _ProfitLossPeriod.month => DateTime(anchor.year, anchor.month + direction),
    _ProfitLossPeriod.year => DateTime(anchor.year + direction, anchor.month),
    _ProfitLossPeriod.allTime => anchor,
  };

  ref.read(_profitLossAnchorDateProvider.notifier).state = next;
}

Future<void> _pickAnchorDate(BuildContext context, WidgetRef ref) async {
  final initialDate = AppTime.toLocal(ref.read(_profitLossAnchorDateProvider));
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) {
    return;
  }

  ref.read(_profitLossAnchorDateProvider.notifier).state = pickedDate;
  if (ref.read(_profitLossPeriodProvider) == _ProfitLossPeriod.allTime) {
    ref.read(_profitLossPeriodProvider.notifier).state = _ProfitLossPeriod.day;
  }
}

String _rangeLabel(_ProfitLossPeriod period, DateTime anchorDate) {
  final anchor = anchorDate.toLocal();

  switch (period) {
    case _ProfitLossPeriod.day:
      return _formatBanglaDate(anchor);
    case _ProfitLossPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _ProfitLossPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _ProfitLossPeriod.allTime:
      return 'সব সময়';
  }
}

String _formatBanglaDate(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_banglaMonths[date.month - 1]}, ${_bnNumber(date.year)}';
}

const _banglaMonths = [
  'জানুয়ারি',
  'ফেব্রুয়ারি',
  'মার্চ',
  'এপ্রিল',
  'মে',
  'জুন',
  'জুলাই',
  'আগস্ট',
  'সেপ্টেম্বর',
  'অক্টোবর',
  'নভেম্বর',
  'ডিসেম্বর',
];

const _emptyProfitLossSummary = LocalProfitLossSummary(
  salesTotal: 0,
  productCost: 0,
  deliveryCharge: 0,
  itemCount: 0,
  dueAmount: 0,
  otherIncome: 0,
  expenseTotal: 0,
);

String _signedMoney(double value) {
  final sign = value < 0 ? '(-)' : '(+)';
  return '$sign ${_money(value.abs())}';
}

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
