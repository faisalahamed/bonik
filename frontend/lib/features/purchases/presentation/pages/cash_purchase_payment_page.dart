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
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(cashPurchaseDraftProvider);

    // Auto set paid amount to total if empty or zero
    String initialPaid = draft.paidAmount;
    if (initialPaid.isEmpty || double.tryParse(initialPaid) == 0) {
      final total = draft.purchaseTotal;
      // Show integer if no decimals, otherwise show 2 decimal places
      initialPaid = total == total.toInt()
          ? total.toInt().toString()
          : total.toStringAsFixed(2);
    }

    _paidAmountController = TextEditingController(text: initialPaid)
      ..addListener(_syncPaidAmount);
    _commentController = TextEditingController(text: draft.comment)
      ..addListener(_syncComment);

    // Use post-frame callback to update the draft state without interfering with the current build cycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentDraft = ref.read(cashPurchaseDraftProvider);
        if (currentDraft.paidAmount.isEmpty ||
            double.tryParse(currentDraft.paidAmount) == 0) {
          ref
              .read(cashPurchaseDraftProvider.notifier)
              .setPaidAmount(initialPaid);
        }
      }
    });
  }

  @override
  void dispose() {
    _paidAmountController
      ..removeListener(_syncPaidAmount)
      ..dispose();
    _commentController
      ..removeListener(_syncComment)
      ..dispose();
    super.dispose();
  }

  void _syncPaidAmount() {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .setPaidAmount(_paidAmountController.text);
  }

  void _syncComment() {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .setComment(_commentController.text);
  }

  Future<void> _changePurchaseDate(DateTime currentDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return;
    }

    ref.read(cashPurchaseDraftProvider.notifier).setPurchaseDate(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    final purchaseDraft = ref.watch(cashPurchaseDraftProvider);
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _RedesignedTopBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _SupplierAndDateSection(
                  purchaseDraft: purchaseDraft,
                  onDateTap: () =>
                      _changePurchaseDate(purchaseDraft.purchaseDate),
                  onSupplierTap: () => _showSupplierSelection(database),
                ),
                const SizedBox(height: AppSpacing.md),
                _PurchaseReceiptCard(
                  lines: purchaseDraft.selectedLines,
                  total: purchaseDraft.purchaseTotal,
                ),
                const SizedBox(height: AppSpacing.md),
                _TransactionAccountCard(
                  totalAmount: purchaseDraft.purchaseTotal,
                  paidAmountController: _paidAmountController,
                  remainingAmount: _calculateRemaining(purchaseDraft),
                ),
                const SizedBox(height: AppSpacing.md),
                _PaymentMethodToggle(
                  selectedMethod: purchaseDraft.paymentMethod,
                  onChanged: (method) {
                    ref
                        .read(cashPurchaseDraftProvider.notifier)
                        .setPaymentMethod(method);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                const SizedBox(height: AppSpacing.md),
                _ActionButtonsRow(onNoteTap: () => _showNoteDialog()),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
          _BottomActionBar(onConfirm: () => _confirmPurchase(context, ref)),
        ],
      ),
    );
  }

  double _calculateRemaining(CashPurchaseDraftState draft) {
    final paid = double.tryParse(_paidAmountController.text) ?? 0;
    return (draft.purchaseTotal - paid)
        .clamp(0, draft.purchaseTotal)
        .toDouble();
  }

  Future<void> _showSupplierSelection(AppDatabase database) async {
    final selectedId = await showDialog<String>(
      context: context,
      builder: (context) => _SupplierSelectionDialog(database: database),
    );

    if (selectedId != null) {
      ref.read(cashPurchaseDraftProvider.notifier).setSupplier(selectedId);
    }
  }

  Future<void> _showNoteDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('নোট লিখুন'),
        content: TextField(
          controller: _commentController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'অর্ডার বা বাজার সম্পর্কে নোট লিখুন...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ঠিক আছে'),
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
      if (!mounted) return;
      ref.read(cashPurchaseDraftProvider.notifier).setSupplier(supplier.id);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<void> _confirmPurchase(BuildContext context, WidgetRef ref) async {
    try {
      final draft = ref.read(cashPurchaseDraftProvider);
      final hasSelectedSupplier = draft.supplierId?.trim().isNotEmpty ?? false;
      if (!hasSelectedSupplier) {
        final decision = await _confirmDefaultSupplier();
        if (decision == _DefaultSupplierDecision.selectSupplier) {
          if (context.mounted) {
            await _showSupplierSelection(ref.read(appDatabaseProvider));
          }
          return;
        }
        if (decision != _DefaultSupplierDecision.continueWithDefault) {
          return;
        }
      }
      await ref.read(purchaseSyncServiceProvider).saveDraftLocally(draft);
      ref.read(cashPurchaseDraftProvider.notifier).clear();
      if (context.mounted) {
        context.go(AppRoutes.dashboard);
      }
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<_DefaultSupplierDecision?> _confirmDefaultSupplier() {
    return showDialog<_DefaultSupplierDecision>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('সাপ্লায়ার নির্বাচন করা হয়নি'),
        content: const Text('আপনি কি ডিফল্ট সাপ্লায়ার দিয়ে সংরক্ষণ করতে চান?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, _DefaultSupplierDecision.selectSupplier),
            child: const Text('সাপ্লায়ার নির্বাচন'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              _DefaultSupplierDecision.continueWithDefault,
            ),
            child: const Text('চালিয়ে যান'),
          ),
        ],
      ),
    );
  }
}

enum _DefaultSupplierDecision { continueWithDefault, selectSupplier }

class _RedesignedTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.primaryButton),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'পেমেন্ট এন্ট্রি',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupplierAndDateSection extends ConsumerWidget {
  const _SupplierAndDateSection({
    required this.purchaseDraft,
    required this.onDateTap,
    required this.onSupplierTap,
  });

  final CashPurchaseDraftState purchaseDraft;
  final VoidCallback onDateTap;
  final VoidCallback onSupplierTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(appDatabaseProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'সরবরাহকারী',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: onSupplierTap,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFB2DFDB)),
                  ),
                  child: StreamBuilder<LocalSupplier?>(
                    stream: purchaseDraft.supplierId != null
                        ? database.watchSupplierById(purchaseDraft.supplierId!)
                        : const Stream.empty(),
                    builder: (context, snapshot) {
                      final name =
                          snapshot.data?.name ?? 'সাপ্লায়ার সিলেক্ট করুন';
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Color(0xFF004D40),
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF00695C),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'তারিখ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: onDateTap,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFB2DFDB)),
                ),
                child: Row(
                  children: [
                    Text(
                      _formatDateBengali(purchaseDraft.purchaseDate),
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: Color(0xFF00695C),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PurchaseReceiptCard extends StatelessWidget {
  const _PurchaseReceiptCard({required this.lines, required this.total});
  final List<CashPurchaseDraftLine> lines;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.receipt_long, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                const Text(
                  'পণ্যের তালিকা',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 18,
                    color: Color(0xFF00695C),
                  ),
                  label: const Text(
                    'যোগ করুন',
                    style: TextStyle(
                      color: Color(0xFF00695C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (lines.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'কোনো পণ্য নেই',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          for (var i = 0; i < lines.length; i++) ...[
            _ProductItemRow(line: lines[i]),
            if (i < lines.length - 1)
              const Divider(height: 1, indent: 12, endIndent: 12),
          ],
          const _DashedDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'গ্র্যান্ড টোটাল',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'GRAND TOTAL',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Text(
                  _formatTaka(
                    total == total.toInt()
                        ? total.toInt().toString()
                        : total.toStringAsFixed(2),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF004D40),
                    fontSize: 22,
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

class _ProductItemRow extends StatelessWidget {
  const _ProductItemRow({required this.line});
  final CashPurchaseDraftLine line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_toBengaliNumber(line.quantityValue.toStringAsFixed(0))} টি × ${_formatTaka(line.buyingPriceValue == line.buyingPriceValue.toInt() ? line.buyingPriceValue.toInt().toString() : line.buyingPriceValue.toStringAsFixed(2))}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTaka(
              line.purchaseTotal == line.purchaseTotal.toInt()
                  ? line.purchaseTotal.toInt().toString()
                  : line.purchaseTotal.toStringAsFixed(2),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: Color(0xFF004D40),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionAccountCard extends StatelessWidget {
  const _TransactionAccountCard({
    required this.totalAmount,
    required this.paidAmountController,
    required this.remainingAmount,
  });

  final double totalAmount;
  final TextEditingController paidAmountController;
  final double remainingAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0F2F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet_outlined,
                size: 18,
                color: Color(0xFF00695C),
              ),
              const SizedBox(width: 8),
              const Text(
                'লেনদেন হিসাব',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00695C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _CustomInputField(
                  label: 'মোট বিল',
                  value: _toBengaliNumber(
                    totalAmount == totalAmount.toInt()
                        ? totalAmount.toInt().toString()
                        : totalAmount.toStringAsFixed(2),
                  ),
                  isReadOnly: true,
                  showTakaPrefix: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CustomInputField(
                  label: 'পরিশোধিত (PAID)',
                  controller: paidAmountController,
                  hint: '0.00',
                  showTakaPrefix: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (remainingAmount > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFB2DFDB).withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFB2DFDB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Color(0xFF00695C),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'বকেয়া (DUE)',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTaka(
                          remainingAmount == remainingAmount.toInt()
                              ? remainingAmount.toInt().toString()
                              : remainingAmount.toStringAsFixed(2),
                        ),
                        style: const TextStyle(
                          color: Color(0xFFC62828),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Text(
                            'বকেয়া থাকলো',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

class _CustomInputField extends StatelessWidget {
  const _CustomInputField({
    required this.label,
    this.value,
    this.controller,
    this.hint,
    this.isReadOnly = false,
    this.showTakaPrefix = false,
  });

  final String label;
  final String? value;
  final TextEditingController? controller;
  final String? hint;
  final bool isReadOnly;
  final bool showTakaPrefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFB2DFDB)),
          ),
          child: TextField(
            controller:
                controller ??
                (value != null ? TextEditingController(text: value) : null),
            readOnly: isReadOnly,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            decoration: InputDecoration(
              hintText: hint,
              prefixText: showTakaPrefix ? '৳ ' : null,
              prefixStyle: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color(0xFF004D40),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodToggle extends StatelessWidget {
  const _PaymentMethodToggle({
    required this.selectedMethod,
    required this.onChanged,
  });
  final String selectedMethod;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MethodButton(
          label: 'নগদ',
          icon: Icons.payments,
          isSelected: selectedMethod == 'cash',
          onTap: () => onChanged('cash'),
        ),
        const SizedBox(width: 8),
        _MethodButton(
          label: 'ব্যাংক',
          icon: Icons.account_balance,
          isSelected: selectedMethod == 'cheque',
          onTap: () => onChanged('cheque'),
        ),
        const SizedBox(width: 8),
        _MethodButton(
          label: 'বিকাশ/রকেট',
          icon: Icons.phone_android,
          isSelected: selectedMethod == 'online',
          onTap: () => onChanged('online'),
        ),
      ],
    );
  }
}

class _MethodButton extends StatelessWidget {
  const _MethodButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF004D40) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFB2DFDB)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF004D40),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF004D40),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow({required this.onNoteTap});
  final VoidCallback onNoteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          label: 'ছবি যোগ করুন',
          icon: Icons.photo_camera,
          onTap: () {},
        ),
        const SizedBox(width: 12),
        _ActionButton(
          label: 'নোট লিখুন',
          icon: Icons.note_alt,
          onTap: onNoteTap,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({required this.onConfirm});
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'কনফার্ম এবং সেভ করুন',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.done_all),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Helpers
String _formatDateBengali(DateTime date) {
  final months = [
    'জানুয়ারি',
    'ফেব্রুয়ারি',
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
  final day = _toBengaliNumber(date.day.toString().padLeft(2, '0'));
  final month = months[date.month - 1];
  final year = _toBengaliNumber(date.year.toString());
  return '$day $month $year';
}

String _toBengaliNumber(String input) {
  const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const bengaliDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  var output = input;
  for (var i = 0; i < englishDigits.length; i++) {
    output = output.replaceAll(englishDigits[i], bengaliDigits[i]);
  }
  return output;
}

String _formatTaka(String value) => '৳ ${_toBengaliNumber(value)}';

// Reusing Dialog classes
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
                  if (value == null || value.trim().isEmpty)
                    return 'নাম আবশ্যক';
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
    if (!(_formKey.currentState?.validate() ?? false)) return;
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

class _SupplierSelectionDialog extends StatefulWidget {
  const _SupplierSelectionDialog({required this.database});
  final AppDatabase database;

  @override
  State<_SupplierSelectionDialog> createState() =>
      _SupplierSelectionDialogState();
}

class _SupplierSelectionDialogState extends State<_SupplierSelectionDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.people_alt_rounded, color: Color(0xFF00695C)),
                const SizedBox(width: 12),
                const Text(
                  'সাপ্লায়ার নির্বাচন করুন',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF004D40),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'সাপ্লায়ার সার্চ করুন...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00695C)),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: StreamBuilder<List<LocalSupplier>>(
              stream: widget.database.watchSuppliersForCurrentShop(),
              builder: (context, snapshot) {
                final suppliers = snapshot.data ?? [];
                final filtered = suppliers.where((s) {
                  final nameMatch = s.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
                  final mobileMatch = s.mobile?.contains(_searchQuery) ?? false;
                  return nameMatch || mobileMatch;
                }).toList();

                if (filtered.isEmpty && _searchQuery.isNotEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('কোনো সাপ্লায়ার পাওয়া যায়নি'),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (c, i) =>
                      Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
                  itemBuilder: (context, index) {
                    final supplier = filtered[index];
                    return ListTile(
                      onTap: () => Navigator.pop(context, supplier.id),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE0F2F1),
                        child: Text(
                          supplier.name.substring(0, 1),
                          style: const TextStyle(
                            color: Color(0xFF00695C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        supplier.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      subtitle: supplier.mobile != null
                          ? Text(
                              _toBengaliNumber(supplier.mobile!),
                              style: const TextStyle(fontSize: 12),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog<_SupplierDraft>(
                  context: context,
                  builder: (context) => const _AddSupplierDialog(),
                );
                if (result != null && mounted) {
                  try {
                    final newSupplier = await widget.database.createSupplier(
                      name: result.name,
                      mobile: result.mobile,
                      address: result.address,
                    );
                    if (context.mounted) {
                      Navigator.pop(context, newSupplier.id);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                }
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text('নতুন সাপ্লায়ার যুক্ত করুন'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
