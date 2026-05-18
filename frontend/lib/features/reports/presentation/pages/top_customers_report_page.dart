import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _TopCustomersPeriod { day, month, year, allTime, custom }

final _topCustomersSalesProvider = StreamProvider<List<LocalSalesHistoryEntry>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesHistoryForCurrentShop(),
);

final _topCustomersPeriodProvider = StateProvider<_TopCustomersPeriod>(
  (ref) => _TopCustomersPeriod.month,
);

final _topCustomersAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _topCustomersCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _topCustomersSearchProvider = StateProvider<String>((ref) => '');

class TopCustomersReportPage extends ConsumerWidget {
  const TopCustomersReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_topCustomersPeriodProvider);
    final anchorDate = ref.watch(_topCustomersAnchorDateProvider);
    final customRange = ref.watch(_topCustomersCustomDateRangeProvider);
    final searchText = ref.watch(_topCustomersSearchProvider).trim();
    final sales = ref.watch(_topCustomersSalesProvider).valueOrNull ?? const [];
    final customers = _topCustomers(
      sales,
      period,
      anchorDate,
      customRange,
      searchText,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _TopCustomersTopBar(),
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
                    const _TopCustomersDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _TopCustomersFilters(),
                    const SizedBox(height: AppSpacing.md),
                    const _TopCustomersSearchBox(),
                    const SizedBox(height: AppSpacing.lg),
                    const _TopCustomersTableHeader(),
                    const SizedBox(height: AppSpacing.sm),
                    if (customers.isEmpty)
                      const _TopCustomersEmptyCard()
                    else
                      for (var i = 0; i < customers.length; i++) ...[
                        _TopCustomerCard(customer: customers[i]),
                        if (i != customers.length - 1)
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

class _TopCustomersTopBar extends StatelessWidget {
  const _TopCustomersTopBar();

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
                    'গ্রাহক রিপোর্ট',
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

class _TopCustomersFilters extends ConsumerWidget {
  const _TopCustomersFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_topCustomersPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _TopCustomersChip(
            label: 'দিন',
            active: selectedPeriod == _TopCustomersPeriod.day,
            onTap: () => _selectPeriod(ref, _TopCustomersPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _TopCustomersChip(
            label: 'মাস',
            active: selectedPeriod == _TopCustomersPeriod.month,
            onTap: () => _selectPeriod(ref, _TopCustomersPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _TopCustomersChip(
            label: 'বছর',
            active: selectedPeriod == _TopCustomersPeriod.year,
            onTap: () => _selectPeriod(ref, _TopCustomersPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _TopCustomersChip(
            label: 'সব সময়',
            active: selectedPeriod == _TopCustomersPeriod.allTime,
            onTap: () => _selectPeriod(ref, _TopCustomersPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _TopCustomersChip(
            label: 'কাস্টম',
            active: selectedPeriod == _TopCustomersPeriod.custom,
            onTap: () => _pickCustomDateRange(context, ref),
          ),
        ),
      ],
    );
  }
}

class _TopCustomersChip extends StatelessWidget {
  const _TopCustomersChip({
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

class _TopCustomersDateCard extends ConsumerWidget {
  const _TopCustomersDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_topCustomersPeriodProvider);
    final anchorDate = ref.watch(_topCustomersAnchorDateProvider);
    final customRange = ref.watch(_topCustomersCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _TopCustomersPeriod.allTime &&
        period != _TopCustomersPeriod.custom;

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

class _TopCustomersSearchBox extends ConsumerWidget {
  const _TopCustomersSearchBox();

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
            ref.read(_topCustomersSearchProvider.notifier).state = value,
        decoration: const InputDecoration(
          hintText: 'খুঁজুন (নাম, মোবাইল)',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _TopCustomersTableHeader extends StatelessWidget {
  const _TopCustomersTableHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'গ্রাহক',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'মোবাইল/\nতারিখ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'মোট ক্রয়',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCustomerCard extends StatelessWidget {
  const _TopCustomerCard({required this.customer});

  final _TopCustomerEntry customer;

  @override
  Widget build(BuildContext context) {
    final hasDue = customer.dueAmount > 0;
    final tagText = hasDue
        ? 'বকেয়া আছে'
        : customer.saleCount > 1
        ? 'নিয়মিত গ্রাহক'
        : null;
    final tagColor = hasDue ? const Color(0xFFD9534F) : AppColors.primary;
    final tagBackground = hasDue
        ? const Color(0xFFFFE7E7)
        : const Color(0xFFE4FBF6);

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
            height: 98,
            decoration: BoxDecoration(
              color: hasDue ? const Color(0xFFF3B3B3) : const Color(0xFF9EDFD5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.xl),
                bottomLeft: Radius.circular(AppRadii.xl),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF91EFE6),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _initial(customer.name),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        if (tagText != null) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tagBackground,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              tagText,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: tagColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          customer.phone.isEmpty
                              ? '—'
                              : _bnNumber(customer.phone),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _shortDate(customer.lastPurchaseAt),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _money(customer.totalAmount),
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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

class _TopCustomersEmptyCard extends StatelessWidget {
  const _TopCustomersEmptyCard();

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
        'এই সময়সীমায় কোনো গ্রাহক নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<_TopCustomerEntry> _topCustomers(
  List<LocalSalesHistoryEntry> sales,
  _TopCustomersPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
  String searchText,
) {
  final byCustomer = <String, _TopCustomerEntry>{};
  for (final sale in sales) {
    if (!_isInRange(sale.createdAt, period, anchorDate, customRange)) {
      continue;
    }

    final existing = byCustomer[sale.customerId];
    if (existing == null) {
      byCustomer[sale.customerId] = _TopCustomerEntry(
        id: sale.customerId,
        name: sale.customerName,
        phone: sale.customerPhone,
        totalAmount: sale.netTotal,
        dueAmount: sale.dueAmount,
        saleCount: 1,
        lastPurchaseAt: AppTime.toLocal(sale.createdAt),
      );
    } else {
      byCustomer[sale.customerId] = existing.copyWith(
        totalAmount: existing.totalAmount + sale.netTotal,
        dueAmount: existing.dueAmount + sale.dueAmount,
        saleCount: existing.saleCount + 1,
        lastPurchaseAt: sale.createdAt.isAfter(existing.lastPurchaseAt)
            ? AppTime.toLocal(sale.createdAt)
            : existing.lastPurchaseAt,
      );
    }
  }

  final query = searchText.toLowerCase();
  final entries = byCustomer.values.where((entry) {
    if (query.isEmpty) {
      return true;
    }
    return entry.name.toLowerCase().contains(query) ||
        entry.phone.toLowerCase().contains(query);
  }).toList();
  entries.sort((a, b) {
    final amountCompare = b.totalAmount.compareTo(a.totalAmount);
    if (amountCompare != 0) {
      return amountCompare;
    }
    return b.lastPurchaseAt.compareTo(a.lastPurchaseAt);
  });
  return entries;
}

void _selectPeriod(WidgetRef ref, _TopCustomersPeriod period) {
  ref.read(_topCustomersPeriodProvider.notifier).state = period;
  if (period != _TopCustomersPeriod.custom) {
    ref.read(_topCustomersCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_topCustomersPeriodProvider);
  final anchor = ref.read(_topCustomersAnchorDateProvider).toLocal();

  final next = switch (period) {
    _TopCustomersPeriod.day => anchor.add(Duration(days: direction)),
    _TopCustomersPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _TopCustomersPeriod.year => DateTime(anchor.year + direction, anchor.month),
    _TopCustomersPeriod.allTime => anchor,
    _TopCustomersPeriod.custom => anchor,
  };

  ref.read(_topCustomersAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_topCustomersCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(ref.read(_topCustomersAnchorDateProvider));
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

  ref.read(_topCustomersAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_topCustomersCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_topCustomersPeriodProvider.notifier).state =
      _TopCustomersPeriod.custom;
}

bool _isInRange(
  DateTime value,
  _TopCustomersPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  value = AppTime.toLocal(value);
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _TopCustomersPeriod.day:
      return value.year == anchor.year &&
          value.month == anchor.month &&
          value.day == anchor.day;
    case _TopCustomersPeriod.month:
      return value.year == anchor.year && value.month == anchor.month;
    case _TopCustomersPeriod.year:
      return value.year == anchor.year;
    case _TopCustomersPeriod.allTime:
      return true;
    case _TopCustomersPeriod.custom:
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
  _TopCustomersPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _TopCustomersPeriod.day:
      return _formatBanglaDate(anchor);
    case _TopCustomersPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _TopCustomersPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _TopCustomersPeriod.allTime:
      return 'সব সময়';
    case _TopCustomersPeriod.custom:
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

String _shortDate(DateTime date) {
  return '${_bnNumber(date.day.toString().padLeft(2, '0'))} '
      '${_banglaMonths[date.month - 1]}';
}

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _initial(String value) {
  final text = value.trim();
  if (text.isEmpty) {
    return '?';
  }
  return String.fromCharCode(text.runes.first);
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

class _TopCustomerEntry {
  const _TopCustomerEntry({
    required this.id,
    required this.name,
    required this.phone,
    required this.totalAmount,
    required this.dueAmount,
    required this.saleCount,
    required this.lastPurchaseAt,
  });

  final String id;
  final String name;
  final String phone;
  final double totalAmount;
  final double dueAmount;
  final int saleCount;
  final DateTime lastPurchaseAt;

  _TopCustomerEntry copyWith({
    double? totalAmount,
    double? dueAmount,
    int? saleCount,
    DateTime? lastPurchaseAt,
  }) {
    return _TopCustomerEntry(
      id: id,
      name: name,
      phone: phone,
      totalAmount: totalAmount ?? this.totalAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      saleCount: saleCount ?? this.saleCount,
      lastPurchaseAt: lastPurchaseAt ?? this.lastPurchaseAt,
    );
  }
}
