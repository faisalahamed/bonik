import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

class DuesGivingPage extends ConsumerStatefulWidget {
  const DuesGivingPage({super.key, this.entry});

  final LocalDuesLedgerEntry? entry;

  @override
  ConsumerState<DuesGivingPage> createState() => _DuesGivingPageState();
}

class _DuesGivingPageState extends ConsumerState<DuesGivingPage> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late DateTime _paymentDate;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _paymentDate = DateTime.now();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _GivingTopBar(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    108,
                  ),
                  child: ListView(
                    children: [
                      _TotalGivenCard(entry: widget.entry),
                      const SizedBox(height: AppSpacing.lg),
                      _GivingFormCard(
                        amountController: _amountController,
                        noteController: _noteController,
                        paymentDate: _paymentDate,
                        onSelectDate: _selectDate,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
                _UpdateButton(saving: _saving, onPressed: _savePayment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _paymentDate,
      helpText: 'তারিখ নির্বাচন করুন',
      cancelText: 'বাতিল',
      confirmText: 'ঠিক আছে',
    );
    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _paymentDate = selected;
    });
  }

  Future<void> _savePayment() async {
    final entry = widget.entry;
    if (entry == null) {
      _showMessage('বাকির তথ্য পাওয়া যায়নি।');
      return;
    }

    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    setState(() => _saving = true);
    try {
      await ref
          .read(appDatabaseProvider)
          .saveDueGivingPayment(
            entry: entry,
            amount: amount,
            paymentDate: _paymentDate,
            note: _noteController.text,
          );
      if (!mounted) {
        return;
      }
      _showMessage('পেমেন্ট সেভ হয়েছে');
      Navigator.of(context).maybePop();
    } catch (error) {
      if (mounted) {
        _showMessage(error.toString().replaceFirst('Bad state: ', ''));
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _GivingTopBar extends StatelessWidget {
  const _GivingTopBar();

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

class _TotalGivenCard extends StatelessWidget {
  const _TotalGivenCard({required this.entry});

  final LocalDuesLedgerEntry? entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final amount = entry?.dueAmount ?? 0;
    final title = entry == null
        ? 'মোট ব্যালেন্স'
        : entry!.isReceivable
        ? 'পাওনা ব্যালেন্স'
        : 'দেনা ব্যালেন্স';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0E0),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    color: const Color(0xFFB24B4B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _money(amount),
                  style: textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFFB72828),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF3F3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.payments_rounded, color: Color(0xFFB72828)),
          ),
        ],
      ),
    );
  }
}

class _GivingFormCard extends StatelessWidget {
  const _GivingFormCard({
    required this.amountController,
    required this.noteController,
    required this.paymentDate,
    required this.onSelectDate,
  });

  final TextEditingController amountController;
  final TextEditingController noteController;
  final DateTime paymentDate;
  final VoidCallback onSelectDate;

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
            'তারিখ',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSelectDate,
              borderRadius: BorderRadius.circular(AppRadii.md),
              child: _InputShell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _dateOnly(paymentDate),
                        style: textTheme.titleMedium?.copyWith(
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
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
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
                Text(
                  '৳',
                  style: textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFFB72828),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      border: InputBorder.none,
                      hintStyle: textTheme.headlineLarge?.copyWith(
                        color: AppColors.textMuted.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'নোট',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _InputShell(
            minHeight: 120,
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
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'কিসের জন্য বাকি...',
                      border: InputBorder.none,
                      hintStyle: textTheme.titleMedium?.copyWith(
                        color: AppColors.textMuted.withValues(alpha: 0.65),
                        fontWeight: FontWeight.w600,
                      ),
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

class _InputShell extends StatelessWidget {
  const _InputShell({required this.child, this.minHeight});

  final Widget child;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: child,
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({required this.saving, required this.onPressed});

  final bool saving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: Container(
          width: double.infinity,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD9D9),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            boxShadow: AppShadows.soft,
          ),
          child: TextButton(
            onPressed: saving ? null : onPressed,
            child: Text(
              saving ? 'সেভ হচ্ছে...' : 'আপডেট',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFFB72828),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _money(double value) {
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
  return '৳ ${_banglaNumber(fixed)}';
}

String _dateOnly(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return _banglaNumber('$day/$month/${value.year}');
}

String _banglaNumber(String value) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

  var result = value;
  for (var i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], bangla[i]);
  }
  return result;
}
