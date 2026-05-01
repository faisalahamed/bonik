import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../application/sales_cart_controller.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

enum _SalesPaymentMethod { cash, due, mobileBanking }

class SalesPaymentPage extends ConsumerStatefulWidget {
  const SalesPaymentPage({super.key});

  @override
  ConsumerState<SalesPaymentPage> createState() => _SalesPaymentPageState();
}

class _SalesPaymentPageState extends ConsumerState<SalesPaymentPage> {
  final _cashReceivedController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerMobileController = TextEditingController();
  _SalesPaymentMethod _paymentMethod = _SalesPaymentMethod.cash;
  double _cashReceived = 0;
  double _lastGrandTotal = -1;
  bool _editingCash = false;

  @override
  void initState() {
    super.initState();
    _cashReceivedController.addListener(_updateCashReceived);
  }

  @override
  void dispose() {
    _cashReceivedController.dispose();
    _customerNameController.dispose();
    _customerMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartLines = ref.watch(salesCartProvider);
    final cartController = ref.read(salesCartProvider.notifier);
    final checkout = ref.watch(salesCheckoutProvider);
    final subtotal = cartController.total;
    final grandTotal = checkout.grandTotal(subtotal);
    final remaining = (grandTotal - _cashReceived).clamp(0, double.infinity);

    _syncCashReceived(grandTotal);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'পেমেন্ট ডিটেইলস'),
      body: Stack(
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
            left: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: const BoxDecoration(
                gradient: AppGradients.backgroundGlowBottom,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    108,
                  ),
                  child: cartLines.isEmpty
                      ? const _EmptyPaymentState()
                      : ListView(
                          children: [
                            _TotalAmountCard(total: grandTotal),
                            const SizedBox(height: AppSpacing.lg),
                            _SaleBreakdownCard(
                              subtotal: subtotal,
                              discount: checkout.discountAmount,
                              vat: checkout.vatAmount,
                              itemCount: cartController.itemCount,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _CashReceivedCard(
                              controller: _cashReceivedController,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _RemainingCard(remaining: remaining.toDouble()),
                            const SizedBox(height: AppSpacing.xl),
                            const _PaymentMethodHeader(),
                            const SizedBox(height: AppSpacing.md),
                            _PaymentMethodGrid(
                              selectedMethod: _paymentMethod,
                              onChanged: (method) {
                                setState(() {
                                  _paymentMethod = method;
                                });
                              },
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            _CartItemsCard(lines: cartLines),
                            const SizedBox(height: AppSpacing.xl),
                            _CustomerInfoCard(
                              nameController: _customerNameController,
                              mobileController: _customerMobileController,
                            ),
                          ],
                        ),
                ),
                _CompletePaymentButton(enabled: cartLines.isNotEmpty),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _syncCashReceived(double grandTotal) {
    if (_editingCash || _lastGrandTotal == grandTotal) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _lastGrandTotal = grandTotal;
      _cashReceived = grandTotal;
      final text = _numberText(grandTotal);
      _cashReceivedController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
      setState(() {});
    });
  }

  void _updateCashReceived() {
    setState(() {
      _editingCash = true;
      _cashReceived = _readNumber(_cashReceivedController.text);
    });
  }

  double _readNumber(String value) {
    final normalized = value.replaceAll(',', '').trim();
    if (normalized.isEmpty) {
      return 0;
    }
    return double.tryParse(normalized) ?? 0;
  }
}

class _EmptyPaymentState extends StatelessWidget {
  const _EmptyPaymentState();

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
        child: Text(
          'পেমেন্ট করার জন্য কার্টে পণ্য যোগ করুন',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _TotalAmountCard extends StatelessWidget {
  const _TotalAmountCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        children: [
          Text(
            'সর্বমোট',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _money(total),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleBreakdownCard extends StatelessWidget {
  const _SaleBreakdownCard({
    required this.subtotal,
    required this.discount,
    required this.vat,
    required this.itemCount,
  });

  final double subtotal;
  final double discount;
  final double vat;
  final int itemCount;

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
          _BreakdownRow(
            label: 'পণ্য সংখ্যা',
            value: '${_bnNumber(itemCount)}টি',
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BreakdownRow(
            label: 'মোট',
            value: _money(subtotal),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BreakdownRow(
            label: 'ডিসকাউন্ট',
            value: '- ${_money(discount)}',
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BreakdownRow(
            label: 'ভ্যাট',
            value: _money(vat),
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
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
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _CashReceivedCard extends StatelessWidget {
  const _CashReceivedCard({required this.controller});

  final TextEditingController controller;

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
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ক্যাশ পেয়েছি',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  decoration: InputDecoration(
                    prefixText: '৳ ',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
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

class _RemainingCard extends StatelessWidget {
  const _RemainingCard({required this.remaining});

  final double remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'বাকি',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _money(remaining),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodHeader extends StatelessWidget {
  const _PaymentMethodHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'পেমেন্ট মেথড',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodGrid extends StatelessWidget {
  const _PaymentMethodGrid({
    required this.selectedMethod,
    required this.onChanged,
  });

  final _SalesPaymentMethod selectedMethod;
  final ValueChanged<_SalesPaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PaymentMethodCard(
            icon: Icons.payments_rounded,
            label: 'নগদ টাকা',
            active: selectedMethod == _SalesPaymentMethod.cash,
            onTap: () => onChanged(_SalesPaymentMethod.cash),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _PaymentMethodCard(
            icon: Icons.assignment_turned_in_rounded,
            label: 'বাকি',
            active: selectedMethod == _SalesPaymentMethod.due,
            onTap: () => onChanged(_SalesPaymentMethod.due),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _PaymentMethodCard(
            icon: Icons.qr_code_2_rounded,
            label: 'বিকাশ/নগদ',
            active: selectedMethod == _SalesPaymentMethod.mobileBanking,
            onTap: () => onChanged(_SalesPaymentMethod.mobileBanking),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      child: Container(
        height: 124,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          boxShadow: active ? AppShadows.button : AppShadows.soft,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: active
                    ? Colors.white.withValues(alpha: 0.14)
                    : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Icon(
                icon,
                color: active ? Colors.white : AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: active ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemsCard extends StatelessWidget {
  const _CartItemsCard({required this.lines});

  final List<SalesCartLine> lines;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'পণ্যসমূহ',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final line in lines) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    line.product.name,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '${_bnNumber(line.quantity)} x ${_money(line.product.sellingPrice)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _CustomerInfoCard extends StatelessWidget {
  const _CustomerInfoCard({
    required this.nameController,
    required this.mobileController,
  });

  final TextEditingController nameController;
  final TextEditingController mobileController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                const Icon(Icons.person_rounded, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'কাস্টমার তথ্য',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.surfaceContainerHigh),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _CustomerField(
                  label: 'কাস্টমারের নাম',
                  hintText: 'নাম লিখুন',
                  controller: nameController,
                ),
                const SizedBox(height: AppSpacing.md),
                _CustomerField(
                  label: 'মোবাইল নম্বর',
                  hintText: '01XXXXXXXXX',
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerField extends StatelessWidget {
  const _CustomerField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.md),
              borderSide: const BorderSide(
                color: AppColors.surfaceContainerHigh,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.md),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CompletePaymentButton extends StatelessWidget {
  const _CompletePaymentButton({required this.enabled});

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
            child: ElevatedButton.icon(
              onPressed: enabled ? () {} : null,
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
              icon: const Icon(Icons.verified_rounded),
              label: Text(
                'কনফার্ম পেমেন্ট',
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

String _money(double value) {
  return '৳ ${_bnNumber(_numberText(value))}';
}

String _numberText(double value) {
  return value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
}

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
