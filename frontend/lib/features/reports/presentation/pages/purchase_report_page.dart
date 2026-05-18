import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _PurchaseReportPeriod { day, month, year, allTime, custom }

final _purchaseReportProvider = StreamProvider<List<LocalPurchaseHistoryEntry>>(
  (ref) => ref.watch(appDatabaseProvider).watchPurchaseHistoryForCurrentShop(),
);

final _purchaseReportPeriodProvider = StateProvider<_PurchaseReportPeriod>(
  (ref) => _PurchaseReportPeriod.month,
);

final _purchaseReportAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _purchaseReportCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

class PurchaseReportPage extends ConsumerWidget {
  const PurchaseReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_purchaseReportPeriodProvider);
    final anchorDate = ref.watch(_purchaseReportAnchorDateProvider);
    final customRange = ref.watch(_purchaseReportCustomDateRangeProvider);
    final entries = ref.watch(_purchaseReportProvider).valueOrNull ?? const [];
    final filteredEntries = _filteredEntries(
      entries,
      period,
      anchorDate,
      customRange,
    );
    final total = filteredEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.total,
    );

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
                  children: [
                    _PurchaseReportHeroCard(total: total),
                    const SizedBox(height: AppSpacing.md),
                    const _PurchaseReportDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _PurchaseReportFilterTabs(),
                    const SizedBox(height: AppSpacing.lg),
                    _PurchaseReportSectionHeader(count: filteredEntries.length),
                    const SizedBox(height: AppSpacing.md),
                    if (filteredEntries.isEmpty)
                      const _PurchaseReportEmptyCard()
                    else
                      ..._buildPurchaseItems(filteredEntries),
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
                    'ক্রয় প্রতিবেদন',
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

class _PurchaseReportFilterTabs extends ConsumerWidget {
  const _PurchaseReportFilterTabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_purchaseReportPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _PurchaseReportChip(
            label: 'দিন',
            active: selectedPeriod == _PurchaseReportPeriod.day,
            onTap: () => _selectPeriod(ref, _PurchaseReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _PurchaseReportChip(
            label: 'মাস',
            active: selectedPeriod == _PurchaseReportPeriod.month,
            onTap: () => _selectPeriod(ref, _PurchaseReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _PurchaseReportChip(
            label: 'বছর',
            active: selectedPeriod == _PurchaseReportPeriod.year,
            onTap: () => _selectPeriod(ref, _PurchaseReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _PurchaseReportChip(
            label: 'সব সময়',
            active: selectedPeriod == _PurchaseReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _PurchaseReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _PurchaseReportChip(
            label: 'কাস্টম',
            active: selectedPeriod == _PurchaseReportPeriod.custom,
            onTap: () => _pickCustomDateRange(context, ref),
          ),
        ),
      ],
    );
  }
}

class _PurchaseReportChip extends StatelessWidget {
  const _PurchaseReportChip({
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

class _PurchaseReportDateCard extends ConsumerWidget {
  const _PurchaseReportDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_purchaseReportPeriodProvider);
    final anchorDate = ref.watch(_purchaseReportAnchorDateProvider);
    final customRange = ref.watch(_purchaseReportCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _PurchaseReportPeriod.allTime &&
        period != _PurchaseReportPeriod.custom;

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

class _PurchaseReportHeroCard extends StatelessWidget {
  const _PurchaseReportHeroCard({required this.total});

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'মোট কেনা (PURCHASE SUMMARY)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
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
                      TextSpan(text: _money(total)),
                      TextSpan(
                        text: ' / মোট খরচ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.72),
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
                  color: Colors.white.withValues(alpha: 0.1),
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
  const _PurchaseReportSectionHeader({required this.count});

  final int count;

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
            '${_bnNumber(count)}টি রেকর্ড',
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
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
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
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
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
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
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
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
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
                    child: Icon(trailingIcon, color: AppColors.primary),
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

class _PurchaseReportEmptyCard extends StatelessWidget {
  const _PurchaseReportEmptyCard();

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
        'এই সময়সীমায় কোনো কেনা নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<Widget> _buildPurchaseItems(List<LocalPurchaseHistoryEntry> entries) {
  final sorted = [...entries]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final items = <Widget>[];

  for (var i = 0; i < sorted.length; i++) {
    final entry = sorted[i];
    final status = _statusStyle(entry);
    items.add(
      _PurchaseReportEntryCard(
        code: '#${entry.id.substring(0, 6).toUpperCase()}',
        amount: _money(entry.total),
        time: _time(AppTime.toLocal(entry.createdAt)),
        statusText: status.text,
        statusColor: status.color,
        statusBackground: status.background,
        accentColor: status.color.withValues(alpha: 0.45),
        trailingIcon: entry.dueAmount > 0
            ? Icons.shopping_bag_rounded
            : Icons.payments_rounded,
      ),
    );
    if (i != sorted.length - 1) {
      items.add(const SizedBox(height: AppSpacing.md));
    }
  }

  return items;
}

List<LocalPurchaseHistoryEntry> _filteredEntries(
  List<LocalPurchaseHistoryEntry> entries,
  _PurchaseReportPeriod period,
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

void _selectPeriod(WidgetRef ref, _PurchaseReportPeriod period) {
  ref.read(_purchaseReportPeriodProvider.notifier).state = period;
  if (period != _PurchaseReportPeriod.custom) {
    ref.read(_purchaseReportCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_purchaseReportPeriodProvider);
  final anchor = ref.read(_purchaseReportAnchorDateProvider).toLocal();

  final next = switch (period) {
    _PurchaseReportPeriod.day => anchor.add(Duration(days: direction)),
    _PurchaseReportPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _PurchaseReportPeriod.year => DateTime(
      anchor.year + direction,
      anchor.month,
    ),
    _PurchaseReportPeriod.allTime => anchor,
    _PurchaseReportPeriod.custom => anchor,
  };

  ref.read(_purchaseReportAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_purchaseReportCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(
    ref.read(_purchaseReportAnchorDateProvider),
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

  ref.read(_purchaseReportAnchorDateProvider.notifier).state =
      pickedRange.start;
  ref.read(_purchaseReportCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_purchaseReportPeriodProvider.notifier).state =
      _PurchaseReportPeriod.custom;
}

bool _isInRange(
  DateTime value,
  _PurchaseReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  value = AppTime.toLocal(value);
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _PurchaseReportPeriod.day:
      return value.year == anchor.year &&
          value.month == anchor.month &&
          value.day == anchor.day;
    case _PurchaseReportPeriod.month:
      return value.year == anchor.year && value.month == anchor.month;
    case _PurchaseReportPeriod.year:
      return value.year == anchor.year;
    case _PurchaseReportPeriod.allTime:
      return true;
    case _PurchaseReportPeriod.custom:
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
  _PurchaseReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _PurchaseReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _PurchaseReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _PurchaseReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _PurchaseReportPeriod.allTime:
      return 'সব সময়';
    case _PurchaseReportPeriod.custom:
      if (customRange == null) {
        return 'কাস্টম রেঞ্জ';
      }
      return '${_formatBanglaDate(customRange.start)} - '
          '${_formatBanglaDate(customRange.end)}';
  }
}

_StatusStyle _statusStyle(LocalPurchaseHistoryEntry entry) {
  if (entry.dueAmount <= 0) {
    return const _StatusStyle(
      text: 'নগদ টাকা',
      background: Color(0xFFE4FBF6),
      color: Color(0xFF138E7A),
    );
  }
  if (entry.paidAmount > 0) {
    return const _StatusStyle(
      text: 'আংশিক',
      background: Color(0xFFFFF1E8),
      color: Color(0xFFDC7A37),
    );
  }
  return const _StatusStyle(
    text: 'বাকি',
    background: Color(0xFFFFE7E7),
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

String _formatBanglaDate(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_banglaMonths[date.month - 1]}, ${_bnNumber(date.year)}';
}

String _time(DateTime value) {
  final hour12 = value.hour % 12 == 0 ? 12 : value.hour % 12;
  final minute = value.minute.toString().padLeft(2, '0');
  final suffix = value.hour >= 12 ? 'পিএম' : 'এএম';
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
