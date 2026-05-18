import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _OtherIncomeReportPeriod { day, month, year, allTime, custom }

class _OtherIncomeDateRange {
  const _OtherIncomeDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

final _otherIncomePeriodProvider = StateProvider<_OtherIncomeReportPeriod>(
  (ref) => _OtherIncomeReportPeriod.month,
);

final _otherIncomeAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _otherIncomeCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _otherIncomeDateRangeProvider = Provider<_OtherIncomeDateRange?>((ref) {
  final period = ref.watch(_otherIncomePeriodProvider);
  final anchor = ref.watch(_otherIncomeAnchorDateProvider).toLocal();
  final customRange = ref.watch(_otherIncomeCustomDateRangeProvider);

  switch (period) {
    case _OtherIncomeReportPeriod.day:
      final start = DateTime(anchor.year, anchor.month, anchor.day);
      return _OtherIncomeDateRange(
        start: start.toUtc(),
        end: start.add(const Duration(days: 1)).toUtc(),
      );
    case _OtherIncomeReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1);
      return _OtherIncomeDateRange(start: start.toUtc(), end: end.toUtc());
    case _OtherIncomeReportPeriod.year:
      final start = DateTime(anchor.year);
      final end = DateTime(anchor.year + 1);
      return _OtherIncomeDateRange(start: start.toUtc(), end: end.toUtc());
    case _OtherIncomeReportPeriod.allTime:
      return null;
    case _OtherIncomeReportPeriod.custom:
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
      return _OtherIncomeDateRange(start: start.toUtc(), end: end.toUtc());
  }
});

final _otherIncomeReportProvider = StreamProvider<List<LocalIncomeReportEntry>>(
  (ref) {
    final range = ref.watch(_otherIncomeDateRangeProvider);
    return ref
        .watch(appDatabaseProvider)
        .watchIncomeReportForCurrentShop(start: range?.start, end: range?.end);
  },
);

class OtherIncomeReportPage extends ConsumerWidget {
  const OtherIncomeReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries =
        ref.watch(_otherIncomeReportProvider).valueOrNull ?? const [];
    final total = entries.fold<double>(0, (sum, entry) => sum + entry.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _OtherIncomeTopBar(),
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
                    _OtherIncomeHeroCard(total: total),
                    const SizedBox(height: AppSpacing.md),
                    const _OtherIncomeDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _OtherIncomeFilters(),
                    const SizedBox(height: AppSpacing.xl),
                    const _OtherIncomeSectionHeader(),
                    const SizedBox(height: AppSpacing.md),
                    if (entries.isEmpty)
                      const _OtherIncomeEmptyCard()
                    else
                      ..._buildIncomeRecordItems(entries),
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

class _OtherIncomeTopBar extends StatelessWidget {
  const _OtherIncomeTopBar();

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
                    'আয়ের রিপোর্ট',
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

class _OtherIncomeDateCard extends ConsumerWidget {
  const _OtherIncomeDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_otherIncomePeriodProvider);
    final anchorDate = ref.watch(_otherIncomeAnchorDateProvider);
    final customRange = ref.watch(_otherIncomeCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _OtherIncomeReportPeriod.allTime &&
        period != _OtherIncomeReportPeriod.custom;

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

class _OtherIncomeFilters extends ConsumerWidget {
  const _OtherIncomeFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_otherIncomePeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _OtherIncomeChip(
            label: 'দিন',
            active: selectedPeriod == _OtherIncomeReportPeriod.day,
            onTap: () => _selectPeriod(ref, _OtherIncomeReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _OtherIncomeChip(
            label: 'মাস',
            active: selectedPeriod == _OtherIncomeReportPeriod.month,
            onTap: () => _selectPeriod(ref, _OtherIncomeReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _OtherIncomeChip(
            label: 'বছর',
            active: selectedPeriod == _OtherIncomeReportPeriod.year,
            onTap: () => _selectPeriod(ref, _OtherIncomeReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _OtherIncomeChip(
            label: 'সব সময়',
            active: selectedPeriod == _OtherIncomeReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _OtherIncomeReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _OtherIncomeChip(
            label: 'কাস্টম',
            icon: Icons.calendar_month_rounded,
            active: selectedPeriod == _OtherIncomeReportPeriod.custom,
            onTap: () => _pickCustomDateRange(context, ref),
          ),
        ),
      ],
    );
  }
}

class _OtherIncomeChip extends StatelessWidget {
  const _OtherIncomeChip({
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

class _OtherIncomeHeroCard extends StatelessWidget {
  const _OtherIncomeHeroCard({required this.total});

  final double total;

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
            'মোট আয়',
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
    );
  }
}

class _OtherIncomeSectionHeader extends StatelessWidget {
  const _OtherIncomeSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'বিস্তারিত লেনদেন',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
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
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'আয়ের তালিকা',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _OtherIncomeRecordCard extends StatelessWidget {
  const _OtherIncomeRecordCard({
    required this.icon,
    required this.title,
    required this.dateText,
    required this.amount,
  });

  final IconData icon;
  final String title;
  final String dateText;
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
            width: 50,
            height: 50,
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4FBF6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'INCOME',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  dateText,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
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
              const SizedBox(height: 4),
              Text(
                'সফল',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OtherIncomeEmptyCard extends StatelessWidget {
  const _OtherIncomeEmptyCard();

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
        'এই সময়সীমায় কোনো আয় নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<Widget> _buildIncomeRecordItems(List<LocalIncomeReportEntry> entries) {
  final sorted = [...entries]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final items = <Widget>[];

  for (var i = 0; i < sorted.length; i++) {
    final entry = sorted[i];
    items.add(
      _OtherIncomeRecordCard(
        icon: _incomeIcon(entry.categoryName),
        title: entry.categoryName,
        dateText: _formatDateTime(AppTime.toLocal(entry.createdAt)),
        amount: _money(entry.amount),
      ),
    );
    if (i != sorted.length - 1) {
      items.add(const SizedBox(height: AppSpacing.md));
    }
  }

  return items;
}

void _selectPeriod(WidgetRef ref, _OtherIncomeReportPeriod period) {
  ref.read(_otherIncomePeriodProvider.notifier).state = period;
  if (period != _OtherIncomeReportPeriod.custom) {
    ref.read(_otherIncomeCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_otherIncomePeriodProvider);
  final anchor = ref.read(_otherIncomeAnchorDateProvider).toLocal();

  final next = switch (period) {
    _OtherIncomeReportPeriod.day => anchor.add(Duration(days: direction)),
    _OtherIncomeReportPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _OtherIncomeReportPeriod.year => DateTime(
      anchor.year + direction,
      anchor.month,
    ),
    _OtherIncomeReportPeriod.allTime => anchor,
    _OtherIncomeReportPeriod.custom => anchor,
  };

  ref.read(_otherIncomeAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_otherIncomeCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(ref.read(_otherIncomeAnchorDateProvider));
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

  ref.read(_otherIncomeAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_otherIncomeCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_otherIncomePeriodProvider.notifier).state =
      _OtherIncomeReportPeriod.custom;
}

String _rangeLabel(
  _OtherIncomeReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = anchorDate.toLocal();

  switch (period) {
    case _OtherIncomeReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _OtherIncomeReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _OtherIncomeReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _OtherIncomeReportPeriod.allTime:
      return 'সব সময়';
    case _OtherIncomeReportPeriod.custom:
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

IconData _incomeIcon(String categoryName) {
  final name = categoryName.toLowerCase();
  if (name.contains('stock') || name.contains('স্টক')) {
    return Icons.inventory_2_rounded;
  }
  if (name.contains('commission') || name.contains('কমিশন')) {
    return Icons.waving_hand_rounded;
  }
  if (name.contains('bonus') || name.contains('বোনাস')) {
    return Icons.payments_rounded;
  }
  return Icons.label_rounded;
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
