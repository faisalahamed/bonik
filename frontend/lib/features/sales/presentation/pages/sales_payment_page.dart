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
import '../../../../core/database/app_database.dart';
import '../../application/sales_cart_controller.dart';
import '../../data/sales_save_service.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

enum _SalesPaymentMethod { cash, bankCard, mobileBanking }

extension on _SalesPaymentMethod {
  String get value {
    return switch (this) {
      _SalesPaymentMethod.cash => 'cash',
      _SalesPaymentMethod.bankCard => 'bank_card',
      _SalesPaymentMethod.mobileBanking => 'mobile_banking',
    };
  }
}

String _enNumber(String value) {
  const banglaDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '۷', '৮', '۹'];
  var output = value;
  output = output.replaceAllMapped(
    RegExp(r'[\u09E6-\u09EF]'),
    (match) => (match.group(0)!.codeUnitAt(0) - 0x09E6).toString(),
  );
  for (var i = 0; i < banglaDigits.length; i++) {
    output = output.replaceAll(banglaDigits[i], i.toString());
  }
  return output;
}

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
  DateTime _saleDate = DateTime.now();
  double _cashReceived = 0;
  double _lastGrandTotal = -1;
  bool _editingCash = false;
  bool _submitting = false;

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
    final returnAmount = (_cashReceived - grandTotal).clamp(0, double.infinity);

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
                            _CustomerAndDateSection(
                              selectedDate: _saleDate,
                              customerNameController: _customerNameController,
                              onCustomerTap: _selectCustomer,
                              onDateTap: _selectSaleDate,
                            ),
                            const SizedBox(height: AppSpacing.xl),

                            _SalesReceiptCard(
                              lines: cartLines,
                              total: grandTotal,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _SalesTransactionAccountCard(
                              totalAmount: grandTotal,
                              paidController: _cashReceivedController,
                              remainingAmount: remaining.toDouble(),
                              returnAmount: returnAmount.toDouble(),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _PaymentMethodGrid(
                              selectedMethod: _paymentMethod,
                              onChanged: (method) {
                                setState(() {
                                  _paymentMethod = method;
                                });
                              },
                            ),
                          ],
                        ),
                ),
                _CompletePaymentButton(
                  enabled: cartLines.isNotEmpty && !_submitting,
                  submitting: _submitting,
                  onPressed: () =>
                      _confirmSale(cartLines: cartLines, checkout: checkout),
                ),
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
      final text = _bnNumber(_numberText(grandTotal));
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
    final normalized = _enNumber(
      value.replaceAll(',', '').replaceAll('৳', '').trim(),
    );
    if (normalized.isEmpty) {
      return 0;
    }
    return double.tryParse(normalized) ?? 0;
  }

  Future<void> _confirmSale({
    required List<SalesCartLine> cartLines,
    required SalesCheckoutState checkout,
  }) async {
    final subtotal = cartLines.fold<double>(
      0,
      (total, line) => total + line.lineTotal,
    );
    final grandTotal = checkout.grandTotal(subtotal);
    final paidAmount = _cashReceived.clamp(0, grandTotal).toDouble();
    final isDueSale = paidAmount < grandTotal;
    final isWalkInCustomer = _customerNameController.text.trim().isEmpty;

    if (isDueSale && isWalkInCustomer) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('বাকিতে বিক্রি করতে কাস্টমার সিলেক্ট/যোগ করুন'),
        ),
      );
      return;
    }

    setState(() {
      _submitting = true;
    });

    try {
      await ref
          .read(salesSaveServiceProvider)
          .saveSaleLocally(
            cartLines: cartLines,
            checkout: checkout,
            cashReceived: _cashReceived,
            paymentMethod: _paymentMethod.value,
            customerName: _customerNameController.text,
            customerMobile: _customerMobileController.text,
            saleDate: _saleDate,
          );

      ref.read(salesCartProvider.notifier).clear();
      ref.read(salesCheckoutProvider.notifier).clear();

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('বিক্রি সফলভাবে সেভ হয়েছে')));
      context.go(AppRoutes.dashboard);
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
          _submitting = false;
        });
      }
    }
  }

  Future<void> _selectSaleDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _saleDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 5, 12, 31),
      helpText: 'তারিখ নির্বাচন করুন',
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _saleDate = DateTime(
        selected.year,
        selected.month,
        selected.day,
        _saleDate.hour,
        _saleDate.minute,
        _saleDate.second,
      );
    });
  }

  Future<void> _selectCustomer() async {
    final selected = await showDialog<LocalCustomer>(
      context: context,
      builder: (context) =>
          _CustomerSelectionDialog(database: ref.read(appDatabaseProvider)),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _customerNameController.text = selected.name;
      _customerMobileController.text = selected.phone ?? '';
    });
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

class _CustomerAndDateSection extends StatelessWidget {
  const _CustomerAndDateSection({
    required this.selectedDate,
    required this.customerNameController,
    required this.onCustomerTap,
    required this.onDateTap,
  });

  final DateTime selectedDate;
  final TextEditingController customerNameController;
  final VoidCallback onCustomerTap;
  final VoidCallback onDateTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: customerNameController,
      builder: (context, value, child) {
        final selectedName = value.text.trim();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _TopSelectionField(
                label: 'কাস্টমার',
                value: selectedName.isEmpty
                    ? 'কাস্টমার সিলেক্ট করুন'
                    : selectedName,
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: onCustomerTap,
              ),
            ),
            const SizedBox(width: 2),
            _TopSelectionField(
              label: 'তারিখ',
              value: _dateOnly(selectedDate),
              icon: Icons.calendar_month_rounded,
              onTap: onDateTap,
              alignEnd: true,
              minWidth: 134,
            ),
          ],
        );
      },
    );
  }
}

class _TopSelectionField extends StatelessWidget {
  const _TopSelectionField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.alignEnd = false,
    this.minWidth,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final bool alignEnd;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth ?? 0),
      child: Column(
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppRadii.sm),
                border: Border.all(color: const Color(0xFF9AD9D3)),
              ),
              child: Row(
                mainAxisSize: minWidth == null
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                children: [
                  if (minWidth == null)
                    Expanded(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(icon, size: 20, color: AppColors.primaryContainer),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerDraft {
  const _CustomerDraft({required this.name, this.mobile, this.address});

  final String name;
  final String? mobile;
  final String? address;
}

class _AddCustomerDialog extends StatefulWidget {
  const _AddCustomerDialog();

  @override
  State<_AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<_AddCustomerDialog> {
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
      title: const Text('নতুন কাস্টমার'),
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
      _CustomerDraft(
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

class _CustomerSelectionDialog extends StatefulWidget {
  const _CustomerSelectionDialog({required this.database});

  final AppDatabase database;

  @override
  State<_CustomerSelectionDialog> createState() =>
      _CustomerSelectionDialogState();
}

class _CustomerSelectionDialogState extends State<_CustomerSelectionDialog> {
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
                const Expanded(
                  child: Text(
                    'কাস্টমার নির্বাচন করুন',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF004D40),
                    ),
                  ),
                ),
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
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'কাস্টমার সার্চ করুন...',
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
            child: StreamBuilder<List<LocalCustomer>>(
              stream: widget.database.watchCustomersForCurrentShop(),
              builder: (context, snapshot) {
                final customers = snapshot.data ?? const <LocalCustomer>[];
                final query = _searchQuery.toLowerCase();
                final filtered = customers.where((customer) {
                  final nameMatch = customer.name.toLowerCase().contains(query);
                  final mobileMatch =
                      customer.phone?.contains(_searchQuery) ?? false;
                  return nameMatch || mobileMatch;
                }).toList();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  );
                }

                if (filtered.isEmpty && _searchQuery.isNotEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('কোনো কাস্টমার পাওয়া যায়নি'),
                  );
                }

                if (filtered.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('কোনো কাস্টমার নেই'),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  itemBuilder: (context, index) {
                    final customer = filtered[index];
                    return ListTile(
                      onTap: () => Navigator.pop(context, customer),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE0F2F1),
                        child: Text(
                          customer.name.substring(0, 1),
                          style: const TextStyle(
                            color: Color(0xFF00695C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        customer.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      subtitle: customer.phone != null
                          ? Text(
                              _bnNumber(customer.phone!),
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
                final result = await showDialog<_CustomerDraft>(
                  context: context,
                  builder: (context) => const _AddCustomerDialog(),
                );

                if (result == null || !mounted) {
                  return;
                }

                try {
                  final newCustomer = await widget.database.createCustomer(
                    name: result.name,
                    phone: result.mobile,
                    address: result.address,
                  );
                  if (context.mounted) {
                    Navigator.pop(context, newCustomer);
                  }
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error.toString())));
                  }
                }
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text('নতুন কাস্টমার যুক্ত করুন'),
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

class SaleBreakdownCard extends StatelessWidget {
  const SaleBreakdownCard({
    required this.subtotal,
    required this.discount,
    required this.vat,
    required this.itemCount,
    super.key,
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
          BreakdownRow(
            label: 'পণ্য সংখ্যা',
            value: '${_bnNumber(itemCount)}টি',
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),

          const SizedBox(height: AppSpacing.sm),
          BreakdownRow(
            label: 'ডিসকাউন্ট',
            value: '- ${_money(discount)}',
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          BreakdownRow(
            label: 'ভ্যাট',
            value: _money(vat),
            textTheme: textTheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          BreakdownRow(
            label: 'মোট',
            value: _money(subtotal),
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }
}

class BreakdownRow extends StatelessWidget {
  const BreakdownRow({
    required this.label,
    required this.value,
    required this.textTheme,
    super.key,
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

class _SalesTransactionAccountCard extends StatelessWidget {
  const _SalesTransactionAccountCard({
    required this.totalAmount,
    required this.paidController,
    required this.remainingAmount,
    required this.returnAmount,
  });

  final double totalAmount;
  final TextEditingController paidController;
  final double remainingAmount;
  final double returnAmount;

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
          const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 18,
                color: Color(0xFF00695C),
              ),
              SizedBox(width: 8),
              Text(
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
                child: _LedgerInputField(
                  label: 'মোট বিল',
                  value: _numberText(totalAmount),
                  isReadOnly: true,
                  showTakaPrefix: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LedgerInputField(
                  label: 'পরিশোধিত (PAID)',
                  controller: paidController,
                  hint: '0.00',
                  showTakaPrefix: true,
                ),
              ),
            ],
          ),
          if (remainingAmount > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFB2DFDB).withValues(alpha: 0.5),
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
                  const Expanded(
                    child: Text(
                      'বকেয়া (DUE)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _money(remainingAmount),
                        style: const TextStyle(
                          color: Color(0xFFC62828),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
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
            ),
          ],
          if (returnAmount > 0) ...[
            const SizedBox(height: 12),
            _PaymentBalanceNotice(amount: returnAmount, isReturn: true),
          ],
        ],
      ),
    );
  }
}

class _PaymentBalanceNotice extends StatelessWidget {
  const _PaymentBalanceNotice({required this.amount, required this.isReturn});

  final double amount;
  final bool isReturn;

  @override
  Widget build(BuildContext context) {
    final color = isReturn ? const Color(0xFF00695C) : const Color(0xFFC62828);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF7F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFB2DFDB).withValues(alpha: 0.5),
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
            child: Icon(
              isReturn ? Icons.keyboard_return_rounded : Icons.more_horiz,
              color: const Color(0xFF00695C),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isReturn ? 'ফেরত (RETURN)' : 'বকেয়া (DUE)',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _money(amount),
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                isReturn ? 'কাস্টমারকে ফেরত দিন' : 'বকেয়া থাকলো',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LedgerInputField extends StatelessWidget {
  const _LedgerInputField({
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
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w900,
    );

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
          child: isReadOnly
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      if (showTakaPrefix)
                        Text(
                          '৳ ',
                          style: textStyle?.copyWith(
                            color: const Color(0xFF004D40),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          _bnNumber(value ?? ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                )
              : TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [const _BanglaNumberInputFormatter()],
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
                  style: textStyle,
                ),
        ),
      ],
    );
  }
}

class _BanglaNumberInputFormatter extends TextInputFormatter {
  const _BanglaNumberInputFormatter();

  static const _englishDigits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  static const _banglaDigits = [
    '০',
    '১',
    '২',
    '৩',
    '৪',
    '৫',
    '৬',
    '৭',
    '৮',
    '৯',
  ];

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final buffer = StringBuffer();
    var decimalSeen = false;
    var decimalPlaces = 0;

    for (final rune in newValue.text.runes) {
      final char = String.fromCharCode(rune);
      final englishIndex = _englishDigits.indexOf(char);
      final banglaIndex = _banglaDigits.indexOf(char);
      final isDigit = englishIndex != -1 || banglaIndex != -1;

      if (isDigit) {
        if (decimalSeen && decimalPlaces >= 2) {
          continue;
        }
        buffer.write(banglaIndex != -1 ? char : _banglaDigits[englishIndex]);
        if (decimalSeen) {
          decimalPlaces++;
        }
        continue;
      }

      if (char == '.' && !decimalSeen) {
        buffer.write(char);
        decimalSeen = true;
      }
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CashReceivedCard extends StatelessWidget {
  const CashReceivedCard({required this.controller, super.key});

  final TextEditingController controller;

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

class RemainingCard extends StatelessWidget {
  const RemainingCard({required this.remaining, super.key});

  final double remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ব্যাংক/কার্ড',
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

class PaymentMethodHeader extends StatelessWidget {
  const PaymentMethodHeader({super.key});

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
            icon: Icons.payments,
            label: 'নগদ টাকা',
            active: selectedMethod == _SalesPaymentMethod.cash,
            onTap: () => onChanged(_SalesPaymentMethod.cash),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _PaymentMethodCard(
            icon: Icons.more_horiz,
            label: 'ব্যাংক/কার্ড',
            active: selectedMethod == _SalesPaymentMethod.bankCard,
            onTap: () => onChanged(_SalesPaymentMethod.bankCard),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _PaymentMethodCard(
            icon: Icons.phone_android,
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
    final displayLabel = switch (icon) {
      Icons.payments => 'নগদ',
      Icons.more_horiz => 'ব্যাংক/কার্ড',
      Icons.phone_android => 'বিকাশ/নগদ',
      _ => label,
    };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF004D40) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFB2DFDB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? Colors.white : const Color(0xFF004D40),
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              displayLabel,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF004D40),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesReceiptCard extends StatelessWidget {
  const _SalesReceiptCard({required this.lines, required this.total});

  final List<SalesCartLine> lines;
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
              ],
            ),
          ),
          const Divider(height: 1),
          for (var i = 0; i < lines.length; i++) ...[
            _SaleProductItemRow(line: lines[i]),
            if (i < lines.length - 1)
              const Divider(height: 1, indent: 12, endIndent: 12),
          ],
          const _DashedDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'গ্র্যান্ড টোটাল',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'GRAND TOTAL',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Text(
                  _money(total),
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

class _SaleProductItemRow extends StatelessWidget {
  const _SaleProductItemRow({required this.line});

  final SalesCartLine line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_bnNumber(line.quantity)} টি × ${_money(line.unitPrice)}',
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
            _money(line.lineTotal),
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
          children: List.generate(
            dashCount,
            (index) => const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartItemsCard extends StatelessWidget {
  const CartItemsCard({
    required this.lines,
    required this.total,
    required this.onAddTap,
    super.key,
  });

  final List<SalesCartLine> lines;
  final double total;
  final VoidCallback onAddTap;

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
  const _CompletePaymentButton({
    required this.enabled,
    required this.submitting,
    required this.onPressed,
  });

  final bool enabled;
  final bool submitting;
  final VoidCallback onPressed;

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
              onPressed: enabled ? onPressed : null,
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
              icon: submitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.verified_rounded),
              label: Text(
                submitting ? 'সেভ হচ্ছে' : 'কনফার্ম পেমেন্ট',
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

String _dateOnly(DateTime value) {
  const months = [
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

  return '${_bnNumber(value.day)} ${months[value.month - 1]} ${_bnNumber(value.year)}';
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
