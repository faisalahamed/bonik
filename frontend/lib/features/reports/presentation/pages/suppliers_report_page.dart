import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/app_time.dart';

enum _SuppliersReportPeriod { day, month, year, allTime, custom }

final _suppliersPurchaseProvider =
    StreamProvider<List<LocalPurchaseHistoryEntry>>(
      (ref) =>
          ref.watch(appDatabaseProvider).watchPurchaseHistoryForCurrentShop(),
    );

final _suppliersPeriodProvider = StateProvider<_SuppliersReportPeriod>(
  (ref) => _SuppliersReportPeriod.month,
);

final _suppliersAnchorDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final _suppliersCustomDateRangeProvider = StateProvider<DateTimeRange?>(
  (ref) => null,
);

final _suppliersSearchProvider = StateProvider<String>((ref) => '');

class SuppliersReportPage extends ConsumerWidget {
  const SuppliersReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_suppliersPeriodProvider);
    final anchorDate = ref.watch(_suppliersAnchorDateProvider);
    final customRange = ref.watch(_suppliersCustomDateRangeProvider);
    final query = ref.watch(_suppliersSearchProvider).trim().toLowerCase();
    final purchases =
        ref.watch(_suppliersPurchaseProvider).valueOrNull ?? const [];
    final suppliers = _buildSupplierSummaries(
      purchases,
      period,
      anchorDate,
      customRange,
      query,
    );
    final totalAmount = suppliers.fold<double>(
      0,
      (sum, supplier) => sum + supplier.totalAmount,
    );
    final totalItems = suppliers.fold<int>(
      0,
      (sum, supplier) => sum + supplier.itemCount,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SuppliersTopBar(),
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
                    _SuppliersHeroCard(
                      totalAmount: totalAmount,
                      supplierCount: suppliers.length,
                      itemCount: totalItems,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _SuppliersDateCard(),
                    const SizedBox(height: AppSpacing.md),
                    const _SuppliersFilters(),
                    const SizedBox(height: AppSpacing.xl),
                    _SuppliersSectionHeader(count: suppliers.length),
                    const SizedBox(height: AppSpacing.md),
                    if (suppliers.isEmpty)
                      const _SuppliersEmptyCard()
                    else
                      ..._buildSupplierCards(suppliers),
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

class _SuppliersTopBar extends StatelessWidget {
  const _SuppliersTopBar();

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
                    'Supplier Report',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 20,
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

class _SuppliersFilters extends ConsumerWidget {
  const _SuppliersFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(_suppliersPeriodProvider);

    return Row(
      children: [
        Expanded(
          child: _SuppliersChip(
            label: 'দিন',
            active: selectedPeriod == _SuppliersReportPeriod.day,
            onTap: () => _selectPeriod(ref, _SuppliersReportPeriod.day),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _SuppliersChip(
            label: 'মাস',
            active: selectedPeriod == _SuppliersReportPeriod.month,
            onTap: () => _selectPeriod(ref, _SuppliersReportPeriod.month),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _SuppliersChip(
            label: 'বছর',
            active: selectedPeriod == _SuppliersReportPeriod.year,
            onTap: () => _selectPeriod(ref, _SuppliersReportPeriod.year),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _SuppliersChip(
            label: 'সব সময়',
            active: selectedPeriod == _SuppliersReportPeriod.allTime,
            onTap: () => _selectPeriod(ref, _SuppliersReportPeriod.allTime),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _SuppliersChip(
            label: 'কাস্টম',
            active: selectedPeriod == _SuppliersReportPeriod.custom,
            onTap: () => _pickCustomDateRange(context, ref),
          ),
        ),
      ],
    );
  }
}

class _SuppliersChip extends StatelessWidget {
  const _SuppliersChip({required this.label, this.active = false, this.onTap});

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

class _SuppliersDateCard extends ConsumerWidget {
  const _SuppliersDateCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(_suppliersPeriodProvider);
    final anchorDate = ref.watch(_suppliersAnchorDateProvider);
    final customRange = ref.watch(_suppliersCustomDateRangeProvider);
    final label = _rangeLabel(period, anchorDate, customRange);
    final canNavigate =
        period != _SuppliersReportPeriod.allTime &&
        period != _SuppliersReportPeriod.custom;

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

class _SuppliersHeroCard extends StatelessWidget {
  const _SuppliersHeroCard({
    required this.totalAmount,
    required this.supplierCount,
    required this.itemCount,
  });

  final double totalAmount;
  final int supplierCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        children: [
          Text(
            'মোট সরবরাহ করা হয়েছে',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            _money(totalAmount),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              _HeroPill(label: '${_bnNumber(supplierCount)} জন সাপ্লায়ার'),
              _HeroPill(label: '${_bnNumber(itemCount)} টি পণ্য'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SuppliersSectionHeader extends ConsumerWidget {
  const _SuppliersSectionHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'সামগ্রিক তালিকা',
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
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          onChanged: (value) =>
              ref.read(_suppliersSearchProvider.notifier).state = value,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'সাপ্লায়ার খুঁজুন',
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.md),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _SupplierRecordCard extends StatelessWidget {
  const _SupplierRecordCard({
    required this.indexLabel,
    required this.name,
    required this.productCount,
    required this.purchaseCount,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.statusBackground,
  });

  final String indexLabel;
  final String name;
  final String productCount;
  final String purchaseCount;
  final String amount;
  final String status;
  final Color statusColor;
  final Color statusBackground;

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
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            alignment: Alignment.center,
            child: Text(
              indexLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'সর্বমোট পণ্য: $productCount',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ক্রয়: $purchaseCount',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textMuted,
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
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
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

class _SuppliersEmptyCard extends StatelessWidget {
  const _SuppliersEmptyCard();

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
        'এই সময়সীমায় কোনো সাপ্লায়ার নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

List<Widget> _buildSupplierCards(List<_SupplierSummary> suppliers) {
  final items = <Widget>[];
  for (var i = 0; i < suppliers.length; i++) {
    final supplier = suppliers[i];
    final status = _statusStyle(supplier);
    items.add(
      _SupplierRecordCard(
        indexLabel: _bnNumber((i + 1).toString().padLeft(2, '0')),
        name: supplier.name,
        productCount: '${_bnNumber(supplier.itemCount)}টি',
        purchaseCount: '${_bnNumber(supplier.purchaseCount)}টি',
        amount: _money(supplier.totalAmount),
        status: status.text,
        statusColor: status.color,
        statusBackground: status.background,
      ),
    );
    if (i != suppliers.length - 1) {
      items.add(const SizedBox(height: AppSpacing.md));
    }
  }
  return items;
}

List<_SupplierSummary> _buildSupplierSummaries(
  List<LocalPurchaseHistoryEntry> purchases,
  _SuppliersReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
  String query,
) {
  final grouped = <String, _MutableSupplierSummary>{};

  for (final purchase in purchases) {
    if (!_isInRange(purchase.createdAt, period, anchorDate, customRange)) {
      continue;
    }
    final name = purchase.supplierName.trim().isEmpty
        ? 'সাপ্লায়ার'
        : purchase.supplierName.trim();
    final summary = grouped.putIfAbsent(
      purchase.supplierId,
      () => _MutableSupplierSummary(name: name),
    );
    summary.name = name;
    summary.totalAmount += purchase.total;
    summary.dueAmount += purchase.dueAmount;
    summary.itemCount += purchase.itemCount;
    summary.purchaseCount += 1;
    if (summary.lastPurchaseAt == null ||
        purchase.createdAt.isAfter(summary.lastPurchaseAt!)) {
      summary.lastPurchaseAt = purchase.createdAt;
    }
  }

  final suppliers =
      grouped.values
          .map(
            (summary) => _SupplierSummary(
              name: summary.name,
              totalAmount: summary.totalAmount,
              dueAmount: summary.dueAmount,
              itemCount: summary.itemCount,
              purchaseCount: summary.purchaseCount,
              lastPurchaseAt: summary.lastPurchaseAt ?? DateTime(2000),
            ),
          )
          .where((supplier) {
            if (query.isEmpty) {
              return true;
            }
            return supplier.name.toLowerCase().contains(query);
          })
          .toList()
        ..sort((a, b) {
          final amountCompare = b.totalAmount.compareTo(a.totalAmount);
          if (amountCompare != 0) {
            return amountCompare;
          }
          return b.lastPurchaseAt.compareTo(a.lastPurchaseAt);
        });

  return suppliers;
}

void _selectPeriod(WidgetRef ref, _SuppliersReportPeriod period) {
  ref.read(_suppliersPeriodProvider.notifier).state = period;
  if (period != _SuppliersReportPeriod.custom) {
    ref.read(_suppliersCustomDateRangeProvider.notifier).state = null;
  }
}

void _moveRange(WidgetRef ref, int direction) {
  final period = ref.read(_suppliersPeriodProvider);
  final anchor = ref.read(_suppliersAnchorDateProvider).toLocal();

  final next = switch (period) {
    _SuppliersReportPeriod.day => anchor.add(Duration(days: direction)),
    _SuppliersReportPeriod.month => DateTime(
      anchor.year,
      anchor.month + direction,
    ),
    _SuppliersReportPeriod.year => DateTime(
      anchor.year + direction,
      anchor.month,
    ),
    _SuppliersReportPeriod.allTime => anchor,
    _SuppliersReportPeriod.custom => anchor,
  };

  ref.read(_suppliersAnchorDateProvider.notifier).state = next;
}

Future<void> _pickCustomDateRange(BuildContext context, WidgetRef ref) async {
  final now = DateTime.now();
  final currentRange = ref.read(_suppliersCustomDateRangeProvider);
  final anchorDate = AppTime.toLocal(ref.read(_suppliersAnchorDateProvider));
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

  ref.read(_suppliersAnchorDateProvider.notifier).state = pickedRange.start;
  ref.read(_suppliersCustomDateRangeProvider.notifier).state = pickedRange;
  ref.read(_suppliersPeriodProvider.notifier).state =
      _SuppliersReportPeriod.custom;
}

bool _isInRange(
  DateTime value,
  _SuppliersReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  value = AppTime.toLocal(value);
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _SuppliersReportPeriod.day:
      return value.year == anchor.year &&
          value.month == anchor.month &&
          value.day == anchor.day;
    case _SuppliersReportPeriod.month:
      return value.year == anchor.year && value.month == anchor.month;
    case _SuppliersReportPeriod.year:
      return value.year == anchor.year;
    case _SuppliersReportPeriod.allTime:
      return true;
    case _SuppliersReportPeriod.custom:
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
  _SuppliersReportPeriod period,
  DateTime anchorDate,
  DateTimeRange? customRange,
) {
  final anchor = AppTime.toLocal(anchorDate);

  switch (period) {
    case _SuppliersReportPeriod.day:
      return _formatBanglaDate(anchor);
    case _SuppliersReportPeriod.month:
      final start = DateTime(anchor.year, anchor.month);
      final end = DateTime(anchor.year, anchor.month + 1, 0);
      return '${_formatBanglaDate(start)} - ${_formatBanglaDate(end)}';
    case _SuppliersReportPeriod.year:
      return '${_bnNumber(anchor.year)} সাল';
    case _SuppliersReportPeriod.allTime:
      return 'সব সময়';
    case _SuppliersReportPeriod.custom:
      if (customRange == null) {
        return 'কাস্টম রেঞ্জ';
      }
      return '${_formatBanglaDate(customRange.start)} - '
          '${_formatBanglaDate(customRange.end)}';
  }
}

_StatusStyle _statusStyle(_SupplierSummary supplier) {
  if (supplier.dueAmount > 0) {
    return const _StatusStyle(
      text: 'বকেয়া আছে',
      background: Color(0xFFFFE7E7),
      color: Color(0xFFD9534F),
    );
  }
  if (supplier.purchaseCount > 1) {
    return const _StatusStyle(
      text: 'নিয়মিত',
      background: Color(0xFFE4FBF6),
      color: Color(0xFF138E7A),
    );
  }
  return const _StatusStyle(
    text: 'নতুন',
    background: Color(0xFFFFF1E8),
    color: Color(0xFFDC7A37),
  );
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

class _MutableSupplierSummary {
  _MutableSupplierSummary({required this.name});

  String name;
  double totalAmount = 0;
  double dueAmount = 0;
  int itemCount = 0;
  int purchaseCount = 0;
  DateTime? lastPurchaseAt;
}

class _SupplierSummary {
  const _SupplierSummary({
    required this.name,
    required this.totalAmount,
    required this.dueAmount,
    required this.itemCount,
    required this.purchaseCount,
    required this.lastPurchaseAt,
  });

  final String name;
  final double totalAmount;
  final double dueAmount;
  final int itemCount;
  final int purchaseCount;
  final DateTime lastPurchaseAt;
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
