import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _ownerGivenTotalProvider = StreamProvider<double>((ref) {
  return ref
      .watch(appDatabaseProvider)
      .watchOwnerTransactionsForCurrentShop()
      .map(
        (entries) => entries
            .where((entry) => entry.isGiven)
            .fold<double>(0, (sum, entry) => sum + entry.amount),
      );
});

class OwnerGivingPage extends ConsumerStatefulWidget {
  const OwnerGivingPage({super.key});

  @override
  ConsumerState<OwnerGivingPage> createState() => _OwnerGivingPageState();
}

class _OwnerGivingPageState extends ConsumerState<OwnerGivingPage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  var _transactionDate = DateTime.now();
  var _saving = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalGiven = ref.watch(_ownerGivenTotalProvider).valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _OwnerGivingTopBar(),
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
                    _OwnerGivingSummaryCard(totalGiven: totalGiven),
                    const SizedBox(height: AppSpacing.lg),
                    _OwnerGivingFormCard(
                      amountController: _amountController,
                      noteController: _noteController,
                      transactionDate: _transactionDate,
                      onPickDate: _pickDate,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _OwnerGivingUpdateButton(
                      saving: _saving,
                      onPressed: _saving ? null : _saveOwnerGiving,
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

  Future<void> _saveOwnerGiving() async {
    final amount = _parseAmount(_amountController.text);
    if (amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('টাকার পরিমাণ দিন')));
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await ref
          .read(appDatabaseProvider)
          .saveOwnerGivenLocally(
            amount: amount,
            transactionDate: _transactionDate,
            note: _noteController.text,
          );

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('মালিকের টাকা সেভ হয়েছে')));
      context.pop();
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

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 5, 12, 31),
      initialDate: _transactionDate,
      helpText: 'তারিখ নির্বাচন করুন',
      cancelText: 'বাতিল',
      confirmText: 'ঠিক আছে',
    );
    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _transactionDate = DateTime(
        selected.year,
        selected.month,
        selected.day,
        _transactionDate.hour,
        _transactionDate.minute,
      );
    });
  }
}

class _OwnerGivingTopBar extends StatelessWidget {
  const _OwnerGivingTopBar();

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
                    'দিচ্ছি (Giving)',
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

class _OwnerGivingSummaryCard extends StatelessWidget {
  const _OwnerGivingSummaryCard({required this.totalGiven});

  final double totalGiven;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7E7),
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'মোট দেয়া',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFB43737),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _money(totalGiven),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color(0xFFB43737),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.payments_rounded, color: Color(0xFFB43737)),
          ),
        ],
      ),
    );
  }
}

class _OwnerGivingFormCard extends StatelessWidget {
  const _OwnerGivingFormCard({
    required this.amountController,
    required this.noteController,
    required this.transactionDate,
    required this.onPickDate,
  });

  final TextEditingController amountController;
  final TextEditingController noteController;
  final DateTime transactionDate;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
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
            'তারিখ',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPickDate,
              borderRadius: BorderRadius.circular(AppRadii.md),
              child: _OwnerInputShell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _dateOnly(transactionDate),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'টাকা দিচ্ছি',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _OwnerInputShell(
            child: TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: const Color(0xFFB43737),
                fontWeight: FontWeight.w800,
              ),
              decoration: const InputDecoration(
                prefixText: '৳ ',
                hintText: '0.00',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'নোট',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _OwnerInputShell(
            height: 132,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.notes_rounded, color: AppColors.textMuted),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: noteController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'কিছু না বলা বাকি...',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
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

class _OwnerInputShell extends StatelessWidget {
  const _OwnerInputShell({required this.child, this.height = 72});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: child,
    );
  }
}

class _OwnerGivingUpdateButton extends StatelessWidget {
  const _OwnerGivingUpdateButton({
    required this.saving,
    required this.onPressed,
  });

  final bool saving;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD9D9),
          foregroundColor: const Color(0xFFB43737),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
        ),
        child: saving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFB43737),
                ),
              )
            : Text(
                'আপডেট',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFFB43737),
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}

double _parseAmount(String value) {
  return double.tryParse(value.trim()) ?? 0;
}

String _money(double value) {
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
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
