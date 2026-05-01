import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';
import '../../application/cash_purchase_draft_controller.dart';
import '../../data/purchase_sync_service.dart';

class CashPurchasePaymentPage extends ConsumerStatefulWidget {
  const CashPurchasePaymentPage({super.key});

  @override
  ConsumerState<CashPurchasePaymentPage> createState() =>
      _CashPurchasePaymentPageState();
}

class _CashPurchasePaymentPageState
    extends ConsumerState<CashPurchasePaymentPage> {
  late final TextEditingController _paidAmountController;

  @override
  void initState() {
    super.initState();
    _paidAmountController = TextEditingController(
      text: ref.read(cashPurchaseDraftProvider).paidAmount,
    )..addListener(_syncPaidAmount);
  }

  @override
  void dispose() {
    _paidAmountController
      ..removeListener(_syncPaidAmount)
      ..dispose();
    super.dispose();
  }

  void _syncPaidAmount() {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .setPaidAmount(_paidAmountController.text);
  }

  @override
  Widget build(BuildContext context) {
    final purchaseDraft = ref.watch(cashPurchaseDraftProvider);
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'পেমেন্ট'),
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
                  child: ListView(
                    children: [
                      _PayableAmountCard(amount: purchaseDraft.purchaseTotal),
                      const SizedBox(height: AppSpacing.lg),
                      _PurchaseItemsSummaryCard(
                        lines: purchaseDraft.selectedLines,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _SupplierDropdownCard(
                        suppliersStream: database
                            .watchSuppliersForCurrentShop(),
                        selectedSupplierId: purchaseDraft.supplierId,
                        onChanged: (supplierId) {
                          ref
                              .read(cashPurchaseDraftProvider.notifier)
                              .setSupplier(supplierId);
                        },
                        onAddSupplier: () => _showAddSupplierDialog(database),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _AttachmentAndDateRow(date: purchaseDraft.purchaseDate),
                      const SizedBox(height: AppSpacing.lg),
                      _PaymentMethodSection(
                        totalAmount: purchaseDraft.purchaseTotal,
                        selectedMethod: purchaseDraft.paymentMethod,
                        paidAmountController: _paidAmountController,
                        onMethodChanged: (method) {
                          ref
                              .read(cashPurchaseDraftProvider.notifier)
                              .setPaymentMethod(method);
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _PurchaseNoteCard(note: purchaseDraft.comment),
                    ],
                  ),
                ),
                const _ConfirmPurchasePaymentButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddSupplierDialog(AppDatabase database) async {
    final draft = await showDialog<_SupplierDraft>(
      context: context,
      builder: (context) => const _AddSupplierDialog(),
    );

    if (draft == null || draft.name.trim().isEmpty) {
      return;
    }

    try {
      final supplier = await database.createSupplier(
        name: draft.name,
        mobile: draft.mobile,
        address: draft.address,
      );
      if (!mounted) {
        return;
      }

      ref.read(cashPurchaseDraftProvider.notifier).setSupplier(supplier.id);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _PayableAmountCard extends StatelessWidget {
  const _PayableAmountCard({required this.amount});

  final double amount;

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
            'টাকার পরিমাণ',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _amountText(amount),
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '৳',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.textMuted,
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

class _SupplierDropdownCard extends StatelessWidget {
  const _SupplierDropdownCard({
    required this.suppliersStream,
    required this.selectedSupplierId,
    required this.onChanged,
    required this.onAddSupplier,
  });

  final Stream<List<LocalSupplier>> suppliersStream;
  final String? selectedSupplierId;
  final ValueChanged<String?> onChanged;
  final VoidCallback onAddSupplier;

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
            'সাপ্লায়ার( SUPPLIER)',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          StreamBuilder<List<LocalSupplier>>(
            stream: suppliersStream,
            builder: (context, snapshot) {
              final suppliers = snapshot.data ?? const <LocalSupplier>[];
              final hasSelectedSupplier = suppliers.any(
                (supplier) => supplier.id == selectedSupplierId,
              );

              return DropdownButtonFormField<String>(
                initialValue: hasSelectedSupplier ? selectedSupplierId : null,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceContainerLow,
                  hintText: suppliers.isEmpty ? 'সাপ্লায়ার নেই' : '--সিলেক্ট--',
                ),
                items: [
                  for (final supplier in suppliers)
                    DropdownMenuItem<String>(
                      value: supplier.id,
                      child: Text(
                        supplier.name,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
                onChanged: suppliers.isEmpty ? null : onChanged,
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onAddSupplier,
              icon: const Icon(Icons.add_business_rounded, size: 18),
              label: const Text('নতুন সাপ্লায়ার যোগ করুন'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupplierDraft {
  const _SupplierDraft({required this.name, this.mobile, this.address});

  final String name;
  final String? mobile;
  final String? address;
}

class _AddSupplierDialog extends StatefulWidget {
  const _AddSupplierDialog();

  @override
  State<_AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends State<_AddSupplierDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('নতুন সাপ্লায়ার'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'নাম'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'নাম আবশ্যক';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'মোবাইল'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'ঠিকানা'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('বাতিল'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('যোগ করুন')),
      ],
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    Navigator.of(context).pop(
      _SupplierDraft(
        name: _nameController.text.trim(),
        mobile: _nullableTrimmed(_mobileController.text),
        address: _nullableTrimmed(_addressController.text),
      ),
    );
  }

  String? _nullableTrimmed(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _PurchaseItemsSummaryCard extends StatelessWidget {
  const _PurchaseItemsSummaryCard({required this.lines});

  final List<CashPurchaseDraftLine> lines;

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
            'ক্রয় পণ্য',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (lines.isEmpty)
            Text(
              'কোনো পণ্য নেই',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            for (var i = 0; i < lines.length; i++) ...[
              _PurchaseItemSummaryLine(line: lines[i]),
              if (i != lines.length - 1) const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _PurchaseItemSummaryLine extends StatelessWidget {
  const _PurchaseItemSummaryLine({required this.line});

  final CashPurchaseDraftLine line;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final calculation =
        '${_numberText(line.quantityValue)} × ${_moneyText(line.buyingPriceValue)} = ${_moneyText(line.purchaseTotal)}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.category.name,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  calculation,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            _moneyText(line.purchaseTotal),
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentAndDateRow extends StatelessWidget {
  const _AttachmentAndDateRow({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateText =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.soft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_rounded, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    'রিসিপ্টের ছবি',
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryButton,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.button,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'তারিখ',
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.white.withOpacity(0.82),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    dateText,
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodSection extends StatelessWidget {
  const _PaymentMethodSection({
    required this.totalAmount,
    required this.selectedMethod,
    required this.paidAmountController,
    required this.onMethodChanged,
  });

  final double totalAmount;
  final String selectedMethod;
  final TextEditingController paidAmountController;
  final ValueChanged<String> onMethodChanged;

  @override
  Widget build(BuildContext context) {
    final paidAmount = selectedMethod == 'partial'
        ? double.tryParse(paidAmountController.text.trim()) ?? 0
        : selectedMethod == 'due'
        ? 0.0
        : totalAmount;
    final remainingAmount = (totalAmount - paidAmount)
        .clamp(0, totalAmount)
        .toDouble();

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
          const _SectionAccentTitle(title: 'মূল্য পরিশোধের পদ্ধতি'),
          const SizedBox(height: AppSpacing.md),
          _PaymentMethodOption(
            icon: Icons.payments_rounded,
            label: 'নগদ টাকা',
            value: 'cash',
            groupValue: selectedMethod,
            onChanged: onMethodChanged,
          ),
          const SizedBox(height: AppSpacing.md),
          _PaymentMethodOption(
            icon: Icons.payments_rounded,
            label: 'BKash,Nagad, Rocket, Online',
            value: 'online',
            groupValue: selectedMethod,
            onChanged: onMethodChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PaymentMethodOption(
            icon: Icons.account_balance_wallet_rounded,
            label: 'ব্যাংক চেক',
            value: 'cheque',
            groupValue: selectedMethod,
            onChanged: onMethodChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PaymentMethodOption(
            icon: Icons.assignment_late_rounded,
            label: 'বাকি (Due)',
            value: 'due',
            groupValue: selectedMethod,
            onChanged: onMethodChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PaymentMethodOption(
            icon: Icons.payments_outlined,
            label: 'আংশিক পেমেন্ট',
            value: 'partial',
            groupValue: selectedMethod,
            onChanged: onMethodChanged,
          ),
          if (selectedMethod == 'partial') ...[
            const SizedBox(height: AppSpacing.md),
            _PartialPaymentInput(
              controller: paidAmountController,
              totalAmount: totalAmount,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          _PaidRemainingCard(
            paidAmount: paidAmount,
            remainingAmount: remainingAmount,
          ),
        ],
      ),
    );
  }
}

class _SectionAccentTitle extends StatelessWidget {
  const _SectionAccentTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  const _PaymentMethodOption({
    required this.icon,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selected = value == groupValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.surfaceContainerLowest
                : AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: selected
                ? Border.all(color: AppColors.secondary.withValues(alpha: 0.5))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F5F0),
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: (method) {
                  if (method != null) {
                    onChanged(method);
                  }
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaidRemainingCard extends StatelessWidget {
  const _PaidRemainingCard({
    required this.paidAmount,
    required this.remainingAmount,
  });

  final double paidAmount;
  final double remainingAmount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _AmountStatBox(
                  label: 'জমা পরিশোধ (PAID)',
                  value: _amountText(paidAmount),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _AmountStatBox(
                  label: 'বাকি (REMAINING)',
                  value: _amountText(remainingAmount),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'ফুল-পরিশোধ (Full Due)\nযদি সবটুকু বাকি থাকে তবে সাথে হিসাব যোগ হবে না।',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
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

class _PartialPaymentInput extends StatelessWidget {
  const _PartialPaymentInput({
    required this.controller,
    required this.totalAmount,
  });

  final TextEditingController controller;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
      ],
      decoration: InputDecoration(
        labelText: 'জমা পরিশোধ',
        hintText: '0',
        prefixText: '৳ ',
        helperText:
            'মোট ${_moneyText(totalAmount)} এর মধ্যে যত টাকা দেওয়া হয়েছে',
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
      ),
    );
  }
}

class _AmountStatBox extends StatelessWidget {
  const _AmountStatBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _PurchaseNoteCard extends StatelessWidget {
  const _PurchaseNoteCard({required this.note});

  final String note;

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
            'বাজার লিখুন',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Text(
              note.trim().isEmpty ? 'কোনো নোট নেই' : note.trim(),
              style: textTheme.bodyMedium?.copyWith(
                color: note.trim().isEmpty
                    ? AppColors.textMuted
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmPurchasePaymentButton extends ConsumerWidget {
  const _ConfirmPurchasePaymentButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: ElevatedButton(
              onPressed: () => _confirmPurchase(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
              ),
              child: Text(
                'পেমেন্ট কনফার্ম করুন',
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

  Future<void> _confirmPurchase(BuildContext context, WidgetRef ref) async {
    try {
      final draft = ref.read(cashPurchaseDraftProvider);
      await ref.read(purchaseSyncServiceProvider).saveDraftLocally(draft);
      ref.read(cashPurchaseDraftProvider.notifier).clear();

      if (context.mounted) {
        context.go(AppRoutes.dashboard);
      }
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

String _moneyText(double value) {
  return '৳ ${_amountText(value)}';
}

String _amountText(double value) {
  return _numberText(value == -0 ? 0 : value);
}

String _numberText(double value) {
  return value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
}
