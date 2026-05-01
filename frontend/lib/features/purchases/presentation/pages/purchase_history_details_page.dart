import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _purchaseProvider = StreamProvider.family<LocalPurchase?, String>(
  (ref, id) => ref.watch(appDatabaseProvider).watchPurchaseById(id),
);

final _purchaseItemsProvider =
    StreamProvider.family<List<LocalPurchaseItem>, String>(
      (ref, id) => ref.watch(appDatabaseProvider).watchPurchaseItems(id),
    );

final _purchasePaymentsProvider =
    StreamProvider.family<List<LocalPurchasePayment>, String>(
      (ref, id) => ref.watch(appDatabaseProvider).watchPurchasePayments(id),
    );

final _supplierProvider = StreamProvider.family<LocalSupplier?, String>(
  (ref, id) => ref.watch(appDatabaseProvider).watchSupplierById(id),
);

class PurchaseHistoryDetailsPage extends ConsumerWidget {
  const PurchaseHistoryDetailsPage({super.key, required this.purchaseId});

  final String? purchaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = purchaseId;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _HistoryDetailsTopBar(),
          Expanded(
            child: Stack(
              children: [
                const _BackgroundGlow(),
                if (id == null || id.isEmpty)
                  const _CenteredMessage(message: 'ক্রয়ের তথ্য পাওয়া যায়নি')
                else
                  ref
                      .watch(_purchaseProvider(id))
                      .when(
                        data: (purchase) {
                          if (purchase == null) {
                            return const _CenteredMessage(
                              message: 'ক্রয়ের তথ্য পাওয়া যায়নি',
                            );
                          }

                          final supplier = ref.watch(
                            _supplierProvider(purchase.supplierId),
                          );
                          final items = ref.watch(_purchaseItemsProvider(id));
                          final payments = ref.watch(
                            _purchasePaymentsProvider(id),
                          );

                          return _DetailsContent(
                            purchase: purchase,
                            supplier: supplier.valueOrNull,
                            items: items.valueOrNull ?? const [],
                            payments: payments.valueOrNull ?? const [],
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => const _CenteredMessage(
                          message: 'ক্রয়ের তথ্য লোড করা যায়নি',
                        ),
                      ),
                const _DetailsBottomActions(),
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
    required this.purchase,
    required this.supplier,
    required this.items,
    required this.payments,
  });

  final LocalPurchase purchase;
  final LocalSupplier? supplier;
  final List<LocalPurchaseItem> items;
  final List<LocalPurchasePayment> payments;

  @override
  Widget build(BuildContext context) {
    final paidAmount = payments.fold<double>(
      0,
      (sum, payment) => sum + payment.payments,
    );
    final dueAmount = purchase.total - paidAmount;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        96,
      ),
      children: [
        _SupplierSummaryCard(purchase: purchase),
        const SizedBox(height: AppSpacing.md),
        _SupplierContactCard(supplier: supplier),
        const SizedBox(height: AppSpacing.md),
        _OrderListSection(items: items),
        const SizedBox(height: AppSpacing.md),
        _TotalsCard(
          purchase: purchase,
          paidAmount: paidAmount,
          dueAmount: dueAmount,
        ),
        const SizedBox(height: AppSpacing.md),
        _CommentCard(comment: purchase.description),
        const SizedBox(height: AppSpacing.md),
        _PaymentReceiptRow(
          paidAmount: paidAmount,
          memoUrl: purchase.buyingMemoUrl,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _HistoryDetailsTopBar extends StatelessWidget {
  const _HistoryDetailsTopBar();

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
                    'পণ্যের ক্রয় বিবরণ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

class _SupplierSummaryCard extends StatelessWidget {
  const _SupplierSummaryCard({required this.purchase});

  final LocalPurchase purchase;

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
                  '#${purchase.id.substring(0, 8).toUpperCase()}',
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
                        _dateTime(purchase.createdAt),
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
                _money(purchase.total),
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SupplierContactCard extends StatelessWidget {
  const _SupplierContactCard({required this.supplier});

  final LocalSupplier? supplier;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE7F6F1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplier?.name ?? 'সাপ্লায়ার',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _supplierDetails(supplier),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7F2),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(Icons.call_rounded, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _OrderListSection extends StatelessWidget {
  const _OrderListSection({required this.items});

  final List<LocalPurchaseItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: Text(
              'পণ্যের চার্ট',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const _OrderTableHeader(),
          const Divider(height: 1, color: AppColors.surfaceContainerHigh),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('কোনো পণ্য পাওয়া যায়নি'),
            )
          else
            for (var i = 0; i < items.length; i++) ...[
              _OrderItemRow(item: items[i]),
              if (i != items.length - 1)
                const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            ],
        ],
      ),
    );
  }
}

class _OrderTableHeader extends StatelessWidget {
  const _OrderTableHeader();

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
          Expanded(flex: 4, child: Text('পণ্যের নাম', style: style)),
          Expanded(flex: 2, child: Text('পরিমাণ', style: style)),
          Expanded(flex: 2, child: Text('ক্রয় দর', style: style)),
          Expanded(
            flex: 2,
            child: Text('মোট', style: style, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item});

  final LocalPurchaseItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              item.productName,
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${_bnNumber(item.quantity)}টি',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _money(item.buyingPrice),
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _money(item.buyingPrice * item.quantity),
              textAlign: TextAlign.right,
              style: textTheme.titleSmall?.copyWith(
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

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({
    required this.purchase,
    required this.paidAmount,
    required this.dueAmount,
  });

  final LocalPurchase purchase;
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
          _TotalRow(
            label: 'মোট ক্রয়',
            value: _money(purchase.total),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TotalRow(
            label: 'অন্যান্য খরচ',
            value: _money(purchase.otherCharge),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TotalRow(
            label: 'পরিশোধ',
            value: _money(paidAmount),
            textTheme: textTheme,
            valueColor: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TotalRow(
            label: 'বাকি',
            value: _money(dueAmount < 0 ? 0 : dueAmount),
            textTheme: textTheme,
            valueColor: dueAmount > 0 ? const Color(0xFFD9534F) : null,
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
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
            fontWeight: FontWeight.w800,
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

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.comment});

  final String? comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'অতিরিক্ত নোট',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            comment?.trim().isNotEmpty == true ? comment!.trim() : 'নোট নেই',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentReceiptRow extends StatelessWidget {
  const _PaymentReceiptRow({required this.paidAmount, required this.memoUrl});

  final double paidAmount;
  final String? memoUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoTile(
            title: 'পরিশোধের পরিমাণ',
            value: _money(paidAmount),
            showArrow: true,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _ReceiptTile(memoUrl: memoUrl)),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
    this.showArrow = false,
  });

  final String title;
  final String value;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          if (showArrow)
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
        ],
      ),
    );
  }
}

class _ReceiptTile extends StatelessWidget {
  const _ReceiptTile({required this.memoUrl});

  final String? memoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ক্রয় রশিদ',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          const Spacer(),
          Container(
            width: 72,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(color: AppColors.surfaceContainerHigh),
            ),
            alignment: Alignment.center,
            child: Text(
              memoUrl?.trim().isNotEmpty == true ? 'IMG' : 'নেই',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsBottomActions extends StatelessWidget {
  const _DetailsBottomActions();

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
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  boxShadow: AppShadows.soft,
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.print_rounded,
                    color: AppColors.textPrimary,
                  ),
                  label: Text(
                    'রিসিট প্রিন্ট করুন',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
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
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                    ),
                    icon: const Icon(Icons.edit_rounded),
                    label: Text(
                      'বিস্তারিত দেখুন',
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

String _supplierDetails(LocalSupplier? supplier) {
  final parts = [
    supplier?.mobile,
    supplier?.address,
  ].where((value) => value != null && value.trim().isNotEmpty).toList();

  if (parts.isEmpty) {
    return 'যোগাযোগের তথ্য নেই';
  }

  return parts.join('\n');
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
