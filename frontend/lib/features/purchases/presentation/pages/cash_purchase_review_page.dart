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
import '../../../auth/presentation/widgets/auth_top_bar.dart';
import '../../application/cash_purchase_draft_controller.dart';

class CashPurchaseReviewPage extends ConsumerStatefulWidget {
  const CashPurchaseReviewPage({super.key, required this.selectedCategories});

  final List<LocalCategory> selectedCategories;

  @override
  ConsumerState<CashPurchaseReviewPage> createState() =>
      _CashPurchaseReviewPageState();
}

class _CashPurchaseReviewPageState
    extends ConsumerState<CashPurchaseReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, _PurchaseLineDraft> _draftsByCategoryId = {};
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _syncDraftControllers(ref.read(cashPurchaseDraftProvider).selectedLines);
    _commentController = TextEditingController(
      text: ref.read(cashPurchaseDraftProvider).comment,
    )..addListener(_syncComment);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ref
          .read(cashPurchaseDraftProvider.notifier)
          .addCategories(widget.selectedCategories);
    });
  }

  @override
  void dispose() {
    for (final draft in _draftsByCategoryId.values) {
      draft.dispose();
    }
    _commentController
      ..removeListener(_syncComment)
      ..dispose();
    super.dispose();
  }

  List<_PurchaseLineDraft> get _drafts => _draftsByCategoryId.values.toList();

  double get _purchaseTotal {
    return _drafts.fold(0, (total, draft) => total + draft.purchaseTotal);
  }

  double get _profitTotal {
    return _drafts.fold(0, (total, draft) => total + draft.profitTotal);
  }

  String get _purchaseTotalText {
    final filledDrafts = _drafts
        .where((draft) => draft.quantity > 0 && draft.buyingPrice > 0)
        .toList();

    if (filledDrafts.length == 1) {
      final draft = filledDrafts.first;
      return '${_number(draft.quantity)} × ${_money(draft.buyingPrice)} = ${_money(draft.purchaseTotal)}';
    }

    return _money(_purchaseTotal);
  }

  String get _profitTotalText {
    final filledDrafts = _drafts
        .where(
          (draft) =>
              draft.quantity > 0 &&
              draft.buyingPrice > 0 &&
              draft.sellingPrice > 0,
        )
        .toList();

    if (filledDrafts.length == 1) {
      final draft = filledDrafts.first;
      final profitPerItem = draft.sellingPrice - draft.buyingPrice;
      return '${_number(draft.quantity)} × ${_money(profitPerItem)} = ${_money(draft.profitTotal)}';
    }

    return _money(_profitTotal);
  }

  void _refreshTotals() {
    setState(() {});
  }

  void _syncComment() {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .setComment(_commentController.text);
  }

  void _syncDraftControllers(List<CashPurchaseDraftLine> lines) {
    final categoryIds = lines.map((line) => line.category.id).toSet();
    final removedIds = _draftsByCategoryId.keys
        .where((categoryId) => !categoryIds.contains(categoryId))
        .toList();

    for (final categoryId in removedIds) {
      _draftsByCategoryId.remove(categoryId)?.dispose();
    }

    for (final line in lines) {
      _draftsByCategoryId.putIfAbsent(
        line.category.id,
        () => _PurchaseLineDraft(
          line: line,
          onChanged: _updateDraftLine,
          onRefresh: _refreshTotals,
        ),
      );
    }
  }

  void _updateDraftLine(_PurchaseLineDraft draft) {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .updateLine(
          categoryId: draft.category.id,
          quantity: draft.quantityController.text,
          buyingPrice: draft.buyingPriceController.text,
          sellingPrice: draft.sellingPriceController.text,
        );
  }

  void _removeLine(_PurchaseLineDraft draft) {
    ref
        .read(cashPurchaseDraftProvider.notifier)
        .removeCategory(draft.category.id);
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

  void _continueToPayment() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('সব বাধ্যতামূলক তথ্য পূরণ করুন।')),
      );
      return;
    }

    context.push(
      AppRoutes.cashPurchasePayment,
      extra: _drafts.map((draft) => draft.toInput()).toList(growable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final purchaseDraft = ref.watch(cashPurchaseDraftProvider);
    _syncDraftControllers(purchaseDraft.selectedLines);
    final hasItems = _drafts.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'ক্রয় রিভিউ'),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const _BackgroundGlow(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                  114,
                ),
                child: ListView(
                  children: [
                    _PurchaseDateCard(
                      date: purchaseDraft.purchaseDate,
                      onTap: () =>
                          _changePurchaseDate(purchaseDraft.purchaseDate),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (!hasItems)
                      const _EmptyPurchaseReviewState()
                    else
                      for (var i = 0; i < _drafts.length; i++) ...[
                        _PurchaseReviewItem(
                          draft: _drafts[i],
                          itemNumber: i + 1,
                          onRemove: () => _removeLine(_drafts[i]),
                        ),
                        if (i != _drafts.length - 1)
                          const SizedBox(height: AppSpacing.md),
                      ],
                    const SizedBox(height: AppSpacing.lg),
                    _PurchaseSummaryCard(
                      itemCount: _drafts.length,
                      purchaseTotalText: _purchaseTotalText,
                      profitTotalText: _profitTotalText,
                      profitTotal: _profitTotal,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _PurchaseCommentCard(controller: _commentController),
                  ],
                ),
              ),
            ),
            _PurchaseReviewBottomAction(
              isEnabled: hasItems,
              onContinue: _continueToPayment,
            ),
          ],
        ),
      ),
    );
  }
}

class CashPurchaseLineInput {
  const CashPurchaseLineInput({
    required this.category,
    required this.quantity,
    required this.buyingPrice,
    required this.sellingPrice,
  });

  final LocalCategory category;
  final double quantity;
  final double buyingPrice;
  final double sellingPrice;
}

class _PurchaseLineDraft {
  _PurchaseLineDraft({
    required CashPurchaseDraftLine line,
    required this.onChanged,
    required this.onRefresh,
  }) : category = line.category {
    quantityController.text = line.quantity;
    buyingPriceController.text = line.buyingPrice;
    sellingPriceController.text = line.sellingPrice;
    if (line.buyingPriceValue > 0 && line.sellingPriceValue > 0) {
      profitController.text = _number(
        line.sellingPriceValue - line.buyingPriceValue,
      );
    }
    quantityController.addListener(_onQuantityChanged);
    buyingPriceController.addListener(_onBuyingPriceChanged);
    sellingPriceController.addListener(_onSellingPriceChanged);
    profitController.addListener(_onProfitChanged);
  }

  final LocalCategory category;
  final ValueChanged<_PurchaseLineDraft> onChanged;
  final VoidCallback onRefresh;
  final quantityController = TextEditingController();
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final profitController = TextEditingController();

  double get quantity => _parse(quantityController.text);
  double get buyingPrice => _parse(buyingPriceController.text);
  double get sellingPrice => _parse(sellingPriceController.text);
  double get profitPerItem => _parse(profitController.text);
  double get purchaseTotal => quantity * buyingPrice;
  double get profitTotal => quantity * (sellingPrice - buyingPrice);
  double get profitPercent {
    if (buyingPrice <= 0 || sellingPrice <= 0) {
      return 0;
    }

    return ((sellingPrice - buyingPrice) / buyingPrice) * 100;
  }

  bool get hasLowerSellingPrice =>
      buyingPrice > 0 && sellingPrice > 0 && sellingPrice < buyingPrice;

  CashPurchaseLineInput toInput() {
    return CashPurchaseLineInput(
      category: category,
      quantity: quantity,
      buyingPrice: buyingPrice,
      sellingPrice: sellingPrice,
    );
  }

  void dispose() {
    quantityController
      ..removeListener(_onQuantityChanged)
      ..dispose();
    buyingPriceController
      ..removeListener(_onBuyingPriceChanged)
      ..dispose();
    sellingPriceController
      ..removeListener(_onSellingPriceChanged)
      ..dispose();
    profitController
      ..removeListener(_onProfitChanged)
      ..dispose();
  }

  void _onQuantityChanged() {
    onChanged(this);
    onRefresh();
  }

  void _onBuyingPriceChanged() {
    if (sellingPriceController.text.trim().isNotEmpty) {
      _setSyncedText(profitController, _number(sellingPrice - buyingPrice));
    } else if (profitController.text.trim().isNotEmpty) {
      _setSyncedText(
        sellingPriceController,
        _number(buyingPrice + profitPerItem),
      );
    }

    onChanged(this);
    onRefresh();
  }

  void _onSellingPriceChanged() {
    if (buyingPriceController.text.trim().isNotEmpty &&
        sellingPriceController.text.trim().isNotEmpty) {
      _setSyncedText(profitController, _number(sellingPrice - buyingPrice));
    }

    onChanged(this);
    onRefresh();
  }

  void _onProfitChanged() {
    if (buyingPriceController.text.trim().isNotEmpty &&
        profitController.text.trim().isNotEmpty) {
      _setSyncedText(
        sellingPriceController,
        _number(buyingPrice + profitPerItem),
      );
    }

    onChanged(this);
    onRefresh();
  }

  double _parse(String text) {
    return double.tryParse(text.trim()) ?? 0;
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
            width: 250,
            height: 250,
            decoration: const BoxDecoration(
              gradient: AppGradients.backgroundGlowTop,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -90,
          child: Container(
            width: 280,
            height: 280,
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

class _PurchaseDateCard extends StatelessWidget {
  const _PurchaseDateCard({required this.date, required this.onTap});

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateText =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                color: AppColors.textMuted,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  dateText,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.event_available_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseReviewItem extends StatelessWidget {
  const _PurchaseReviewItem({
    required this.draft,
    required this.itemNumber,
    required this.onRemove,
  });

  final _PurchaseLineDraft draft;
  final int itemNumber;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final category = draft.category;
    final details = category.details?.trim();

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
            height: 300,
            decoration: BoxDecoration(
              color: category.syncStatus == 'pending'
                  ? AppColors.secondary
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F2F38),
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                      child: const Icon(
                        Icons.inventory_2_rounded,
                        color: Color(0xFFFFC857),
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            details?.isNotEmpty == true
                                ? details!
                                : 'নির্বাচিত পণ্য',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _TotalPriceLabel(total: draft.purchaseTotal),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'পণ্যের নোট বা ধরন',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                _NoteBox(text: '${category.name} - $itemNumber'),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _RequiredNumberField(
                        controller: draft.quantityController,
                        label: 'পরিমাণ',
                        hintText: '0',
                        suffixText: 'টি',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _RequiredNumberField(
                        controller: draft.buyingPriceController,
                        label: 'ক্রয় মূল্য / প্রতি আইটেম',
                        hintText: '0',
                        prefixText: '৳ ',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _RequiredNumberField(
                        controller: draft.sellingPriceController,
                        label: 'বিক্রয় মূল্য / প্রতি আইটেম',
                        hintText: '0',
                        prefixText: '৳ ',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _RequiredNumberField(
                        controller: draft.profitController,
                        label: 'লাভ / প্রতি আইটেম',
                        hintText: '0',
                        prefixText: '৳ ',
                        suffixText: _percent(draft.profitPercent),
                        allowNegative: true,
                        isRequired: false,
                      ),
                    ),
                  ],
                ),
                if (draft.hasLowerSellingPrice) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _PriceWarning(
                    message:
                        'বিক্রয় মূল্য ক্রয় মূল্যের চেয়ে কম। এই আইটেমে ক্ষতি হবে।',
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _ActionChip(
                      icon: Icons.qr_code_2_rounded,
                      label: 'বারকোড যোগ করুন',
                      color: AppColors.textSecondary,
                      backgroundColor: AppColors.surfaceContainerLow,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _ActionChip(
                      icon: Icons.delete_outline_rounded,
                      label: 'মুছুন',
                      color: const Color(0xFFD9534F),
                      backgroundColor: const Color(0xFFFFF0F0),
                      onTap: onRemove,
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

class _TotalPriceLabel extends StatelessWidget {
  const _TotalPriceLabel({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'মোট দাম',
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _money(total),
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _RequiredNumberField extends StatelessWidget {
  const _RequiredNumberField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.prefixText,
    this.suffixText,
    this.allowNegative = false,
    this.isRequired = true,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? prefixText;
  final String? suffixText;
  final bool allowNegative;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          allowNegative
              ? RegExp(r'^-?\d*\.?\d{0,2}$')
              : RegExp(r'^\d*\.?\d{0,2}$'),
        ),
      ],
      validator: (value) {
        final text = value?.trim() ?? '';
        final number = double.tryParse(text);
        if (!isRequired && text.isEmpty) {
          return null;
        }
        if (text.isEmpty) {
          return 'আবশ্যক';
        }
        if (number == null) {
          return 'সঠিক সংখ্যা দিন';
        }
        if (isRequired && number <= 0) {
          return '০ এর বেশি দিন';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixText: prefixText,
        suffixText: suffixText,
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        errorMaxLines: 2,
        labelStyle: textTheme.labelSmall?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PriceWarning extends StatelessWidget {
  const _PriceWarning({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: const Color(0xFFFFB84D)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFB26A00),
            size: 18,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF7A4A00),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteBox extends StatelessWidget {
  const _NoteBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseSummaryCard extends StatelessWidget {
  const _PurchaseSummaryCard({
    required this.itemCount,
    required this.purchaseTotalText,
    required this.profitTotalText,
    required this.profitTotal,
  });

  final int itemCount;
  final String purchaseTotalText;
  final String profitTotalText;
  final double profitTotal;

  @override
  Widget build(BuildContext context) {
    final profitColor = profitTotal < 0
        ? const Color(0xFFD9534F)
        : AppColors.primary;

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
          // _SummaryRow(label: 'আইটেম', value: '$itemCount'),
          const SizedBox(height: AppSpacing.md),
          _SummaryRow(label: 'মোট ক্রয়', value: purchaseTotalText),
          const SizedBox(height: AppSpacing.md),

          const SizedBox(height: AppSpacing.lg),
          _SummaryRow(
            label: 'সম্ভাব্য মোট লাভ',
            value: profitTotalText,
            valueColor: profitColor,
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
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: textTheme.titleMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _PurchaseCommentCard extends StatelessWidget {
  const _PurchaseCommentCard({required this.controller});

  final TextEditingController controller;

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
            'মন্তব্য',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'অর্ডার বা বাজার সম্পর্কে নোট লিখুন...',
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPurchaseReviewState extends StatelessWidget {
  const _EmptyPurchaseReviewState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Text(
        'কোনো পণ্য নির্বাচন করা হয়নি।',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PurchaseReviewBottomAction extends StatelessWidget {
  const _PurchaseReviewBottomAction({
    required this.isEnabled,
    required this.onContinue,
  });

  final bool isEnabled;
  final VoidCallback onContinue;

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
            child: ElevatedButton(
              onPressed: isEnabled ? onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white.withValues(alpha: 0.58),
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
  final normalized = value == -0 ? 0.0 : value;
  final text = _number(normalized);
  return '৳ $text';
}

String _percent(double value) {
  final normalized = value == -0 ? 0.0 : value;
  final text = _number(normalized);
  return '$text%';
}

String _number(double value) {
  final normalized = value == -0 ? 0.0 : value;
  final text = normalized % 1 == 0
      ? normalized.toStringAsFixed(0)
      : normalized.toStringAsFixed(2);
  return text;
}

void _setSyncedText(TextEditingController controller, String text) {
  if (controller.text == text) {
    return;
  }

  controller.value = TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: text.length),
  );
}
