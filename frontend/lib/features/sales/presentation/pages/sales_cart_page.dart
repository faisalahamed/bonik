import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../application/sales_cart_controller.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

class SalesCartPage extends ConsumerStatefulWidget {
  const SalesCartPage({super.key});

  @override
  ConsumerState<SalesCartPage> createState() => _SalesCartPageState();
}

class _SalesCartPageState extends ConsumerState<SalesCartPage> {
  final _discountPercentController = TextEditingController(text: '15');
  final _discountAmountController = TextEditingController();
  final _vatPercentController = TextEditingController(text: '15');
  final _vatAmountController = TextEditingController();
  double _discount = 0;
  double _vat = 0;
  double _subtotal = 0;
  bool _updatingFields = false;

  @override
  void initState() {
    super.initState();
    _discountPercentController.addListener(_onDiscountPercentChanged);
    _discountAmountController.addListener(_onDiscountAmountChanged);
    _vatPercentController.addListener(_onVatPercentChanged);
    _vatAmountController.addListener(_onVatAmountChanged);
  }

  @override
  void dispose() {
    _discountPercentController.dispose();
    _discountAmountController.dispose();
    _vatPercentController.dispose();
    _vatAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartLines = ref.watch(salesCartProvider);
    final cartController = ref.read(salesCartProvider.notifier);
    final checkout = ref.watch(salesCheckoutProvider);
    final subtotal = cartController.total;
    _syncSubtotal(subtotal);
    final grandTotal = checkout.grandTotal(subtotal);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'কার্ট রিভিউ'),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -70,
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
              bottom: -140,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                110,
              ),
              child: cartLines.isEmpty
                  ? const _EmptyCartState()
                  : ListView(
                      children: [
                        for (final line in cartLines) ...[
                          _CartReviewItem(
                            line: line,
                            onIncrease: () =>
                                cartController.increase(line.product.id),
                            onDecrease: () =>
                                cartController.decrease(line.product.id),
                            onRemove: () =>
                                cartController.remove(line.product.id),
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        const SizedBox(height: AppSpacing.md),
                        _CartSummaryCard(
                          subtotal: subtotal,
                          discount: checkout.discountAmount,
                          vat: checkout.vatAmount,
                          grandTotal: grandTotal,
                          discountPercentController: _discountPercentController,
                          discountAmountController: _discountAmountController,
                          vatPercentController: _vatPercentController,
                          vatAmountController: _vatAmountController,
                        ),
                      ],
                    ),
            ),
            _CartBottomAction(enabled: cartLines.isNotEmpty),
          ],
        ),
      ),
    );
  }

  void _syncSubtotal(double subtotal) {
    if (_subtotal == subtotal) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _subtotal = subtotal;
        _discount = _amountFromPercent(_discountPercentController.text);
        _vat = _amountFromPercent(_vatPercentController.text);
        _setText(_discountAmountController, _numberText(_discount));
        _setText(_vatAmountController, _numberText(_vat));
        _saveDiscount();
        _saveVat();
      });
    });
  }

  void _onDiscountPercentChanged() {
    if (_updatingFields) {
      return;
    }

    setState(() {
      _discount = _amountFromPercent(_discountPercentController.text);
      _setText(_discountAmountController, _numberText(_discount));
      _saveDiscount();
    });
  }

  void _onDiscountAmountChanged() {
    if (_updatingFields) {
      return;
    }

    setState(() {
      _discount = _readNumber(_discountAmountController.text);
      _setText(
        _discountPercentController,
        _numberText(_percentFromAmount(_discount)),
      );
      _saveDiscount();
    });
  }

  void _onVatPercentChanged() {
    if (_updatingFields) {
      return;
    }

    setState(() {
      _vat = _amountFromPercent(_vatPercentController.text);
      _setText(_vatAmountController, _numberText(_vat));
      _saveVat();
    });
  }

  void _onVatAmountChanged() {
    if (_updatingFields) {
      return;
    }

    setState(() {
      _vat = _readNumber(_vatAmountController.text);
      _setText(_vatPercentController, _numberText(_percentFromAmount(_vat)));
      _saveVat();
    });
  }

  void _saveDiscount() {
    ref
        .read(salesCheckoutProvider.notifier)
        .updateDiscount(
          percent: _readNumber(_discountPercentController.text),
          amount: _discount,
        );
  }

  void _saveVat() {
    ref
        .read(salesCheckoutProvider.notifier)
        .updateVat(
          percent: _readNumber(_vatPercentController.text),
          amount: _vat,
        );
  }

  double _amountFromPercent(String value) {
    return _subtotal * (_readNumber(value) / 100);
  }

  double _percentFromAmount(double value) {
    if (_subtotal <= 0) {
      return 0;
    }
    return (value / _subtotal) * 100;
  }

  double _readNumber(String value) {
    final normalized = value.replaceAll(',', '').trim();
    if (normalized.isEmpty) {
      return 0;
    }
    return double.tryParse(normalized) ?? 0;
  }

  void _setText(TextEditingController controller, String value) {
    _updatingFields = true;
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    _updatingFields = false;
  }
}

class _EmptyCartState extends StatelessWidget {
  const _EmptyCartState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
              size: 46,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'কার্টে কোনো পণ্য নেই',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'বিক্রি পেজ থেকে পণ্য নির্বাচন করুন',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartReviewItem extends StatelessWidget {
  const _CartReviewItem({
    required this.line,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final SalesCartLine line;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final product = line.product;

    return Container(
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
            height: 170,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F3),
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
                            product.name,
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (_hasText(product.description)) ...[
                            const SizedBox(height: 4),
                            Text(
                              product.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          const SizedBox(height: 6),
                          Text(
                            'স্টক: ${_bnNumber(product.stockQuantity)}টি',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _money(line.lineTotal),
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _QuantityCard(
                        quantity: line.quantity,
                        onIncrease: onIncrease,
                        onDecrease: onDecrease,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _UnitPriceCard(unitPrice: product.sellingPrice),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: Text(
                          'মোট: ${_bnNumber(line.quantity)} x ${_money(product.sellingPrice)} = ${_money(line.lineTotal)}',
                          textAlign: TextAlign.center,
                          style: textTheme.labelMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    InkWell(
                      onTap: onRemove,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2F2),
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFD64E4E),
                        ),
                      ),
                    ),
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

class _QuantityCard extends StatelessWidget {
  const _QuantityCard({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'পরিমাণ (টি)',
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onDecrease,
                borderRadius: BorderRadius.circular(99),
                child: const Icon(
                  Icons.remove,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              Text(
                _bnNumber(quantity),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              InkWell(
                onTap: onIncrease,
                borderRadius: BorderRadius.circular(99),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UnitPriceCard extends StatelessWidget {
  const _UnitPriceCard({required this.unitPrice});

  final double unitPrice;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'দর (একক)',
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _money(unitPrice),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Icon(
                Icons.edit_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartSummaryCard extends StatelessWidget {
  const _CartSummaryCard({
    required this.subtotal,
    required this.discount,
    required this.vat,
    required this.grandTotal,
    required this.discountPercentController,
    required this.discountAmountController,
    required this.vatPercentController,
    required this.vatAmountController,
  });

  final double subtotal;
  final double discount;
  final double vat;
  final double grandTotal;
  final TextEditingController discountPercentController;
  final TextEditingController discountAmountController;
  final TextEditingController vatPercentController;
  final TextEditingController vatAmountController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(
            label: 'মোট',
            value: _money(subtotal),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.lg),
          _PercentAmountInputRow(
            label: 'ডিসকাউন্ট',
            percentController: discountPercentController,
            amountController: discountAmountController,
            value: discount,
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.md),
          _PercentAmountInputRow(
            label: 'ভ্যাট',
            percentController: vatPercentController,
            amountController: vatAmountController,
            value: vat,
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'GRAND TOTAL',
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.primaryContainer,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'সর্বমোট',
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                _money(grandTotal),
                style: textTheme.headlineMedium?.copyWith(
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.textTheme,
  });

  final String label;
  final String value;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PercentAmountInputRow extends StatelessWidget {
  const _PercentAmountInputRow({
    required this.label,
    required this.percentController,
    required this.amountController,
    required this.value,
    required this.textTheme,
  });

  final String label;
  final TextEditingController percentController;
  final TextEditingController amountController;
  final double value;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.radio_button_unchecked_rounded,
          color: AppColors.textMuted,
          size: 22,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 78,
          child: TextField(
            controller: percentController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            textAlign: TextAlign.end,
            decoration: _inputDecoration(suffixText: '%'),
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 126,
          child: TextField(
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            textAlign: TextAlign.end,
            decoration: _inputDecoration(
              hintText: _numberText(value),
              prefixText: '৳ ',
            ),
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    String? hintText,
    String? prefixText,
    String? suffixText,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixText: prefixText,
      suffixText: suffixText,
      filled: true,
      fillColor: AppColors.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}

class _CartBottomAction extends StatelessWidget {
  const _CartBottomAction({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: enabled
                ? AppGradients.primaryButton
                : const LinearGradient(
                    colors: [Color(0xFFBFC8C4), Color(0xFFBFC8C4)],
                  ),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            boxShadow: enabled ? AppShadows.button : const [],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 72,
            child: ElevatedButton(
              onPressed: enabled
                  ? () => context.push(AppRoutes.salesPayment)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white,
                disabledBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'এগিয়ে যান',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _money(double value) {
  return '৳ ${_bnNumber(_numberText(value))}';
}

String _numberText(double value) {
  return value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
}

bool _hasText(String? value) {
  return value != null && value.trim().isNotEmpty;
}

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
