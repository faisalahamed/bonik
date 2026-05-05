import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _purchaseBatchesProvider =
    StreamProvider.family<List<LocalAvailablePurchaseBatch>, LocalSalesProduct>(
      (ref, product) => ref
          .watch(appDatabaseProvider)
          .watchAvailablePurchaseBatchesForProduct(
            productName: product.name,
            categoryId: product.categoryId,
          ),
    );

class InventoryItemDetailsPage extends StatelessWidget {
  const InventoryItemDetailsPage({super.key, required this.product});

  final LocalSalesProduct? product;

  @override
  Widget build(BuildContext context) {
    final item = product;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F7),
      body: item == null
          ? const _MissingProductView()
          : _InventoryItemDetailsView(product: item),
    );
  }
}

class _MissingProductView extends StatelessWidget {
  const _MissingProductView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DetailsHeader(title: 'পণ্যের বিস্তারিত'),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _PlainPanel(
                child: Text(
                  'পণ্যের তথ্য পাওয়া যায়নি',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InventoryItemDetailsView extends ConsumerWidget {
  const _InventoryItemDetailsView({required this.product});

  final LocalSalesProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchesState = ref.watch(_purchaseBatchesProvider(product));
    final batches = batchesState.valueOrNull;
    final stockQuantity =
        batches?.fold<int>(0, (sum, batch) => sum + batch.availableQuantity) ??
        product.stockQuantity;
    final stockValue =
        batches?.fold<double>(
          0,
          (sum, batch) => sum + (batch.availableQuantity * batch.buyingPrice),
        ) ??
        product.stockValue;
    final totalProfit =
        batches?.fold<double>(
          0,
          (sum, batch) =>
              sum +
              (batch.availableQuantity *
                  (batch.sellingPrice - batch.buyingPrice)),
        ) ??
        product.expectedProfit;
    final isLowStock = stockQuantity <= 5;

    return Column(
      children: [
        _DetailsHeader(title: product.name),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            children: [
              _ProductProfileCard(
                product: product,
                stockQuantity: stockQuantity,
                stockValue: stockValue,
                expectedProfit: totalProfit,
                isLowStock: isLowStock,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SectionTitle(title: 'ক্রয় ব্যাচ অনুযায়ী দাম'),
              const SizedBox(height: AppSpacing.md),
              batchesState.when(
                data: (batches) => _PurchaseBatchList(batches: batches),
                loading: () => const _PlainPanel(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => const _PlainPanel(
                  child: Text(
                    'ক্রয় ব্যাচ লোড করা যায়নি',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        boxShadow: AppShadows.soft,
      ),
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
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(Icons.more_vert_rounded, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductProfileCard extends StatelessWidget {
  const _ProductProfileCard({
    required this.product,
    required this.stockQuantity,
    required this.stockValue,
    required this.expectedProfit,
    required this.isLowStock,
  });

  final LocalSalesProduct product;
  final int stockQuantity;
  final double stockValue;
  final double expectedProfit;
  final bool isLowStock;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: const Icon(
                  Icons.inventory_2_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatusPill(
                      label: isLowStock ? 'লো স্টক' : 'স্টক আছে',
                      warning: isLowStock,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _ProfileSummaryTile(
                  icon: Icons.inventory_2_rounded,
                  label: 'মোট স্টক',
                  value: '${_bnNumber(stockQuantity)}টি',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ProfileSummaryTile(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'মোট স্টক মূল্য',
                  value: _money(stockValue),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _ExpectedProfitTile(
            expectedProfit: expectedProfit,
            stockQuantity: stockQuantity,
          ),
        ],
      ),
    );
  }
}

class _ProfileSummaryTile extends StatelessWidget {
  const _ProfileSummaryTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.82), size: 17),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpectedProfitTile extends StatelessWidget {
  const _ExpectedProfitTile({
    required this.expectedProfit,
    required this.stockQuantity,
  });

  final double expectedProfit;
  final int stockQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'প্রত্যাশিত লাভ',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _money(expectedProfit),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${_bnNumber(stockQuantity)}টি স্টক বিক্রি হলে সম্ভাব্য মোট লাভ',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontWeight: FontWeight.w700,
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

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.warning});

  final String label;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: warning
            ? const Color(0xFFFFE7E5)
            : Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: warning ? const Color(0xFFD9534F) : Colors.white,
          fontWeight: FontWeight.w800,
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
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _PurchaseBatchList extends StatelessWidget {
  const _PurchaseBatchList({required this.batches});

  final List<LocalAvailablePurchaseBatch> batches;

  @override
  Widget build(BuildContext context) {
    if (batches.isEmpty) {
      return const _PlainPanel(
        child: Text(
          'এই পণ্যের কোনো স্টক ব্যাচ পাওয়া যায়নি',
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < batches.length; i++) ...[
          _PurchaseBatchCard(batch: batches[i], index: i + 1),
          if (i != batches.length - 1) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _PurchaseBatchCard extends ConsumerWidget {
  const _PurchaseBatchCard({required this.batch, required this.index});

  final LocalAvailablePurchaseBatch batch;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockValue = batch.availableQuantity * batch.buyingPrice;
    final profitPerItem = batch.sellingPrice - batch.buyingPrice;
    final totalProfit = batch.availableQuantity * profitPerItem;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: Color(0xFFE8FFF4),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadii.xl),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Center(
                    child: Text(
                      _bnNumber(index),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ক্রয় ব্যাচ',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ক্রয়ের তারিখ: ${_date(batch.createdAt)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: batch.availableQuantity <= 5
                        ? const Color(0xFFFFE7E5)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Text(
                    '${_bnNumber(batch.availableQuantity)} টি',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: batch.availableQuantity <= 5
                          ? const Color(0xFFD9534F)
                          : AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                _PrimaryBatchPrice(
                  label: 'ক্রয় মূল্য',
                  value: _money(batch.buyingPrice),
                ),

                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _MiniBatchValue(
                        label: 'বিক্রয়',
                        value: _money(batch.sellingPrice),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _MiniBatchValue(
                        label: 'প্রতি লাভ',
                        value: _money(profitPerItem),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _MiniBatchValue(
                        label: 'স্টক মূল্য',
                        value: _money(stockValue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                _BatchTotalProfit(totalProfit: totalProfit),

                if ((batch.barcode ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _BatchBarcodeStrip(barcode: batch.barcode!.trim()),
                  const SizedBox(height: AppSpacing.sm),
                ],
                _BatchActionRow(
                  canPrint: (batch.barcode ?? '').trim().isNotEmpty,
                  onPrint: () => _showSingleBatchPrintDialog(context, batch),
                  onEdit: () => _showEditBatchDialog(context, ref, batch),
                  onDelete: () => _confirmDeleteBatch(context, ref, batch),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryBatchPrice extends StatelessWidget {
  const _PrimaryBatchPrice({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE8FFF4),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.shopping_bag_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
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

class _BatchActionRow extends StatelessWidget {
  const _BatchActionRow({
    required this.canPrint,
    required this.onPrint,
    required this.onEdit,
    required this.onDelete,
  });

  final bool canPrint;
  final VoidCallback onPrint;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BatchActionButton(
            icon: Icons.print_rounded,
            label: 'বারকোড প্রিন্ট',
            onTap: canPrint ? onPrint : null,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _BatchActionButton(
            icon: Icons.edit_rounded,
            label: 'এডিট',
            onTap: onEdit,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _BatchActionButton(
            icon: Icons.delete_rounded,
            label: 'ডিলিট',
            color: const Color(0xFFD9534F),
            onTap: onDelete,
          ),
        ),
      ],
    );
  }
}

class _BatchActionButton extends StatelessWidget {
  const _BatchActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Ink(
          height: 44,
          decoration: BoxDecoration(
            color: enabled
                ? color.withValues(alpha: 0.1)
                : AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: enabled ? color : AppColors.textMuted,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: enabled ? color : AppColors.textMuted,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniBatchValue extends StatelessWidget {
  const _MiniBatchValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _BatchBarcodeStrip extends StatelessWidget {
  const _BatchBarcodeStrip({required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          const Icon(Icons.qr_code_rounded, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'বারকোড: $barcode',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BatchTotalProfit extends StatelessWidget {
  const _BatchTotalProfit({required this.totalProfit});

  final double totalProfit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8FFF4),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Text(
        'এই ব্যাচের সম্ভাব্য লাভ: ${_money(totalProfit)}',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Future<void> _showSingleBatchPrintDialog(
  BuildContext context,
  LocalAvailablePurchaseBatch batch,
) async {
  final count = await showDialog<int>(
    context: context,
    builder: (dialogContext) => _BarcodePrintDialog(
      title: batch.productName,
      subtitle:
          'বারকোড: ${batch.barcode} · স্টক: ${_bnNumber(batch.availableQuantity)}টি',
      helpText:
          'এই ক্রয় ব্যাচের বারকোড লেবেল প্রিন্ট হবে। সাধারণত এই ব্যাচের স্টক অনুযায়ী লেবেল সংখ্যা দিন।',
    ),
  );

  if (count == null || count <= 0 || !context.mounted) {
    return;
  }

  _showSnack(
    context,
    '${batch.productName} এর $count টি বারকোড প্রিন্ট হচ্ছে...',
  );
}

class _BarcodePrintDialog extends StatefulWidget {
  const _BarcodePrintDialog({
    required this.title,
    required this.subtitle,
    required this.helpText,
  });

  final String title;
  final String subtitle;
  final String helpText;

  @override
  State<_BarcodePrintDialog> createState() => _BarcodePrintDialogState();
}

class _BarcodePrintDialogState extends State<_BarcodePrintDialog> {
  int _printCount = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.subtitle,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Text(
              widget.helpText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              'লেবেল সংখ্যা',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _printCount > 1
                    ? () => setState(() => _printCount--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline_rounded),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  _bnNumber(_printCount),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _printCount++),
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('বাতিল'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(_printCount),
          icon: const Icon(Icons.print_rounded),
          label: const Text('বারকোড প্রিন্ট'),
        ),
      ],
    );
  }
}

Future<void> _showEditBatchDialog(
  BuildContext context,
  WidgetRef ref,
  LocalAvailablePurchaseBatch batch,
) async {
  final stockController = TextEditingController(
    text: batch.availableQuantity.toString(),
  );
  final buyingController = TextEditingController(
    text: _plainNumber(batch.buyingPrice),
  );
  final sellingController = TextEditingController(
    text: _plainNumber(batch.sellingPrice),
  );

  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('স্টক ব্যাচ এডিট'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BatchEditField(
            controller: stockController,
            label: 'বর্তমান স্টক',
            icon: Icons.inventory_2_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BatchEditField(
            controller: buyingController,
            label: 'ক্রয় মূল্য',
            icon: Icons.shopping_bag_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BatchEditField(
            controller: sellingController,
            label: 'বিক্রয় মূল্য',
            icon: Icons.sell_rounded,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('বাতিল'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('সেভ'),
        ),
      ],
    ),
  );

  if (saved != true || !context.mounted) {
    stockController.dispose();
    buyingController.dispose();
    sellingController.dispose();
    return;
  }

  final stock = int.tryParse(stockController.text.trim());
  final buyingPrice = double.tryParse(buyingController.text.trim());
  final sellingPrice = double.tryParse(sellingController.text.trim());
  stockController.dispose();
  buyingController.dispose();
  sellingController.dispose();

  if (stock == null ||
      stock < 0 ||
      buyingPrice == null ||
      buyingPrice < 0 ||
      sellingPrice == null ||
      sellingPrice < 0) {
    _showSnack(context, 'সঠিক সংখ্যা দিন');
    return;
  }

  try {
    await ref
        .read(appDatabaseProvider)
        .updatePurchaseBatchStockLocally(
          id: batch.id,
          buyingPrice: buyingPrice,
          sellingPrice: sellingPrice,
          availableQuantity: stock,
        );
    if (context.mounted) {
      _showSnack(context, 'স্টক ব্যাচ আপডেট হয়েছে');
    }
  } catch (_) {
    if (context.mounted) {
      _showSnack(context, 'স্টক ব্যাচ আপডেট করা যায়নি');
    }
  }
}

Future<void> _confirmDeleteBatch(
  BuildContext context,
  WidgetRef ref,
  LocalAvailablePurchaseBatch batch,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('স্টক ব্যাচ ডিলিট'),
      content: const Text('এই ব্যাচের বাকি স্টক ডিলিট করতে চান?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('না'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFD9534F),
          ),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('ডিলিট'),
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) {
    return;
  }

  try {
    await ref
        .read(appDatabaseProvider)
        .deletePurchaseBatchStockLocally(batch.id);
    if (context.mounted) {
      _showSnack(context, 'স্টক ব্যাচ ডিলিট হয়েছে');
    }
  } catch (_) {
    if (context.mounted) {
      _showSnack(context, 'স্টক ব্যাচ ডিলিট করা যায়নি');
    }
  }
}

class _BatchEditField extends StatelessWidget {
  const _BatchEditField({
    required this.controller,
    required this.label,
    required this.icon,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }
}

class _PlainPanel extends StatelessWidget {
  const _PlainPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: child,
    );
  }
}

String _date(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final year = value.year.toString();
  return _bnNumber('$day/$month/$year');
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String _plainNumber(double value) {
  return value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
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
