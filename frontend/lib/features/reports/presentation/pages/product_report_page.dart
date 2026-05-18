import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _ProductReportPeriod { day, month, year, allTime, custom }

class _ProductReportDateRange {
  const _ProductReportDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

final _productReportPeriodProvider = StateProvider<_ProductReportPeriod>(
  (ref) => _ProductReportPeriod.month,
);

final _productReportAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _productReportCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _productReportSearchProvider = StateProvider<String>((ref) => '');

final _productReportDateRangeProvider = Provider<_ProductReportDateRange?>((
  ref,
) {
  final period = ref.watch(_productReportPeriodProvider);
  final anchor = ref.watch(_productReportAnchorDateProvider).toLocal();
  final customRange = ref.watch(_productReportCustomDateRangeProvider);

  switch (period) {
    case _ProductReportPeriod.day:
      final start = DateTime(anchor.year, anchor.month, anchor.day);
      return _ProductReportDateRange(
        start: start.toUtc(),
        end: start.add(const Duration(days: 1)).toUtc(),
      );
    case _ProductReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1);
      return _ProductReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _ProductReportPeriod.year:
      final start = DateTime(anchor.year);
      final end = DateTime(anchor.year + 1);
      return _ProductReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _ProductReportPeriod.allTime:
      return null;
    case _ProductReportPeriod.custom:
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
      return _ProductReportDateRange(start: start.toUtc(), end: end.toUtc());
  }
});

final _productReportProvider = StreamProvider<List<LocalProductReportEntry>>((
  ref,
) {
  final range = ref.watch(_productReportDateRangeProvider);
  return ref
      .watch(appDatabaseProvider)
      .watchProductReportForCurrentShop(start: range?.start, end: range?.end);
});

class ProductReportPage extends ConsumerWidget {
  const ProductReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(_productReportProvider).valueOrNull ?? const [];
    final searchText = ref.watch(_productReportSearchProvider).trim();
    final visibleEntries = _filterEntries(entries, searchText);
    final totalProfit = entries.fold<double>(0, (sum, e) => sum + e.profit);
    final totalQuantity = entries.fold<int>(
      0,
      (sum, e) => sum + e.soldQuantity,
    );
    final focusEntry = entries.isEmpty ? null : entries.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ProductReportTopBar(),
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
                    _ProductHeroCard(
                      totalProfit: totalProfit,
                      totalQuantity: totalQuantity,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _ProductDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _ProductReportFilters(),
                    const SizedBox(height: AppSpacing.md),
                    const _ProductSearchBox(),
                    const SizedBox(height: AppSpacing.lg),
                    _ProductReportTable(entries: visibleEntries),
                    const SizedBox(height: AppSpacing.xl),
                    _ProductFocusCard(entry: focusEntry),
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

class _ProductReportTopBar extends StatelessWidget {
  const _ProductReportTopBar();

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
                    'পণ্য প্রতিবেদন',
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

class _ProductHeroCard extends StatelessWidget {
  const _ProductHeroCard({
    required this.totalProfit,
    required this.totalQuantity,
  });

  final double totalProfit;
  final int totalQuantity;

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
            'মোট লাভ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  _money(totalProfit),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
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
                  'মোট ${_bnNumber(totalQuantity)} টি পণ্য',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductDateCard extends ConsumerWidget {
  const _ProductDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_productReportPeriodProvider);
    final anchorDate = ref.watch(_productReportAnchorDateProvider);
    final customRange = ref.watch(_productReportCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _ProductReportPeriod.allTime &&
        period != _ProductReportPeriod.custom;

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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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

class _ProductReportFilters extends ConsumerWidget {
  const _ProductReportFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_productReportPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _ProductFilterChip(
            label: 'দিন',
            active: selectedPeriod == _ProductReportPeriod.day,
            onTap: () => _selectPeriod(ref, _ProductReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ProductFilterChip(
            label: 'মাস',
            active: selectedPeriod == _ProductReportPeriod.month,
            onTap: () => _selectPeriod(ref, _ProductReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ProductFilterChip(
            label: 'বছর',
            active: selectedPeriod == _ProductReportPeriod.year,
            onTap: () => _selectPeriod(ref, _ProductReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ProductFilterChip(
            label: 'সব সময়',
            active: selectedPeriod == _ProductReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _ProductReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _ProductFilterAction(
          active: selectedPeriod == _ProductReportPeriod.custom,
          onTap: () => _pickCustomDateRange(context, ref),
        ),
      ],
    );
  }
}

class _ProductFilterChip extends StatelessWidget {
  const _ProductFilterChip({
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

class _ProductFilterAction extends StatelessWidget {
  const _ProductFilterAction({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 42,
        decoration: BoxDecoration(
          gradient: active ? AppGradients.primaryButton : null,
          color: active ? null : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.calendar_month_rounded,
          color: active ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _ProductSearchBox extends ConsumerWidget {
  const _ProductSearchBox();

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
            ref.read(_productReportSearchProvider.notifier).state = value,
        decoration: const InputDecoration(
          hintText: 'পণ্য খুঁজ করুন',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _ProductReportTable extends StatelessWidget {
  const _ProductReportTable({required this.entries});

  final List<LocalProductReportEntry> entries;

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
          const _ProductTableHeader(),
          if (entries.isEmpty)
            const _ProductEmptyRow()
          else
            for (var i = 0; i < entries.length; i++)
              _ProductTableRow(
                entry: entries[i],
                isLast: i == entries.length - 1,
              ),
        ],
      ),
    );
  }
}

class _ProductTableHeader extends StatelessWidget {
  const _ProductTableHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'পণ্যের নাম',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'বিক্রির\nপরিমাণ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'লাভ',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTableRow extends StatelessWidget {
  const _ProductTableRow({required this.entry, this.isLast = false});

  final LocalProductReportEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: Color(0xFFE7ECE9)),
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(color: Color(0xFFE7ECE9)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 34,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    entry.productName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _bnNumber(entry.soldQuantity),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              _money(entry.profit),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductEmptyRow extends StatelessWidget {
  const _ProductEmptyRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE7ECE9))),
      ),
      child: Text(
        'এই সময়সীমায় কোনো পণ্য বিক্রি নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProductFocusCard extends StatelessWidget {
  const _ProductFocusCard({required this.entry});

  final LocalProductReportEntry? entry;

  @override
  Widget build(BuildContext context) {
    final data = entry;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'সেরা পণ্য',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            data?.productName ?? 'কোনো পণ্য নেই',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  'বিক্রি হয়েছে',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_bnNumber(data?.soldQuantity ?? 0)} টি',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFFD9534F),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<LocalProductReportEntry> _filterEntries(
  List<LocalProductReportEntry> entries,
  String searchText,
) {
  final query = searchText.toLowerCase();
  final filtered = query.isEmpty
      ? [...entries]
      : entries
            .where((entry) => entry.productName.toLowerCase().contains(query))
            .toList();

  filtered.sort((a, b) {
    final profitCompare = b.profit.compareTo(a.profit);
    if (profitCompare != 0) {
      return profitCompare;
    }
    return b.soldQuantity.compareTo(a.soldQuantity);
  });
  return filtered;
}

void _selectPeriod(WidgetRef ref, _ProductReportPeriod period) {
  ref.read(_productReportPeriodProvider.notifier).state = period;
  if (period != _ProductReportPeriod.custom) {
    ref.read(_productReportCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_productReportPeriodProvider);
  final anchor = ref.read(_productReportAnchorDateProvider).toLocal();

  final next = switch (period) {
    _ProductReportPeriod.day => anchor.add(Duration(days: direction)),
    _ProductReportPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _ProductReportPeriod.year => DateTime(
      anchor.year + direction,
      anchor.month,
    ),
    _ProductReportPeriod.allTime => anchor,
    _ProductReportPeriod.custom => anchor,
  };

  ref.read(_productReportAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_productReportCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(
    ref.read(_productReportAnchorDateProvider),
  );
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

  ref.read(_productReportAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_productReportCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_productReportPeriodProvider.notifier).state =
      _ProductReportPeriod.custom;
}

String _rangeLabel(
  _ProductReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = anchorDate.toLocal();

  switch (period) {
    case _ProductReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _ProductReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _ProductReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _ProductReportPeriod.allTime:
      return 'সব সময়';
    case _ProductReportPeriod.custom:
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
