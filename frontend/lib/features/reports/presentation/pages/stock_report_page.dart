import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _StockReportPeriod { day, month, year, allTime, custom }

class _StockReportDateRange {
  const _StockReportDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

final _stockReportPeriodProvider = StateProvider<_StockReportPeriod>(
  (ref) => _StockReportPeriod.month,
);

final _stockReportAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _stockReportCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _stockReportSearchProvider = StateProvider<String>((ref) => '');

final _stockReportDateRangeProvider = Provider<_StockReportDateRange?>((ref) {
  final period = ref.watch(_stockReportPeriodProvider);
  final anchor = ref.watch(_stockReportAnchorDateProvider).toLocal();
  final customRange = ref.watch(_stockReportCustomDateRangeProvider);

  switch (period) {
    case _StockReportPeriod.day:
      final start = DateTime(anchor.year, anchor.month, anchor.day);
      return _StockReportDateRange(
        start: start.toUtc(),
        end: start.add(const Duration(days: 1)).toUtc(),
      );
    case _StockReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1);
      return _StockReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _StockReportPeriod.year:
      final start = DateTime(anchor.year);
      final end = DateTime(anchor.year + 1);
      return _StockReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _StockReportPeriod.allTime:
      return null;
    case _StockReportPeriod.custom:
      if (customRange == null) {
        return null;
      }
      final start = DateTime(
        customRange.start.year,
        customRange.start.month,
        customRange.start.day,
      );
      final end = DateTime(
        customRange.end.year,
        customRange.end.month,
        customRange.end.day,
      ).add(const Duration(days: 1));
      return _StockReportDateRange(start: start.toUtc(), end: end.toUtc());
  }
});

final _stockReportProvider = StreamProvider<List<LocalStockReportEntry>>((ref) {
  final range = ref.watch(_stockReportDateRangeProvider);
  return ref
      .watch(appDatabaseProvider)
      .watchStockReportForCurrentShop(start: range?.start, end: range?.end);
});

class StockReportPage extends ConsumerWidget {
  const StockReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(_stockReportProvider).valueOrNull ?? const [];
    final searchText = ref.watch(_stockReportSearchProvider).trim();
    final visibleEntries = _filterEntries(entries, searchText);
    final totalPurchase = entries.fold<double>(
      0,
      (sum, entry) => sum + entry.purchaseTotal,
    );
    final totalStockIn = entries.fold<int>(
      0,
      (sum, entry) => sum + entry.stockInQuantity,
    );

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
                  children: [
                    _StockReportHeroCard(
                      totalPurchase: totalPurchase,
                      totalStockIn: totalStockIn,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _StockReportDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _StockReportFilters(),
                    const SizedBox(height: AppSpacing.md),
                    const _StockReportSearchBox(),
                    const SizedBox(height: AppSpacing.lg),
                    const _StockReportSectionHeader(),
                    const SizedBox(height: AppSpacing.md),
                    if (visibleEntries.isEmpty)
                      const _StockReportEmptyCard()
                    else
                      for (var i = 0; i < visibleEntries.length; i++) ...[
                        _StockReportItemCard(
                          indexLabel: _bnNumber(
                            (i + 1).toString().padLeft(2, '0'),
                          ),
                          entry: visibleEntries[i],
                          expanded: i == 0,
                          highlightLeft: i == 0,
                        ),
                        if (i != visibleEntries.length - 1)
                          const SizedBox(height: AppSpacing.md),
                      ],
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
                    'স্টক রিপোর্ট',
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

class _StockReportDateCard extends ConsumerWidget {
  const _StockReportDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_stockReportPeriodProvider);
    final anchorDate = ref.watch(_stockReportAnchorDateProvider);
    final customRange = ref.watch(_stockReportCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _StockReportPeriod.allTime &&
        period != _StockReportPeriod.custom;

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
            onTap: canNavigate ? () => _moveRange(ref, -1) : null,
            child: SizedBox(
              width: 36,
              height: 48,
              child: Icon(
                Icons.chevron_left_rounded,
                color: canNavigate ? Colors.white : Colors.white38,
              ),
            ),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          GestureDetector(
            onTap: canNavigate ? () => _moveRange(ref, 1) : null,
            child: SizedBox(
              width: 36,
              height: 48,
              child: Icon(
                Icons.chevron_right_rounded,
                color: canNavigate ? Colors.white : Colors.white38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StockReportHeroCard extends StatelessWidget {
  const _StockReportHeroCard({
    required this.totalPurchase,
    required this.totalStockIn,
  });

  final double totalPurchase;
  final int totalStockIn;

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
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _money(totalPurchase),
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
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${_bnNumber(totalStockIn)}টি পণ্য',
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

class _StockReportFilters extends ConsumerWidget {
  const _StockReportFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_stockReportPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _StockReportChip(
            label: 'দিন',
            active: selectedPeriod == _StockReportPeriod.day,
            onTap: () => _selectPeriod(ref, _StockReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StockReportChip(
            label: 'মাস',
            active: selectedPeriod == _StockReportPeriod.month,
            onTap: () => _selectPeriod(ref, _StockReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StockReportChip(
            label: 'বছর',
            active: selectedPeriod == _StockReportPeriod.year,
            onTap: () => _selectPeriod(ref, _StockReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StockReportChip(
            label: 'সব সময়',
            active: selectedPeriod == _StockReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _StockReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _StockReportFilterAction(
          active: selectedPeriod == _StockReportPeriod.custom,
          onTap: () => _pickCustomDateRange(context, ref),
        ),
      ],
    );
  }
}

class _StockReportChip extends StatelessWidget {
  const _StockReportChip({
    required this.label,
    this.active = false,
    this.onTap,
  });

  final String label;
  final bool active;
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
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: active ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _StockReportFilterAction extends StatelessWidget {
  const _StockReportFilterAction({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        height: 42,
        decoration: BoxDecoration(
          gradient: active ? AppGradients.primaryButton : null,
          color: active ? null : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 18,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 2),
            Text(
              'কাস্টম',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: active ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockReportSearchBox extends ConsumerWidget {
  const _StockReportSearchBox();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: TextField(
        onChanged: (value) =>
            ref.read(_stockReportSearchProvider.notifier).state = value,
        decoration: const InputDecoration(
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
    required this.entry,
    this.expanded = false,
    this.highlightLeft = false,
  });

  final String indexLabel;
  final LocalStockReportEntry entry;
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
                        entry.productName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ক্যাটাগরি: ${entry.categoryName}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
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
                      quantity: '${_bnNumber(entry.stockInQuantity)} টি',
                      value: _money(entry.purchaseTotal),
                      valueColor: Colors.white70,
                    ),
                  ),
                  Container(width: 1, height: 56, color: Colors.white12),
                  Expanded(
                    child: _StockSummaryCell(
                      label: 'বেচাকৃত',
                      quantity: '${_bnNumber(entry.stockOutQuantity)} টি',
                      value: _money(entry.salesTotal),
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
                    quantity: '${_bnNumber(entry.stockInQuantity)} টি',
                    value: _money(entry.purchaseTotal),
                    quantityColor: AppColors.primary,
                    valueColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StockMetricText(
                    label: 'স্টক বের হয়েছে',
                    quantity: '${_bnNumber(entry.stockOutQuantity)} টি',
                    value: _money(entry.salesTotal),
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
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
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
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
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

class _StockReportEmptyCard extends StatelessWidget {
  const _StockReportEmptyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Text(
        'এই সময়সীমায় কোনো স্টক তথ্য নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<LocalStockReportEntry> _filterEntries(
  List<LocalStockReportEntry> entries,
  String searchText,
) {
  final query = searchText.toLowerCase();
  final filtered = query.isEmpty
      ? [...entries]
      : entries
            .where(
              (entry) =>
                  entry.productName.toLowerCase().contains(query) ||
                  entry.categoryName.toLowerCase().contains(query),
            )
            .toList();
  filtered.sort((a, b) {
    final purchaseCompare = b.purchaseTotal.compareTo(a.purchaseTotal);
    if (purchaseCompare != 0) {
      return purchaseCompare;
    }
    return b.salesTotal.compareTo(a.salesTotal);
  });
  return filtered;
}

void _selectPeriod(WidgetRef ref, _StockReportPeriod period) {
  ref.read(_stockReportPeriodProvider.notifier).state = period;
  if (period != _StockReportPeriod.custom) {
    ref.read(_stockReportCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_stockReportPeriodProvider);
  final anchor = ref.read(_stockReportAnchorDateProvider).toLocal();

  final next = switch (period) {
    _StockReportPeriod.day => anchor.add(Duration(days: direction)),
    _StockReportPeriod.month => DateTime(anchor.year, anchor.month + direction),
    _StockReportPeriod.year => DateTime(anchor.year + direction, anchor.month),
    _StockReportPeriod.allTime => anchor,
    _StockReportPeriod.custom => anchor,
  };

  ref.read(_stockReportAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_stockReportCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(ref.read(_stockReportAnchorDateProvider));
  final initialRange =
      currentRange ?? DateTimeRange(start: anchorDate, end: anchorDate);
  final pickedRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(now.year + 10, 12, 31),
    initialDateRange: initialRange,
  );

  if (pickedRange == null) {
    return;
  }

  ref.read(_stockReportAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_stockReportCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_stockReportPeriodProvider.notifier).state =
      _StockReportPeriod.custom;
}

String _rangeLabel(
  _StockReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _StockReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _StockReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _StockReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _StockReportPeriod.allTime:
      return 'সব সময়';
    case _StockReportPeriod.custom:
      if (customRange == null) {
        return 'কাস্টম রেঞ্জ';
      }
      return '${_formatBanglaDate(customRange.start)} - '
          '${_formatBanglaDate(customRange.end)}';
  }
}

String _formatBanglaDate(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_banglaMonths[date.month - 1]}, ${_bnNumber(date.year)}';
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
