import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _SalesReportPeriod { day, month, year, allTime, custom }

final _salesReportProvider = StreamProvider<List<LocalSalesHistoryEntry>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesHistoryForCurrentShop(),
);

final _salesReportPeriodProvider = StateProvider<_SalesReportPeriod>(
  (ref) => _SalesReportPeriod.month,
);

final _salesReportAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _salesReportCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

class SalesReportPage extends ConsumerWidget {
  const SalesReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_salesReportPeriodProvider);
    final anchorDate = ref.watch(_salesReportAnchorDateProvider);
    final customRange = ref.watch(_salesReportCustomDateRangeProvider);
    final entries = ref.watch(_salesReportProvider).valueOrNull ?? const [];
    final filteredEntries = _filteredEntries(
      entries,
      period,
      anchorDate,
      customRange,
    );
    final total = filteredEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.netTotal,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SalesReportTopBar(),
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
                    112,
                  ),
                  children: [
                    _SalesReportHeroCard(total: total),
                    const SizedBox(height: AppSpacing.md),
                    const _SalesReportDateBar(),
                    const SizedBox(height: AppSpacing.md),
                    const _SalesReportFilters(),
                    const SizedBox(height: AppSpacing.lg),
                    if (filteredEntries.isEmpty)
                      const _SalesReportEmptyCard()
                    else
                      ..._buildSalesRecordItems(filteredEntries),
                  ],
                ),
                _SalesReportBottomSummary(total: total),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesReportTopBar extends StatelessWidget {
  const _SalesReportTopBar();

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
                    'বিক্রয় প্রতিবেদন',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SalesReportDateBar extends ConsumerWidget {
  const _SalesReportDateBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_salesReportPeriodProvider);
    final anchorDate = ref.watch(_salesReportAnchorDateProvider);
    final customRange = ref.watch(_salesReportCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _SalesReportPeriod.allTime &&
        period != _SalesReportPeriod.custom;

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

class _SalesReportFilters extends ConsumerWidget {
  const _SalesReportFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_salesReportPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _SalesReportChip(
            label: 'দিন',
            active: selectedPeriod == _SalesReportPeriod.day,
            onTap: () => _selectPeriod(ref, _SalesReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _SalesReportChip(
            label: 'মাস',
            active: selectedPeriod == _SalesReportPeriod.month,
            onTap: () => _selectPeriod(ref, _SalesReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _SalesReportChip(
            label: 'বছর',
            active: selectedPeriod == _SalesReportPeriod.year,
            onTap: () => _selectPeriod(ref, _SalesReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _SalesReportChip(
            label: 'সব সময়',
            active: selectedPeriod == _SalesReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _SalesReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SalesReportCustomChip(
          active: selectedPeriod == _SalesReportPeriod.custom,
          onTap: () => _pickCustomDateRange(context, ref),
        ),
      ],
    );
  }
}

class _SalesReportChip extends StatelessWidget {
  const _SalesReportChip({
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

class _SalesReportCustomChip extends StatelessWidget {
  const _SalesReportCustomChip({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          gradient: active ? AppGradients.primaryButton : null,
          color: active ? null : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 18,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              'কাস্টম',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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

class _SalesReportHeroCard extends StatelessWidget {
  const _SalesReportHeroCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'মোট বিক্রি',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
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
    );
  }
}

class _SalesReportDayHeader extends StatelessWidget {
  const _SalesReportDayHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE1E7E4), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE1E7E4), thickness: 1)),
      ],
    );
  }
}

class _SalesReportEntryCard extends StatelessWidget {
  const _SalesReportEntryCard({
    required this.accentColor,
    required this.code,
    required this.name,
    required this.amount,
    required this.statusText,
    required this.statusColor,
    required this.statusBackground,
  });

  final Color accentColor;
  final String code;
  final String name;
  final String amount;
  final String statusText;
  final Color statusColor;
  final Color statusBackground;

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
            height: 112,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          code,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
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
                            color: statusBackground,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusText,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 26),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ],
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

class _SalesReportBottomSummary extends StatelessWidget {
  const _SalesReportBottomSummary({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppSpacing.md,
      right: AppSpacing.md,
      bottom: AppSpacing.md,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          gradient: AppGradients.primaryButton,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.button,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: const Icon(Icons.payments_rounded, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'এই সময়সীমায় মোট বিক্রি',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.84),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _money(total),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesReportEmptyCard extends StatelessWidget {
  const _SalesReportEmptyCard();

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
        'এই সময়সীমায় কোনো বিক্রি নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<Widget> _buildSalesRecordItems(List<LocalSalesHistoryEntry> entries) {
  final sorted = [...entries]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final items = <Widget>[];
  DateTime? previousDay;

  for (final entry in sorted) {
    final localDate = AppTime.toLocal(entry.createdAt);
    final day = DateTime(localDate.year, localDate.month, localDate.day);
    if (previousDay == null || previousDay != day) {
      if (items.isNotEmpty) {
        items.add(const SizedBox(height: AppSpacing.lg));
      }
      items.add(_SalesReportDayHeader(label: _dayHeader(localDate)));
      items.add(const SizedBox(height: AppSpacing.md));
      previousDay = day;
    } else {
      items.add(const SizedBox(height: AppSpacing.md));
    }

    final status = _statusStyle(entry);
    items.add(
      _SalesReportEntryCard(
        accentColor: status.color,
        code:
            '#${entry.id.substring(0, 6).toUpperCase()}  •  ${_time(localDate)}',
        name: _customerLabel(entry),
        amount: _money(entry.netTotal),
        statusText: status.text,
        statusColor: status.color,
        statusBackground: status.background,
      ),
    );
  }

  return items;
}

List<LocalSalesHistoryEntry> _filteredEntries(
  List<LocalSalesHistoryEntry> entries,
  _SalesReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  return entries
      .where(
        (entry) => _isInRange(entry.createdAt, period, anchorDate, customRange),
      )
      .toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}

void _selectPeriod(WidgetRef ref, _SalesReportPeriod period) {
  ref.read(_salesReportPeriodProvider.notifier).state = period;
  if (period != _SalesReportPeriod.custom) {
    ref.read(_salesReportCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_salesReportPeriodProvider);
  final anchor = ref.read(_salesReportAnchorDateProvider).toLocal();

  final next = switch (period) {
    _SalesReportPeriod.day => anchor.add(Duration(days: direction)),
    _SalesReportPeriod.month => DateTime(anchor.year, anchor.month + direction),
    _SalesReportPeriod.year => DateTime(anchor.year + direction, anchor.month),
    _SalesReportPeriod.allTime => anchor,
    _SalesReportPeriod.custom => anchor,
  };

  ref.read(_salesReportAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_salesReportCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(ref.read(_salesReportAnchorDateProvider));
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

  ref.read(_salesReportAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_salesReportCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_salesReportPeriodProvider.notifier).state =
      _SalesReportPeriod.custom;
}

bool _isInRange(
  DateTime value,
  _SalesReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  value = AppTime.toLocal(value);
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _SalesReportPeriod.day:
      return value.year == anchor.year &&
          value.month == anchor.month &&
          value.day == anchor.day;
    case _SalesReportPeriod.month:
      return value.year == anchor.year && value.month == anchor.month;
    case _SalesReportPeriod.year:
      return value.year == anchor.year;
    case _SalesReportPeriod.allTime:
      return true;
    case _SalesReportPeriod.custom:
      if (customRange == null) {
        return true;
      }
      final day = DateTime(value.year, value.month, value.day);
      final start = DateTime(
        customRange.start.year,
        customRange.start.month,
        customRange.start.day,
      );
      final end = DateTime(
        customRange.end.year,
        customRange.end.month,
        customRange.end.day,
      );
      return !day.isBefore(start) && !day.isAfter(end);
  }
}

String _rangeLabel(
  _SalesReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _SalesReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _SalesReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _SalesReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _SalesReportPeriod.allTime:
      return 'সব সময়';
    case _SalesReportPeriod.custom:
      if (customRange == null) {
        return 'কাস্টম রেঞ্জ';
      }
      return '${_formatBanglaDate(customRange.start)} - '
          '${_formatBanglaDate(customRange.end)}';
  }
}

_StatusStyle _statusStyle(LocalSalesHistoryEntry entry) {
  if (entry.hasReturns && entry.dueAmount <= 0) {
    return const _StatusStyle(
      text: 'ফেরত হয়েছে',
      background: Color(0xFFFFF1E8),
      color: Color(0xFFDC7A37),
    );
  }
  if (entry.dueAmount <= 0) {
    return _StatusStyle(
      text: _paymentMethodText(entry.paymentMethod),
      background: const Color(0xFFE4FBF6),
      color: const Color(0xFF138E7A),
    );
  }
  if (entry.paidAmount > 0) {
    return _StatusStyle(
      text: 'বাকি ${_money(entry.dueAmount)}',
      background: const Color(0xFFFFF1E8),
      color: const Color(0xFFDC7A37),
    );
  }
  return const _StatusStyle(
    text: 'বাকি',
    background: Color(0xFFFFECEC),
    color: Color(0xFFD9534F),
  );
}

class _StatusStyle {
  const _StatusStyle({
    required this.text,
    required this.background,
    required this.color,
  });

  final String text;
  final Color background;
  final Color color;
}

String _paymentMethodText(String? method) {
  if (method == 'bank_card') {
    return 'ব্যাংক/কার্ড';
  }
  return switch (method) {
    'cash' => 'নগদ টাকা',
    'mobile_banking' => 'বিকাশ/নগদ',
    'due' => 'বাকি',
    _ => 'পরিশোধ',
  };
}

String _customerLabel(LocalSalesHistoryEntry entry) {
  final phone = entry.customerPhone.trim();
  if (phone.isEmpty) {
    return entry.customerName;
  }
  return '${entry.customerName} • ${_bnNumber(phone)}';
}

String _formatBanglaDate(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_banglaMonths[date.month - 1]}, ${_bnNumber(date.year)}';
}

String _dayHeader(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_shortMonths[date.month - 1].toUpperCase()} ${_bnNumber(date.year)}';
}

String _time(DateTime value) {
  final hour12 = value.hour % 12 == 0 ? 12 : value.hour % 12;
  final minute = value.minute.toString().padLeft(2, '0');
  final suffix = value.hour >= 12 ? 'PM' : 'AM';
  return '${_bnNumber(hour12.toString().padLeft(2, '0'))}:'
      '${_bnNumber(minute)} $suffix';
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
