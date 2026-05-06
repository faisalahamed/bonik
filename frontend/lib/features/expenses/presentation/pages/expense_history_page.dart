import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _expenseHistoryProvider = StreamProvider<List<LocalExpenseHistoryEntry>>(
  (ref) => ref.watch(appDatabaseProvider).watchExpenseHistoryForCurrentShop(),
);

class ExpenseHistoryPage extends ConsumerStatefulWidget {
  const ExpenseHistoryPage({super.key});

  @override
  ConsumerState<ExpenseHistoryPage> createState() => _ExpenseHistoryPageState();
}

class _ExpenseHistoryPageState extends ConsumerState<ExpenseHistoryPage> {
  var _selectedRange = _ExpenseHistoryRange.day;
  var _rangeAnchorDate = DateTime.now();
  DateTimeRange? _customDateRange;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(_expenseHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ExpenseHistoryTopBar(),
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
                  data: (entries) => _ExpenseHistoryList(
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
                  error: (error, stackTrace) => _ExpenseHistoryList(
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
                    message: 'ব্যয়ের ডাটা পাওয়া যায়নি',
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
    if (_selectedRange == _ExpenseHistoryRange.all ||
        _selectedRange == _ExpenseHistoryRange.custom) {
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
      _selectedRange = _ExpenseHistoryRange.custom;
      _customDateRange = selected;
      _rangeAnchorDate = selected.start;
    });
  }
}

class _ExpenseHistoryTopBar extends StatelessWidget {
  const _ExpenseHistoryTopBar();

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
                    'ব্যয় বিবরণী',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(Icons.receipt_long_rounded, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpenseHistoryList extends StatelessWidget {
  const _ExpenseHistoryList({
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

  final List<LocalExpenseHistoryEntry> entries;
  final _ExpenseHistoryRange selectedRange;
  final DateTime rangeAnchorDate;
  final DateTimeRange? customDateRange;
  final ValueChanged<_ExpenseHistoryRange> onRangeSelected;
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
      (sum, entry) => sum + entry.amount,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      children: [
        _ExpenseHeroCard(
          total: total,
          count: filteredEntries.length,
          rangeLabel: _rangeLabel(
            selectedRange,
            rangeAnchorDate,
            customDateRange,
          ),
          canNavigate:
              selectedRange != _ExpenseHistoryRange.all &&
              selectedRange != _ExpenseHistoryRange.custom,
          onPrevious: onPreviousRange,
          onNext: onNextRange,
        ),
        const SizedBox(height: AppSpacing.md),
        _ExpenseFilterTabs(
          selectedRange: selectedRange,
          onRangeSelected: onRangeSelected,
          onCustomRangeSelected: onCustomRangeSelected,
        ),
        const SizedBox(height: AppSpacing.lg),
        const _RecentExpenseHeader(),
        const SizedBox(height: AppSpacing.md),
        if (message != null)
          _ExpenseEmptyCard(message: message!)
        else if (filteredEntries.isEmpty)
          _ExpenseEmptyCard(
            message: _emptyMessage(
              selectedRange,
              rangeAnchorDate,
              customDateRange,
            ),
          )
        else
          for (var i = 0; i < filteredEntries.length; i++) ...[
            _ExpenseHistoryItemCard(entry: filteredEntries[i]),
            if (i != filteredEntries.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
      ],
    );
  }
}

class _ExpenseHeroCard extends StatelessWidget {
  const _ExpenseHeroCard({
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
                      'মোট ব্যয়',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _money(total),
                      textAlign: TextAlign.center,
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
            '${_banglaNumber(count.toString())}টি ব্যয়ের রেকর্ড',
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

class _ExpenseFilterTabs extends StatelessWidget {
  const _ExpenseFilterTabs({
    required this.selectedRange,
    required this.onRangeSelected,
    required this.onCustomRangeSelected,
  });

  final _ExpenseHistoryRange selectedRange;
  final ValueChanged<_ExpenseHistoryRange> onRangeSelected;
  final VoidCallback onCustomRangeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterChip(
            label: 'দিন',
            active: selectedRange == _ExpenseHistoryRange.day,
            onTap: () => onRangeSelected(_ExpenseHistoryRange.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'মাস',
            active: selectedRange == _ExpenseHistoryRange.month,
            onTap: () => onRangeSelected(_ExpenseHistoryRange.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'বছর',
            active: selectedRange == _ExpenseHistoryRange.year,
            onTap: () => onRangeSelected(_ExpenseHistoryRange.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FilterChip(
            label: 'সব',
            active: selectedRange == _ExpenseHistoryRange.all,
            onTap: () => onRangeSelected(_ExpenseHistoryRange.all),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SortChip(
          active: selectedRange == _ExpenseHistoryRange.custom,
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
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: active ? AppGradients.primaryButton : null,
            color: active ? null : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Icon(
            Icons.date_range_rounded,
            color: active ? Colors.white : AppColors.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _RecentExpenseHeader extends StatelessWidget {
  const _RecentExpenseHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'সাম্প্রতিক ব্যয়',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ExpenseHistoryItemCard extends StatelessWidget {
  const _ExpenseHistoryItemCard({required this.entry});

  final LocalExpenseHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitle = [
      entry.reason,
      entry.note,
    ].where((value) => value != null && value.trim().isNotEmpty).join(' • ');

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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F6EF),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(Icons.payments_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.categoryName,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  _dateTime(entry.createdAt),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                _SyncBadge(syncStatus: entry.syncStatus),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            _money(entry.amount),
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncBadge extends StatelessWidget {
  const _SyncBadge({required this.syncStatus});

  final String syncStatus;

  @override
  Widget build(BuildContext context) {
    final synced = syncStatus == 'synced';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: synced ? const Color(0xFFE6F7EF) : const Color(0xFFFFF4DD),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        synced ? 'সিঙ্ক হয়েছে' : 'সিঙ্ক বাকি',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: synced ? AppColors.primary : const Color(0xFF9A6500),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ExpenseEmptyCard extends StatelessWidget {
  const _ExpenseEmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.lg),
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

String _money(double value) {
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
  return '৳ ${_banglaNumber(fixed)}';
}

String _dateTime(DateTime value) {
  value = value.toLocal();
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  final date =
      '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  return _banglaNumber('$date | $hour:$minute');
}

enum _ExpenseHistoryRange { day, month, year, all, custom }

bool _isInRange(
  DateTime date,
  _ExpenseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customDateRange,
) {
  date = date.toLocal();
  if (range == _ExpenseHistoryRange.custom) {
    if (customDateRange == null) {
      return true;
    }

    final start = DateTime(
      customDateRange.start.year,
      customDateRange.start.month,
      customDateRange.start.day,
    );
    final end = DateTime(
      customDateRange.end.year,
      customDateRange.end.month,
      customDateRange.end.day,
    ).add(const Duration(days: 1));

    return !date.isBefore(start) && date.isBefore(end);
  }

  if (range == _ExpenseHistoryRange.all) {
    return true;
  }

  if (range == _ExpenseHistoryRange.day) {
    return date.year == anchorDate.year &&
        date.month == anchorDate.month &&
        date.day == anchorDate.day;
  }

  if (range == _ExpenseHistoryRange.month) {
    return date.year == anchorDate.year && date.month == anchorDate.month;
  }

  return date.year == anchorDate.year;
}

DateTime _shiftRangeDate(DateTime date, _ExpenseHistoryRange range, int step) {
  return switch (range) {
    _ExpenseHistoryRange.day => date.add(Duration(days: step)),
    _ExpenseHistoryRange.month => DateTime(date.year, date.month + step, 1),
    _ExpenseHistoryRange.year => DateTime(date.year + step, 1, 1),
    _ExpenseHistoryRange.all => date,
    _ExpenseHistoryRange.custom => date,
  };
}

String _rangeLabel(
  _ExpenseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customDateRange,
) {
  return switch (range) {
    _ExpenseHistoryRange.day => _dateOnly(anchorDate),
    _ExpenseHistoryRange.month =>
      '${_monthName(anchorDate.month)} ${_banglaNumber(anchorDate.year.toString())}',
    _ExpenseHistoryRange.year => _banglaNumber(anchorDate.year.toString()),
    _ExpenseHistoryRange.all => 'সব সময়',
    _ExpenseHistoryRange.custom =>
      customDateRange == null
          ? 'কাস্টম রেঞ্জ'
          : '${_dateOnly(customDateRange.start)} - ${_dateOnly(customDateRange.end)}',
  };
}

String _emptyMessage(
  _ExpenseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customDateRange,
) {
  if (_isFutureRange(range, anchorDate, customDateRange)) {
    return 'এই সময়টা এখনো আসেনি, তাই ব্যয় নেই';
  }

  return switch (range) {
    _ExpenseHistoryRange.day => 'এই দিনে কোনো ব্যয় নেই',
    _ExpenseHistoryRange.month => 'এই মাসে কোনো ব্যয় নেই',
    _ExpenseHistoryRange.year => 'এই বছরে কোনো ব্যয় নেই',
    _ExpenseHistoryRange.all => 'এখনো কোনো ব্যয় যোগ করা হয়নি',
    _ExpenseHistoryRange.custom => 'এই তারিখের রেঞ্জে কোনো ব্যয় নেই',
  };
}

bool _isFutureRange(
  _ExpenseHistoryRange range,
  DateTime anchorDate,
  DateTimeRange? customDateRange,
) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return switch (range) {
    _ExpenseHistoryRange.day => DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    ).isAfter(today),
    _ExpenseHistoryRange.month => DateTime(
      anchorDate.year,
      anchorDate.month,
    ).isAfter(DateTime(now.year, now.month)),
    _ExpenseHistoryRange.year => anchorDate.year > now.year,
    _ExpenseHistoryRange.all => false,
    _ExpenseHistoryRange.custom =>
      customDateRange != null &&
          DateTime(
            customDateRange.start.year,
            customDateRange.start.month,
            customDateRange.start.day,
          ).isAfter(today),
  };
}

String _dateOnly(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return _banglaNumber('$day/$month/${value.year}');
}

String _monthName(int month) {
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

String _banglaNumber(String value) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

  var result = value;
  for (var i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], bangla[i]);
  }
  return result;
}
