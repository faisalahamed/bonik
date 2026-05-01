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

final _purchaseHistoryProvider =
    StreamProvider<List<LocalPurchaseHistoryEntry>>(
      (ref) =>
          ref.watch(appDatabaseProvider).watchPurchaseHistoryForCurrentShop(),
    );

class PurchaseHistoryPage extends ConsumerStatefulWidget {
  const PurchaseHistoryPage({super.key});

  @override
  ConsumerState<PurchaseHistoryPage> createState() =>
      _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends ConsumerState<PurchaseHistoryPage> {
  var _selectedRange = _PurchaseHistoryRange.day;
  var _rangeAnchorDate = DateTime.now();
  DateTimeRange? _customDateRange;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(_purchaseHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _PurchaseHistoryTopBar(),
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
                  data: (entries) => _PurchaseHistoryList(
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
                  error: (error, stackTrace) => _PurchaseHistoryList(
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
                    message: 'কেনার ডাটা পাওয়া যায়নি',
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
    if (_selectedRange == _PurchaseHistoryRange.all ||
        _selectedRange == _PurchaseHistoryRange.custom) {
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
      _selectedRange = _PurchaseHistoryRange.custom;
      _customDateRange = selected;
      _rangeAnchorDate = selected.start;
    });
  }
}

class _PurchaseHistoryTopBar extends StatelessWidget {
  const _PurchaseHistoryTopBar();

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
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'কেনা খাতা',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
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

class _PurchaseHistoryList extends StatelessWidget {
  const _PurchaseHistoryList({
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

  final List<LocalPurchaseHistoryEntry> entries;
  final _PurchaseHistoryRange selectedRange;
  final DateTime rangeAnchorDate;
  final DateTimeRange? customDateRange;
  final ValueChanged<_PurchaseHistoryRange> onRangeSelected;
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
      (sum, entry) => sum + entry.total,
    );

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      itemCount: filteredEntries.isEmpty ? 4 : filteredEntries.length + 3,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _PurchaseHeroCard(
            total: total,
            count: filteredEntries.length,
            rangeLabel: _rangeLabel(
              selectedRange,
              rangeAnchorDate,
              customDateRange,
            ),
            canNavigate:
                selectedRange != _PurchaseHistoryRange.all &&
                selectedRange != _PurchaseHistoryRange.custom,
            onPrevious: onPreviousRange,
            onNext: onNextRange,
          );
        }
        if (index == 1) {
          return _PurchaseFilterTabs(
            selectedRange: selectedRange,
            onRangeSelected: onRangeSelected,
            onCustomRangeSelected: onCustomRangeSelected,
          );
        }
        if (index == 2) {
          return const _PurchaseSearchBox();
        }
        if (index == 3 && filteredEntries.isEmpty) {
          return _EmptyHistoryCard(
            message:
                message ??
                _emptyMessage(selectedRange, rangeAnchorDate, customDateRange),
          );
        }

        return _HistoryItemCard(entry: filteredEntries[index - 3]);
      },
    );
  }
}

class _PurchaseHeroCard extends StatelessWidget {
  const _PurchaseHeroCard({
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
                      'মোট কেনা',
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
            '${_bnNumber(count)}টি কেনার রেকর্ড',
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

class _PurchaseFilterTabs extends StatelessWidget {
  const _PurchaseFilterTabs({
    required this.selectedRange,
    required this.onRangeSelected,
    required this.onCustomRangeSelected,
  });

  final _PurchaseHistoryRange selectedRange;
  final ValueChanged<_PurchaseHistoryRange> onRangeSelected;
  final VoidCallback onCustomRangeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterChip(
            label: 'দিন',
            active: selectedRange == _PurchaseHistoryRange.day,
            onTap: () => onRangeSelected(_PurchaseHistoryRange.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'মাস',
            active: selectedRange == _PurchaseHistoryRange.month,
            onTap: () => onRangeSelected(_PurchaseHistoryRange.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'বছর',
            active: selectedRange == _PurchaseHistoryRange.year,
            onTap: () => onRangeSelected(_PurchaseHistoryRange.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'সব',
            active: selectedRange == _PurchaseHistoryRange.all,
            onTap: () => onRangeSelected(_PurchaseHistoryRange.all),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SortChip(
          active: selectedRange == _PurchaseHistoryRange.custom,
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

class _PurchaseSearchBox extends StatelessWidget {
  const _PurchaseSearchBox();

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
          hintText: 'অনুসন্ধান করুন (সাপ্লায়ার, রিসিপ্ট)',
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

class _EmptyHistoryCard extends StatelessWidget {
  const _EmptyHistoryCard({required this.message});

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

class _HistoryItemCard extends StatelessWidget {
  const _HistoryItemCard({required this.entry});

  final LocalPurchaseHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final status = _statusStyle(entry);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () =>
            context.push(AppRoutes.purchaseHistoryDetails, extra: entry.id),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 112,
                decoration: BoxDecoration(
                  color: entry.syncStatus == 'pending'
                      ? const Color(0xFFE59B9B)
                      : AppColors.secondary,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
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
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            entry.supplierName,
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          _money(entry.total),
                          style: textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled_rounded,
                          size: 14,
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
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.secondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  '${_bnNumber(entry.itemCount)}টি পণ্য',
                                  style: textTheme.labelMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w700,
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
                    const SizedBox(height: AppSpacing.xs),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        entry.syncStatus == 'pending'
                            ? 'সিঙ্ক বাকি'
                            : 'সার্ভারে সিঙ্কড',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_StatusStyle _statusStyle(LocalPurchaseHistoryEntry entry) {
  if (entry.dueAmount <= 0) {
    return const _StatusStyle(
      text: 'সম্পূর্ণ পরিশোধ',
      background: Color(0xFFEAF3FF),
      color: Color(0xFF2C66BE),
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
    background: Color(0xFFFFEFEF),
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

enum _PurchaseHistoryRange { day, month, year, all, custom }

bool _isInRange(
  DateTime value,
  _PurchaseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  if (range == _PurchaseHistoryRange.custom) {
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

  if (range == _PurchaseHistoryRange.all) {
    return true;
  }

  if (range == _PurchaseHistoryRange.day) {
    return value.year == anchorDate.year &&
        value.month == anchorDate.month &&
        value.day == anchorDate.day;
  }

  if (range == _PurchaseHistoryRange.month) {
    return value.year == anchorDate.year && value.month == anchorDate.month;
  }

  return value.year == anchorDate.year;
}

DateTime _shiftRangeDate(DateTime date, _PurchaseHistoryRange range, int step) {
  return switch (range) {
    _PurchaseHistoryRange.day => date.add(Duration(days: step)),
    _PurchaseHistoryRange.month => DateTime(
      date.year,
      date.month + step,
      _safeDayForMonth(date.year, date.month + step, date.day),
    ),
    _PurchaseHistoryRange.year => DateTime(
      date.year + step,
      date.month,
      _safeDayForMonth(date.year + step, date.month, date.day),
    ),
    _PurchaseHistoryRange.all => date,
    _PurchaseHistoryRange.custom => date,
  };
}

String _rangeLabel(
  _PurchaseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  return switch (range) {
    _PurchaseHistoryRange.day => _dateOnly(anchorDate),
    _PurchaseHistoryRange.month =>
      '${_bnMonth(anchorDate.month)} ${_bnNumber(anchorDate.year)}',
    _PurchaseHistoryRange.year => _bnNumber(anchorDate.year),
    _PurchaseHistoryRange.all => 'সব সময়',
    _PurchaseHistoryRange.custom =>
      customRange == null
          ? 'তারিখের রেঞ্জ'
          : '${_dateOnly(customRange.start)} - ${_dateOnly(customRange.end)}',
  };
}

String _emptyMessage(
  _PurchaseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  if (_isFutureRange(range, anchorDate, customRange)) {
    return switch (range) {
      _PurchaseHistoryRange.day =>
        'এই দিনটি এখনও আসেনি। পরিকল্পনা প্রস্তুত রাখুন, সময় এলে কেনার হিস্টোরি এখানে দেখা যাবে।',
      _PurchaseHistoryRange.month =>
        'এই মাসটি এখনও আসেনি। সামনে ভালো কেনাবেচার প্রস্তুতি থাকুক।',
      _PurchaseHistoryRange.year =>
        'এই বছরটি এখনও আসেনি। নতুন বছরের হিস্টোরি সময় হলে এখানে জমা হবে।',
      _PurchaseHistoryRange.all => 'এখনও কোনো কেনার হিস্টোরি নেই',
      _PurchaseHistoryRange.custom =>
        'এই তারিখের রেঞ্জ এখনও আসেনি। সময় এলে হিস্টোরি এখানে দেখা যাবে।',
    };
  }

  return 'এখনও কোনো কেনার হিস্টোরি নেই';
}

bool _isFutureRange(
  _PurchaseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final now = DateTime.now();
  return switch (range) {
    _PurchaseHistoryRange.day => DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    ).isAfter(DateTime(now.year, now.month, now.day)),
    _PurchaseHistoryRange.month => DateTime(
      anchorDate.year,
      anchorDate.month,
    ).isAfter(DateTime(now.year, now.month)),
    _PurchaseHistoryRange.year => anchorDate.year > now.year,
    _PurchaseHistoryRange.all => false,
    _PurchaseHistoryRange.custom =>
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

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _dateTime(DateTime value) {
  final date = '${value.year}-${_two(value.month)}-${_two(value.day)}';
  final time = '${_two(value.hour)}:${_two(value.minute)}';
  return _bnNumber('$date $time');
}

String _dateOnly(DateTime value) {
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
