import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _salesReturnHistoryProvider =
    StreamProvider<List<LocalSalesHistoryEntry>>(
      (ref) => ref.watch(appDatabaseProvider).watchSalesHistoryForCurrentShop(),
    );

final _salesReturnItemsProvider =
    StreamProvider.family<List<LocalSaleItemDetail>, String>(
      (ref, saleId) =>
          ref.watch(appDatabaseProvider).watchSaleItemDetails(saleId),
    );

const _returnReasons = [
  'ত্রুটিপূর্ণ পণ্য',
  'ভুল পণ্য',
  'ক্রেতার মত পরিবর্তন',
  'ড্যামেজ',
  'Replace',
  'অন্যান্য',
];
const _returnReasonsDefault = 'ত্রুটিপূর্ণ পণ্য';

class SalesReturnPage extends ConsumerStatefulWidget {
  const SalesReturnPage({super.key});

  @override
  ConsumerState<SalesReturnPage> createState() => _SalesReturnPageState();
}

class _SalesReturnPageState extends ConsumerState<SalesReturnPage> {
  final _invoiceController = TextEditingController();
  String? _selectedSaleId;
  final _returnQuantities = <String, int>{};
  final _returnReasons = <String, String>{};
  var _saving = false;

  @override
  void dispose() {
    _invoiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sales = ref.watch(_salesReturnHistoryProvider);
    final selectedSaleId = _selectedSaleId;
    final items = selectedSaleId == null
        ? const AsyncValue<List<LocalSaleItemDetail>>.data([])
        : ref.watch(_salesReturnItemsProvider(selectedSaleId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SalesReturnTopBar(),
          Expanded(
            child: Stack(
              children: [
                const _BackgroundGlow(),
                sales.when(
                  data: (entries) => items.when(
                    data: (saleItems) => _SalesReturnContent(
                      sales: entries,
                      selectedSaleId: selectedSaleId,
                      items: saleItems,
                      invoiceController: _invoiceController,
                      returnQuantities: _returnQuantities,
                      returnReasons: _returnReasons,
                      onQueryChanged: () => setState(() {}),
                      onSaleSelected: _selectSale,
                      onQuantityChanged: _setReturnQuantity,
                      onReasonChanged: _setReturnReason,
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => const _CenteredMessage(
                      message: 'বিক্রির পণ্য লোড করা যায়নি',
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const _CenteredMessage(
                    message: 'বিক্রির তথ্য লোড করা যায়নি',
                  ),
                ),
                _ConfirmReturnButton(
                  saving: _saving,
                  onPressed: _saving ? null : _confirmReturn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectSale(LocalSalesHistoryEntry sale) {
    setState(() {
      _selectedSaleId = sale.id;
      _invoiceController.text = '#${sale.id.substring(0, 8).toUpperCase()}';
      _returnQuantities.clear();
      _returnReasons.clear();
    });
  }

  void _setReturnQuantity(LocalSaleItemDetail item, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _returnQuantities.remove(item.id);
      } else {
        _returnQuantities[item.id] = quantity.clamp(0, item.returnableQuantity);
      }
    });
  }

  void _setReturnReason(LocalSaleItemDetail item, String reason) {
    setState(() {
      _returnReasons[item.id] = reason;
    });
  }

  Future<void> _confirmReturn() async {
    final saleId = _selectedSaleId;
    if (saleId == null || saleId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('প্রথমে ইনভয়েস নির্বাচন করুন')),
      );
      return;
    }

    final saleItems = ref.read(_salesReturnItemsProvider(saleId)).valueOrNull;
    if (saleItems == null || saleItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ফেরত দেওয়ার পণ্য পাওয়া যায়নি')),
      );
      return;
    }

    final draftItems = [
      for (final item in saleItems)
        if ((_returnQuantities[item.id] ?? 0) > 0)
          LocalSaleReturnDraftItem(
            saleItemId: item.id,
            productId: item.productId,
            productName: item.productName,
            salePrice: item.salePrice,
            quantity: _returnQuantities[item.id]!,
            reason: _returnReasons[item.id] ?? _returnReasonsDefault,
          ),
    ];
    if (draftItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ফেরত দেওয়ার পণ্য নির্বাচন করুন')),
      );
      return;
    }

    final subtotal = draftItems.fold<double>(
      0,
      (sum, item) => sum + item.salePrice * item.quantity,
    );

    setState(() {
      _saving = true;
    });

    try {
      await ref
          .read(appDatabaseProvider)
          .saveSalesReturnLocally(
            saleId: saleId,
            items: draftItems,
            restockingFee: subtotal * 0.05,
            note: 'Sales return for #${saleId.substring(0, 8).toUpperCase()}',
          );

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ফেরত লোকাল ডাটাবেজে সেভ হয়েছে')),
      );
      setState(() {
        _returnQuantities.clear();
        _returnReasons.clear();
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }
}

class _SalesReturnContent extends StatelessWidget {
  const _SalesReturnContent({
    required this.sales,
    required this.selectedSaleId,
    required this.items,
    required this.invoiceController,
    required this.returnQuantities,
    required this.returnReasons,
    required this.onQueryChanged,
    required this.onSaleSelected,
    required this.onQuantityChanged,
    required this.onReasonChanged,
  });

  final List<LocalSalesHistoryEntry> sales;
  final String? selectedSaleId;
  final List<LocalSaleItemDetail> items;
  final TextEditingController invoiceController;
  final Map<String, int> returnQuantities;
  final Map<String, String> returnReasons;
  final VoidCallback onQueryChanged;
  final ValueChanged<LocalSalesHistoryEntry> onSaleSelected;
  final void Function(LocalSaleItemDetail item, int quantity) onQuantityChanged;
  final void Function(LocalSaleItemDetail item, String reason) onReasonChanged;

  @override
  Widget build(BuildContext context) {
    final selectedSale = sales
        .where((sale) => sale.id == selectedSaleId)
        .cast<LocalSalesHistoryEntry?>()
        .firstOrNull;
    final subtotal = items.fold<double>(0, (sum, item) {
      return sum + (returnQuantities[item.id] ?? 0) * item.salePrice;
    });
    final restockingFee = subtotal * 0.05;
    final refundTotal = subtotal - restockingFee;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        98,
      ),
      child: ListView(
        children: [
          _InvoiceSearchCard(
            controller: invoiceController,
            sales: sales,
            selectedSale: selectedSale,
            onQueryChanged: onQueryChanged,
            onSaleSelected: onSaleSelected,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _ChooseProductHeader(),
          const SizedBox(height: AppSpacing.md),
          if (selectedSaleId == null)
            const _EmptyCard(message: 'প্রথমে ইনভয়েস নির্বাচন করুন')
          else if (items.isEmpty)
            const _EmptyCard(message: 'এই ইনভয়েসে কোনো পণ্য পাওয়া যায়নি')
          else
            for (var i = 0; i < items.length; i++) ...[
              _ReturnItemCard(
                item: items[i],
                quantity: (returnQuantities[items[i].id] ?? 0).clamp(
                  0,
                  items[i].returnableQuantity,
                ),
                reason: returnReasons[items[i].id] ?? _returnReasonsDefault,
                onQuantityChanged: (quantity) =>
                    onQuantityChanged(items[i], quantity),
                onReasonChanged: (reason) => onReasonChanged(items[i], reason),
              ),
              if (i != items.length - 1) const SizedBox(height: AppSpacing.md),
            ],
          const SizedBox(height: AppSpacing.md),
          _ReturnSummaryCard(
            subtotal: subtotal,
            restockingFee: restockingFee,
            refundTotal: refundTotal,
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
      ],
    );
  }
}

class _SalesReturnTopBar extends StatelessWidget {
  const _SalesReturnTopBar();

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
                    'পণ্য ফেরত',
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

class _InvoiceSearchCard extends StatelessWidget {
  const _InvoiceSearchCard({
    required this.controller,
    required this.sales,
    required this.selectedSale,
    required this.onQueryChanged,
    required this.onSaleSelected,
  });

  final TextEditingController controller;
  final List<LocalSalesHistoryEntry> sales;
  final LocalSalesHistoryEntry? selectedSale;
  final VoidCallback onQueryChanged;
  final ValueChanged<LocalSalesHistoryEntry> onSaleSelected;

  @override
  Widget build(BuildContext context) {
    final query = controller.text.trim().toLowerCase().replaceAll('#', '');
    final matches = query.isEmpty
        ? sales.take(5).toList()
        : sales
              .where(
                (sale) =>
                    sale.id.toLowerCase().contains(query) ||
                    sale.customerName.toLowerCase().contains(query) ||
                    sale.customerPhone.toLowerCase().contains(query),
              )
              .take(6)
              .toList();

    return Container(
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
            'ইনভয়েস খুঁজুন',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: controller,
            onChanged: (_) => onQueryChanged(),
            decoration: const InputDecoration(
              hintText: 'ইনভয়েস নম্বর, ক্রেতা বা ফোন লিখুন',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (selectedSale != null)
            _SelectedInvoiceChip(sale: selectedSale!)
          else if (matches.isEmpty)
            const _MiniMessage(message: 'কোনো ইনভয়েস পাওয়া যায়নি')
          else
            for (final sale in matches) ...[
              _InvoiceSuggestionTile(
                sale: sale,
                onTap: () => onSaleSelected(sale),
              ),
              if (sale != matches.last)
                const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            ],
        ],
      ),
    );
  }
}

class _SelectedInvoiceChip extends StatelessWidget {
  const _SelectedInvoiceChip({required this.sale});

  final LocalSalesHistoryEntry sale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F6EF),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '#${sale.id.substring(0, 8).toUpperCase()} · ${sale.customerName}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            _money(sale.total),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceSuggestionTile extends StatelessWidget {
  const _InvoiceSuggestionTile({required this.sale, required this.onTap});

  final LocalSalesHistoryEntry sale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: const Icon(Icons.receipt_rounded, color: AppColors.primary),
      title: Text('#${sale.id.substring(0, 8).toUpperCase()}'),
      subtitle: Text('${sale.customerName} · ${_dateOnly(sale.createdAt)}'),
      trailing: Text(
        _money(sale.total),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ChooseProductHeader extends StatelessWidget {
  const _ChooseProductHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'পণ্য নির্বাচন করুন',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ReturnItemCard extends StatelessWidget {
  const _ReturnItemCard({
    required this.item,
    required this.quantity,
    required this.reason,
    required this.onQuantityChanged,
    required this.onReasonChanged,
  });

  final LocalSaleItemDetail item;
  final int quantity;
  final String reason;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<String> onReasonChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.inventory_2_rounded,
                  color: AppColors.primary,
                  size: 42,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKU: ${item.productId.substring(0, 8).toUpperCase()}',
                      style: textTheme.labelMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.productName,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.returnedQuantity > 0
                          ? 'মূল্য: ${_money(item.salePrice)} · বিক্রি: ${_bnNumber(item.quantity)}টি · আগে ফেরত: ${_bnNumber(item.returnedQuantity)}টি'
                          : 'মূল্য: ${_money(item.salePrice)} · বিক্রি: ${_bnNumber(item.quantity)}টি',
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _SelectorCard(
                  label: 'ফেরত পরিমাণ',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: quantity <= 0
                            ? null
                            : () => onQuantityChanged(quantity - 1),
                        icon: const Icon(Icons.remove),
                        color: AppColors.textSecondary,
                      ),
                      Text(
                        _bnNumber(quantity.toString().padLeft(2, '0')),
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        onPressed: quantity >= item.returnableQuantity
                            ? null
                            : () => onQuantityChanged(quantity + 1),
                        icon: const Icon(Icons.add),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SelectorCard(
                  label: 'ফেরত কারণ',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: reason,
                      isExpanded: true,
                      items: [
                        for (final option in _returnReasons)
                          DropdownMenuItem(value: option, child: Text(option)),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          onReasonChanged(value);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (item.returnableQuantity <= 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'এই পণ্যটি পুরো ফেরত হয়ে গেছে',
                style: textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFD9534F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SelectorCard extends StatelessWidget {
  const _SelectorCard({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
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
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _ReturnSummaryCard extends StatelessWidget {
  const _ReturnSummaryCard({
    required this.subtotal,
    required this.restockingFee,
    required this.refundTotal,
  });

  final double subtotal;
  final double restockingFee;
  final double refundTotal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'সাবটোটাল (মোট)',
            value: _money(subtotal),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'রি-স্টকিং ফি (৫%)',
            value: '- ${_money(restockingFee)}',
            textTheme: textTheme,
            valueColor: const Color(0xFFD9534F),
          ),
          const Divider(
            height: AppSpacing.xl,
            color: AppColors.surfaceContainerHigh,
          ),
          _SummaryRow(
            label: 'সর্বমোট ফেরত',
            value: _money(refundTotal < 0 ? 0 : refundTotal),
            textTheme: textTheme,
            emphasize: true,
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
    this.emphasize = false,
  });

  final String label;
  final String value;
  final TextTheme textTheme;
  final Color? valueColor;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: (emphasize ? textTheme.titleLarge : textTheme.titleMedium)
                ?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          value,
          style: (emphasize ? textTheme.headlineSmall : textTheme.titleMedium)
              ?.copyWith(
                color:
                    valueColor ??
                    (emphasize ? AppColors.primary : AppColors.textSecondary),
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _ConfirmReturnButton extends StatelessWidget {
  const _ConfirmReturnButton({required this.saving, required this.onPressed});

  final bool saving;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.primaryButton,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            boxShadow: AppShadows.button,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 72,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
              ),
              icon: saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.check_circle_rounded),
              label: Text(
                saving ? 'সেভ হচ্ছে' : 'ফেরত নিশ্চিত করুন',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

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

class _MiniMessage extends StatelessWidget {
  const _MiniMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w700,
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

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _dateOnly(DateTime value) {
  return '${_bnNumber(value.day)} ${_bnMonth(value.month)}, ${_bnNumber(value.year)}';
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
