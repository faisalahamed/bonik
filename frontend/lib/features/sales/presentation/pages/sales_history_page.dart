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

final _salesHistoryProvider = StreamProvider<List<LocalSalesHistoryEntry>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesHistoryForCurrentShop(),
);

class SalesHistoryPage extends ConsumerStatefulWidget {
  const SalesHistoryPage({super.key});

  @override
  ConsumerState<SalesHistoryPage> createState() => _SalesHistoryPageState();
}

class _SalesHistoryPageState extends ConsumerState<SalesHistoryPage> {
  var _selectedRange = _SalesHistoryRange.day;
  var _rangeAnchorDate = DateTime.now();
  DateTimeRange? _customDateRange;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(_salesHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SalesHistoryTopBar(),
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
                history.when(
                  data: (entries) => _SalesHistoryList(
                    entries: entries,
                    selectedRange: _selectedRange,
                    rangeAnchorDate: _rangeAnchorDate,
                    customDateRange: _customDateRange,
                    onRangeSelected: (range) {
                      setState(() {
                        _selectedRange = range;
                        _rangeAnchorDate = DateTime.now();
                        _customDateRange = null;
                      });
                    },
                    onCustomRangeSelected: _selectCustomDateRange,
                    onPreviousRange: () => _moveRange(-1),
                    onNextRange: () => _moveRange(1),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => _SalesHistoryList(
                    entries: const [],
                    selectedRange: _selectedRange,
                    rangeAnchorDate: _rangeAnchorDate,
                    customDateRange: _customDateRange,
                    onRangeSelected: (range) {
                      setState(() {
                        _selectedRange = range;
                        _rangeAnchorDate = DateTime.now();
                        _customDateRange = null;
                      });
                    },
                    onCustomRangeSelected: _selectCustomDateRange,
                    onPreviousRange: () => _moveRange(-1),
                    onNextRange: () => _moveRange(1),
                    message: 'বিক্রির ডাটা পাওয়া যায়নি',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _moveRange(int step) {
    if (_selectedRange == _SalesHistoryRange.all ||
        _selectedRange == _SalesHistoryRange.custom) {
      return;
    }

    setState(() {
      _rangeAnchorDate = _shiftRangeDate(
        _rangeAnchorDate,
        _selectedRange,
        step,
      );
    });
  }

  Future<void> _selectCustomDateRange() async {
    final now = DateTime.now();
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 5, 12, 31),
      initialDateRange: _customDateRange ?? DateTimeRange(start: now, end: now),
      helpText: 'তারিখের রেঞ্জ নির্বাচন করুন',
      cancelText: 'বাতিল',
      confirmText: 'ঠিক আছে',
    );
    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _selectedRange = _SalesHistoryRange.custom;
      _customDateRange = selected;
      _rangeAnchorDate = selected.start;
    });
  }
}

class _SalesHistoryTopBar extends StatelessWidget {
  const _SalesHistoryTopBar();

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
                    'বেচার খাতা',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(Icons.person_rounded, color: Colors.white, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SalesHistoryList extends StatelessWidget {
  const _SalesHistoryList({
    required this.entries,
    required this.selectedRange,
    required this.rangeAnchorDate,
    required this.customDateRange,
    required this.onRangeSelected,
    required this.onCustomRangeSelected,
    required this.onPreviousRange,
    required this.onNextRange,
    this.message,
  });

  final List<LocalSalesHistoryEntry> entries;
  final _SalesHistoryRange selectedRange;
  final DateTime rangeAnchorDate;
  final DateTimeRange? customDateRange;
  final ValueChanged<_SalesHistoryRange> onRangeSelected;
  final VoidCallback onCustomRangeSelected;
  final VoidCallback onPreviousRange;
  final VoidCallback onNextRange;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final filteredEntries = entries
        .where(
          (entry) => _isInRange(
            entry.createdAt,
            selectedRange,
            rangeAnchorDate,
            customDateRange,
          ),
        )
        .toList();
    filteredEntries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final total = filteredEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.netTotal,
    );

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      itemCount: filteredEntries.isEmpty ? 5 : filteredEntries.length + 4,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _SalesHeroCard(
            total: total,
            count: filteredEntries.length,
            rangeLabel: _rangeLabel(
              selectedRange,
              rangeAnchorDate,
              customDateRange,
            ),
            canNavigate:
                selectedRange != _SalesHistoryRange.all &&
                selectedRange != _SalesHistoryRange.custom,
            onPrevious: onPreviousRange,
            onNext: onNextRange,
          );
        }
        if (index == 1) {
          return _SalesFilterTabs(
            selectedRange: selectedRange,
            onRangeSelected: onRangeSelected,
            onCustomRangeSelected: onCustomRangeSelected,
          );
        }
        if (index == 2) {
          return const _SalesSearchBox();
        }
        if (index == 3) {
          return const _SectionTitle(title: 'সাম্প্রতিক লেনদেন');
        }
        if (index == 4 && filteredEntries.isEmpty) {
          return _EmptySalesHistoryCard(
            message:
                message ??
                _emptyMessage(selectedRange, rangeAnchorDate, customDateRange),
          );
        }

        return _SalesHistoryItemCard(entry: filteredEntries[index - 4]);
      },
    );
  }
}

class _SalesHeroCard extends StatelessWidget {
  const _SalesHeroCard({
    required this.total,
    required this.count,
    required this.rangeLabel,
    required this.canNavigate,
    required this.onPrevious,
    required this.onNext,
  });

  final double total;
  final int count;
  final String rangeLabel;
  final bool canNavigate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Color(0xFFE6FFF4),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  rangeLabel,
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium?.copyWith(
                    color: const Color(0xFFE6FFF4),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _RangeNavButton(
                icon: Icons.chevron_left_rounded,
                enabled: canNavigate,
                onTap: onPrevious,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'মোট বিক্রি',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _money(total),
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _RangeNavButton(
                icon: Icons.chevron_right_rounded,
                enabled: canNavigate,
                onTap: onNext,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${_bnNumber(count)}টি বিক্রির রেকর্ড',
            style: textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesFilterTabs extends StatelessWidget {
  const _SalesFilterTabs({
    required this.selectedRange,
    required this.onRangeSelected,
    required this.onCustomRangeSelected,
  });

  final _SalesHistoryRange selectedRange;
  final ValueChanged<_SalesHistoryRange> onRangeSelected;
  final VoidCallback onCustomRangeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterChip(
            label: 'দিন',
            active: selectedRange == _SalesHistoryRange.day,
            onTap: () => onRangeSelected(_SalesHistoryRange.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'মাস',
            active: selectedRange == _SalesHistoryRange.month,
            onTap: () => onRangeSelected(_SalesHistoryRange.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'বছর',
            active: selectedRange == _SalesHistoryRange.year,
            onTap: () => onRangeSelected(_SalesHistoryRange.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'সব',
            active: selectedRange == _SalesHistoryRange.all,
            onTap: () => onRangeSelected(_SalesHistoryRange.all),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SortChip(
          active: selectedRange == _SalesHistoryRange.custom,
          onTap: onCustomRangeSelected,
        ),
      ],
    );
  }
}

class _RangeNavButton extends StatelessWidget {
  const _RangeNavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Ink(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: enabled ? 0.12 : 0.06),
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: enabled ? 1 : 0.45),
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Ink(
          height: 42,
          decoration: BoxDecoration(
            gradient: active ? AppGradients.primaryButton : null,
            color: active ? null : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: active ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Ink(
          width: 52,
          height: 42,
          decoration: BoxDecoration(
            gradient: active ? AppGradients.primaryButton : null,
            color: active ? null : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Icon(
            Icons.date_range_rounded,
            color: active ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _SalesSearchBox extends StatelessWidget {
  const _SalesSearchBox();

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
          hintText: 'অনুসন্ধান করুন (নাম, মোবাইল, রিসিপ্ট)',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _EmptySalesHistoryCard extends StatelessWidget {
  const _EmptySalesHistoryCard({required this.message});

  final String message;

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
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SalesHistoryItemCard extends StatelessWidget {
  const _SalesHistoryItemCard({required this.entry});

  final LocalSalesHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final status = _statusStyle(entry);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () =>
            context.push(AppRoutes.salesHistoryDetails, extra: entry.id),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${entry.id.substring(0, 8).toUpperCase()}',
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _customerLabel(entry),
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _money(entry.netTotal),
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (entry.hasReturns) ...[
                const SizedBox(height: AppSpacing.sm),
                _ReturnInfoStrip(entry: entry),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 15,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _dateTime(entry.createdAt),
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: status.background,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                    child: Text(
                      status.text,
                      style: textTheme.labelSmall?.copyWith(
                        color: status.color,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.hasReturns
                          ? '${_bnNumber(entry.itemCount)}টি পণ্য · ফেরত ${_bnNumber(entry.returnedItemCount)}টি'
                          : '${_bnNumber(entry.itemCount)}টি পণ্য',
                      style: textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    entry.syncStatus == 'pending'
                        ? 'সিঙ্ক বাকি'
                        : 'সার্ভারে সিঙ্কড',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReturnInfoStrip extends StatelessWidget {
  const _ReturnInfoStrip({required this.entry});

  final LocalSalesHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E8),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.assignment_return_rounded,
            size: 18,
            color: Color(0xFFDC7A37),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'ফেরত: ${_money(entry.returnRefundTotal)} · মূল বিক্রি: ${_money(entry.total)}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFFDC7A37),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
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
      color: const Color(0xFF1A9F83),
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

enum _SalesHistoryRange { day, month, year, all, custom }

bool _isInRange(
  DateTime value,
  _SalesHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  value = value.toLocal();
  if (range == _SalesHistoryRange.custom) {
    if (customRange == null) {
      return false;
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

  if (range == _SalesHistoryRange.all) {
    return true;
  }

  if (range == _SalesHistoryRange.day) {
    return value.year == anchorDate.year &&
        value.month == anchorDate.month &&
        value.day == anchorDate.day;
  }

  if (range == _SalesHistoryRange.month) {
    return value.year == anchorDate.year && value.month == anchorDate.month;
  }

  return value.year == anchorDate.year;
}

DateTime _shiftRangeDate(DateTime date, _SalesHistoryRange range, int step) {
  return switch (range) {
    _SalesHistoryRange.day => date.add(Duration(days: step)),
    _SalesHistoryRange.month => DateTime(
      date.year,
      date.month + step,
      _safeDayForMonth(date.year, date.month + step, date.day),
    ),
    _SalesHistoryRange.year => DateTime(
      date.year + step,
      date.month,
      _safeDayForMonth(date.year + step, date.month, date.day),
    ),
    _SalesHistoryRange.all => date,
    _SalesHistoryRange.custom => date,
  };
}

String _rangeLabel(
  _SalesHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  return switch (range) {
    _SalesHistoryRange.day => _dateOnly(anchorDate),
    _SalesHistoryRange.month =>
      '${_bnMonth(anchorDate.month)} ${_bnNumber(anchorDate.year)}',
    _SalesHistoryRange.year => _bnNumber(anchorDate.year),
    _SalesHistoryRange.all => 'সব সময়',
    _SalesHistoryRange.custom =>
      customRange == null
          ? 'তারিখের রেঞ্জ'
          : '${_dateOnly(customRange.start)} - ${_dateOnly(customRange.end)}',
  };
}

String _emptyMessage(
  _SalesHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  if (_isFutureRange(range, anchorDate, customRange)) {
    return switch (range) {
      _SalesHistoryRange.day =>
        'এই দিনটি এখনও আসেনি। সময় এলে বিক্রির হিস্টোরি এখানে দেখা যাবে।',
      _SalesHistoryRange.month =>
        'এই মাসটি এখনও আসেনি। সামনে ভালো বিক্রির প্রস্তুতি থাকুক।',
      _SalesHistoryRange.year =>
        'এই বছরটি এখনও আসেনি। সময় হলে নতুন বিক্রির হিস্টোরি এখানে জমা হবে।',
      _SalesHistoryRange.all => 'এখনও কোনো বিক্রির হিস্টোরি নেই',
      _SalesHistoryRange.custom =>
        'এই তারিখের রেঞ্জ এখনও আসেনি। সময় এলে হিস্টোরি এখানে দেখা যাবে।',
    };
  }

  return 'এখনও কোনো বিক্রির হিস্টোরি নেই';
}

bool _isFutureRange(
  _SalesHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final now = DateTime.now();
  return switch (range) {
    _SalesHistoryRange.day => DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    ).isAfter(DateTime(now.year, now.month, now.day)),
    _SalesHistoryRange.month => DateTime(
      anchorDate.year,
      anchorDate.month,
    ).isAfter(DateTime(now.year, now.month)),
    _SalesHistoryRange.year => anchorDate.year > now.year,
    _SalesHistoryRange.all => false,
    _SalesHistoryRange.custom =>
      customRange != null &&
          DateTime(
            customRange.start.year,
            customRange.start.month,
            customRange.start.day,
          ).isAfter(DateTime(now.year, now.month, now.day)),
  };
}

int _safeDayForMonth(int year, int month, int preferredDay) {
  final lastDay = DateTime(year, month + 1, 0).day;
  return preferredDay > lastDay ? lastDay : preferredDay;
}

String _customerLabel(LocalSalesHistoryEntry entry) {
  final phone = entry.customerPhone.trim();
  if (phone.isEmpty) {
    return entry.customerName;
  }
  return '${entry.customerName} · ${_bnNumber(phone)}';
}

String _paymentMethodText(String? method) {
  return switch (method) {
    'cash' => 'নগদ টাকা',
    'mobile_banking' => 'বিকাশ/নগদ',
    'due' => 'বাকি',
    _ => 'পরিশোধ',
  };
}

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _dateTime(DateTime value) {
  value = value.toLocal();
  final date = '${value.year}-${_two(value.month)}-${_two(value.day)}';
  final time = '${_two(value.hour)}:${_two(value.minute)}';
  return _bnNumber('$date $time');
}

String _dateOnly(DateTime value) {
  value = value.toLocal();
  return '${_bnNumber(value.day)} ${_bnMonth(value.month)} ${_bnNumber(value.year)}';
}

String _bnMonth(int month) {
  const names = [
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
  return names[month - 1];
}

String _two(int value) => value.toString().padLeft(2, '0');

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
