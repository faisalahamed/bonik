import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _ExpenseReportPeriod { day, month, year, allTime, custom }

class _ExpenseReportDateRange {
  const _ExpenseReportDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

final _expenseReportPeriodProvider = StateProvider<_ExpenseReportPeriod>(
  (ref) => _ExpenseReportPeriod.month,
);

final _expenseReportAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _expenseReportCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _expenseReportDateRangeProvider = Provider<_ExpenseReportDateRange?>((
  ref,
) {
  final period = ref.watch(_expenseReportPeriodProvider);
  final anchor = ref.watch(_expenseReportAnchorDateProvider).toLocal();
  final customRange = ref.watch(_expenseReportCustomDateRangeProvider);

  switch (period) {
    case _ExpenseReportPeriod.day:
      final start = DateTime(anchor.year, anchor.month, anchor.day);
      return _ExpenseReportDateRange(
        start: start.toUtc(),
        end: start.add(const Duration(days: 1)).toUtc(),
      );
    case _ExpenseReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1);
      return _ExpenseReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _ExpenseReportPeriod.year:
      final start = DateTime(anchor.year);
      final end = DateTime(anchor.year + 1);
      return _ExpenseReportDateRange(start: start.toUtc(), end: end.toUtc());
    case _ExpenseReportPeriod.allTime:
      return null;
    case _ExpenseReportPeriod.custom:
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
      return _ExpenseReportDateRange(start: start.toUtc(), end: end.toUtc());
  }
});

final _expenseReportProvider = StreamProvider<List<LocalExpenseHistoryEntry>>((
  ref,
) {
  final range = ref.watch(_expenseReportDateRangeProvider);
  return ref
      .watch(appDatabaseProvider)
      .watchExpenseReportForCurrentShop(start: range?.start, end: range?.end);
});

class ExpenseReportPage extends ConsumerWidget {
  const ExpenseReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(_expenseReportProvider).valueOrNull ?? const [];
    final total = entries.fold<double>(0, (sum, entry) => sum + entry.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ExpenseReportTopBar(),
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
                    _ExpenseSummaryCard(total: total),
                    const SizedBox(height: AppSpacing.md),
                    const _ExpenseReportDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _ExpenseReportFilters(),
                    const SizedBox(height: AppSpacing.xl),
                    if (entries.isEmpty)
                      const _ExpenseEmptyCard()
                    else
                      ..._buildExpenseRecordItems(entries),
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

class _ExpenseReportTopBar extends StatelessWidget {
  const _ExpenseReportTopBar();

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
                    'ব্যয় রিপোর্ট',
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

class _ExpenseReportFilters extends ConsumerWidget {
  const _ExpenseReportFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_expenseReportPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _ExpenseFilterChip(
            label: 'দিন',
            active: selectedPeriod == _ExpenseReportPeriod.day,
            onTap: () => _selectPeriod(ref, _ExpenseReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ExpenseFilterChip(
            label: 'মাস',
            active: selectedPeriod == _ExpenseReportPeriod.month,
            onTap: () => _selectPeriod(ref, _ExpenseReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ExpenseFilterChip(
            label: 'বছর',
            active: selectedPeriod == _ExpenseReportPeriod.year,
            onTap: () => _selectPeriod(ref, _ExpenseReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ExpenseFilterChip(
            label: 'সব সময়',
            active: selectedPeriod == _ExpenseReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _ExpenseReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ExpenseFilterChip(
            label: 'কাস্টম',
            icon: Icons.calendar_month_rounded,
            active: selectedPeriod == _ExpenseReportPeriod.custom,
            onTap: () => _pickCustomDateRange(context, ref),
          ),
        ),
      ],
    );
  }
}

class _ExpenseFilterChip extends StatelessWidget {
  const _ExpenseFilterChip({
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

class _ExpenseReportDateCard extends ConsumerWidget {
  const _ExpenseReportDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_expenseReportPeriodProvider);
    final anchorDate = ref.watch(_expenseReportAnchorDateProvider);
    final customRange = ref.watch(_expenseReportCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _ExpenseReportPeriod.allTime &&
        period != _ExpenseReportPeriod.custom;

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
            child: Column(
              children: [
                Text(
                  'সময়সীমা',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
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

class _ExpenseSummaryCard extends StatelessWidget {
  const _ExpenseSummaryCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'মোট খরচ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _money(total),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 64,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseDayLabel extends StatelessWidget {
  const _ExpenseDayLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ExpenseRecordCard extends StatelessWidget {
  const _ExpenseRecordCard({
    required this.icon,
    required this.title,
    required this.dateTime,
    required this.amount,
  });

  final IconData icon;
  final String title;
  final String dateTime;
  final String amount;

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
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  dateTime,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseEmptyCard extends StatelessWidget {
  const _ExpenseEmptyCard();

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
        'এই সময়সীমায় কোনো ব্যয় নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<Widget> _buildExpenseRecordItems(List<LocalExpenseHistoryEntry> entries) {
  final sorted = [...entries]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final items = <Widget>[];
  DateTime? previousDay;

  for (final entry in sorted) {
    final localDate = AppTime.toLocal(entry.createdAt);
    final day = DateTime(localDate.year, localDate.month, localDate.day);

    if (previousDay == null || previousDay != day) {
      if (items.isNotEmpty) {
        items.add(const SizedBox(height: AppSpacing.xl));
      }
      items.add(_ExpenseDayLabel(label: _formatBanglaDate(day)));
      items.add(const SizedBox(height: AppSpacing.md));
      previousDay = day;
    } else {
      items.add(const SizedBox(height: AppSpacing.md));
    }

    items.add(
      _ExpenseRecordCard(
        icon: _expenseIcon(entry.categoryName),
        title: entry.categoryName,
        dateTime: _formatDateTime(localDate),
        amount: _money(entry.amount),
      ),
    );
  }

  return items;
}

void _selectPeriod(WidgetRef ref, _ExpenseReportPeriod period) {
  ref.read(_expenseReportPeriodProvider.notifier).state = period;
  if (period != _ExpenseReportPeriod.custom) {
    ref.read(_expenseReportCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_expenseReportPeriodProvider);
  final anchor = ref.read(_expenseReportAnchorDateProvider).toLocal();

  final next = switch (period) {
    _ExpenseReportPeriod.day => anchor.add(Duration(days: direction)),
    _ExpenseReportPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _ExpenseReportPeriod.year => DateTime(
      anchor.year + direction,
      anchor.month,
    ),
    _ExpenseReportPeriod.allTime => anchor,
    _ExpenseReportPeriod.custom => anchor,
  };

  ref.read(_expenseReportAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_expenseReportCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(
    ref.read(_expenseReportAnchorDateProvider),
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

  ref.read(_expenseReportAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_expenseReportCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_expenseReportPeriodProvider.notifier).state =
      _ExpenseReportPeriod.custom;
}

String _rangeLabel(
  _ExpenseReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = anchorDate.toLocal();

  switch (period) {
    case _ExpenseReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _ExpenseReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _ExpenseReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _ExpenseReportPeriod.allTime:
      return 'সব সময়';
    case _ExpenseReportPeriod.custom:
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

String _formatDateTime(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = _shortMonths[value.month - 1];
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '${_bnNumber(day)} $month ${_bnNumber(value.year)}, '
      '${_bnNumber('$hour:$minute')}';
}

IconData _expenseIcon(String categoryName) {
  final name = categoryName.toLowerCase();
  if (name.contains('food') || name.contains('খাবার')) {
    return Icons.restaurant_rounded;
  }
  if (name.contains('transport') ||
      name.contains('delivery') ||
      name.contains('পরিবহন')) {
    return Icons.local_shipping_rounded;
  }
  if (name.contains('rent') ||
      name.contains('ভাড়া') ||
      name.contains('ভাড়া')) {
    return Icons.apartment_rounded;
  }
  if (name.contains('marketing') || name.contains('মার্কেটিং')) {
    return Icons.campaign_rounded;
  }
  return Icons.payments_rounded;
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

const _shortMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
