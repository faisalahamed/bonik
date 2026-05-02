import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _saleProvider = StreamProvider.family<LocalSale?, String>(
  (ref, id) => ref.watch(appDatabaseProvider).watchSaleById(id),
);

final _saleItemsProvider =
    StreamProvider.family<List<LocalSaleItemDetail>, String>(
      (ref, id) => ref.watch(appDatabaseProvider).watchSaleItemDetails(id),
    );

final _salePaymentsProvider =
    StreamProvider.family<List<LocalCustomerPayment>, String>(
      (ref, id) => ref.watch(appDatabaseProvider).watchCustomerPayments(id),
    );

final _customerProvider = StreamProvider.family<LocalCustomer?, String>(
  (ref, id) => ref.watch(appDatabaseProvider).watchCustomerById(id),
);

class SalesHistoryDetailsPage extends ConsumerWidget {
  const SalesHistoryDetailsPage({super.key, required this.saleId});

  final String? saleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = saleId;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SalesDetailsTopBar(),
          Expanded(
            child: Stack(
              children: [
                const _BackgroundGlow(),
                if (id == null || id.isEmpty)
                  const _CenteredMessage(message: 'বিক্রির তথ্য পাওয়া যায়নি')
                else
                  ref
                      .watch(_saleProvider(id))
                      .when(
                        data: (sale) {
                          if (sale == null) {
                            return const _CenteredMessage(
                              message: 'বিক্রির তথ্য পাওয়া যায়নি',
                            );
                          }

                          final customer = ref.watch(
                            _customerProvider(sale.customerId),
                          );
                          final items = ref.watch(_saleItemsProvider(id));
                          final payments = ref.watch(_salePaymentsProvider(id));

                          return _DetailsContent(
                            sale: sale,
                            customer: customer.valueOrNull,
                            items: items.valueOrNull ?? const [],
                            payments: payments.valueOrNull ?? const [],
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => const _CenteredMessage(
                          message: 'বিক্রির তথ্য লোড করা যায়নি',
                        ),
                      ),
                const _BottomActionBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -90,
          right: -80,
          child: Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              gradient: AppGradients.backgroundGlowTop,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -80,
          child: Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              gradient: AppGradients.backgroundGlowBottom,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({
    required this.sale,
    required this.customer,
    required this.items,
    required this.payments,
  });

  final LocalSale sale;
  final LocalCustomer? customer;
  final List<LocalSaleItemDetail> items;
  final List<LocalCustomerPayment> payments;

  @override
  Widget build(BuildContext context) {
    final paidAmount = payments.fold<double>(
      0,
      (sum, payment) => sum + payment.payments,
    );
    final dueAmount = sale.total - paidAmount;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        96,
      ),
      children: [
        _SaleSummaryCard(sale: sale),
        const SizedBox(height: AppSpacing.md),
        _CustomerCard(customer: customer),
        const SizedBox(height: AppSpacing.md),
        _SoldProductsCard(items: items),
        const SizedBox(height: AppSpacing.md),
        _SummaryCard(sale: sale, paidAmount: paidAmount, dueAmount: dueAmount),
        const SizedBox(height: AppSpacing.md),
        _PaymentInfoCard(payments: payments, paymentMethod: sale.paymentMethod),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _SalesDetailsTopBar extends StatelessWidget {
  const _SalesDetailsTopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Text(
                  'লেনদেন বিবরণী',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaleSummaryCard extends StatelessWidget {
  const _SaleSummaryCard({required this.sale});

  final LocalSale sale;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'রিসিপ্ট আইডি',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${sale.id.substring(0, 8).toUpperCase()}',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 15,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _dateTime(sale.createdAt),
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'মোট মূল্য',
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _money(sale.total),
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                sale.syncStatus == 'pending' ? 'সিঙ্ক বাকি' : 'সিঙ্কড',
                style: textTheme.labelSmall?.copyWith(
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

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.customer});

  final LocalCustomer? customer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final details = _customerDetails(customer);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFE7F6F1), Color(0xFFCCECDC)],
              ),
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer?.name ?? 'Walk-in Customer',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SoldProductsCard extends StatelessWidget {
  const _SoldProductsCard({required this.items});

  final List<LocalSaleItemDetail> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                _SectionAccent(),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'বিক্রিত পণ্য',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const _SoldTableHeader(),
          const Divider(height: 1, color: AppColors.surfaceContainerHigh),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('কোনো পণ্য পাওয়া যায়নি'),
            )
          else
            for (var i = 0; i < items.length; i++) ...[
              _SoldItemRow(item: items[i]),
              if (i != items.length - 1)
                const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            ],
        ],
      ),
    );
  }
}

class _SectionAccent extends StatelessWidget {
  const _SectionAccent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _SoldTableHeader extends StatelessWidget {
  const _SoldTableHeader();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: AppColors.textMuted,
      fontWeight: FontWeight.w800,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('পণ্যের\nনাম', style: style)),
          Expanded(flex: 2, child: Text('পরিমাণ', style: style)),
          Expanded(flex: 2, child: Text('একক মূল্য', style: style)),
          Expanded(
            flex: 3,
            child: Text('মোট মূল্য', style: style, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class _SoldItemRow extends StatelessWidget {
  const _SoldItemRow({required this.item});

  final LocalSaleItemDetail item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (item.description?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.description!.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'x${_bnNumber(item.quantity)}',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _money(item.salePrice),
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              _money(item.price),
              textAlign: TextAlign.right,
              style: textTheme.titleMedium?.copyWith(
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.sale,
    required this.paidAmount,
    required this.dueAmount,
  });

  final LocalSale sale;
  final double paidAmount;
  final double dueAmount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _SummaryRow(
            label: 'সাবটোটাল',
            value: _money(sale.subtotal),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'ভ্যাট',
            value: _money(sale.vat),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'ডিসকাউন্ট',
            value: '- ${_money(sale.discount)}',
            textTheme: textTheme,
            valueColor: const Color(0xFFD9534F),
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'পরিশোধ',
            value: _money(paidAmount),
            textTheme: textTheme,
            valueColor: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'বাকি',
            value: _money(dueAmount < 0 ? 0 : dueAmount),
            textTheme: textTheme,
            valueColor: dueAmount > 0 ? const Color(0xFFD9534F) : null,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: dueAmount > 0
                      ? const Color(0xFFFFE7E6)
                      : const Color(0xFFE4FBF6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  dueAmount > 0 ? 'বাকি আছে' : 'পরিশোধ হয়েছে',
                  style: textTheme.labelMedium?.copyWith(
                    color: dueAmount > 0
                        ? const Color(0xFFD9534F)
                        : const Color(0xFF1A9F83),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'সর্বমোট',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _money(sale.total),
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.textTheme,
    this.valueColor,
  });

  final String label;
  final String value;
  final TextTheme textTheme;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            color: valueColor ?? AppColors.textSecondary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PaymentInfoCard extends StatelessWidget {
  const _PaymentInfoCard({required this.payments, required this.paymentMethod});

  final List<LocalCustomerPayment> payments;
  final String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    final totalPaid = payments.fold<double>(
      0,
      (sum, payment) => sum + payment.payments,
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFD7EEE6),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _paymentMethodText(paymentMethod),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _money(totalPaid),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_rounded,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    'রিপোর্ট শেয়ার',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryButton,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  boxShadow: AppShadows.button,
                ),
                child: SizedBox(
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                    ),
                    icon: const Icon(Icons.print_rounded),
                    label: Text(
                      'রিপোর্ট প্রিন্ট করুন',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(AppRadii.xl),
    boxShadow: AppShadows.soft,
  );
}

String _customerDetails(LocalCustomer? customer) {
  final parts = [
    customer?.phone == null || customer!.phone!.trim().isEmpty
        ? null
        : 'ফোন: ${_bnNumber(customer.phone!)}',
    customer?.email,
    customer?.address,
    customer?.notes,
  ].where((value) => value != null && value.trim().isNotEmpty).toList();

  if (parts.isEmpty) {
    return 'যোগাযোগের তথ্য নেই';
  }

  return parts.join('\n');
}

String _paymentMethodText(String? method) {
  return switch (method) {
    'cash' => 'নগদ টাকা',
    'mobile_banking' => 'বিকাশ/নগদ',
    'due' => 'বাকি',
    _ => 'পেমেন্ট তথ্য',
  };
}

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _dateTime(DateTime value) {
  final hour12 = value.hour % 12 == 0 ? 12 : value.hour % 12;
  final minute = value.minute.toString().padLeft(2, '0');
  final period = value.hour >= 12 ? 'PM' : 'AM';
  return '${_bnNumber(value.day)} ${_bnMonth(value.month)}, ${_bnNumber(value.year)} | ${_bnNumber(hour12)}:${_bnNumber(minute)} $period';
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

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
