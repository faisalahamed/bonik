import 'package:flutter/material.dart';
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
import 'add_product_category_page.dart';

class CashPurchasePage extends ConsumerStatefulWidget {
  const CashPurchasePage({super.key});

  @override
  ConsumerState<CashPurchasePage> createState() => _CashPurchasePageState();
}

class _CashPurchasePageState extends ConsumerState<CashPurchasePage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(appDatabaseProvider);
    final purchaseDraft = ref.watch(cashPurchaseDraftProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'পণ্য ক্রয়'),
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
          SafeArea(
            top: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    112,
                  ),
                  child: StreamBuilder<List<LocalCategory>>(
                    stream: database.watchProductCategoriesForCurrentShop(),
                    builder: (context, snapshot) {
                      final categories = _filterCategories(snapshot.data ?? []);

                      return ListView(
                        children: [
                          _PurchaseSearchBar(controller: _searchController),
                          const SizedBox(height: AppSpacing.lg),
                          _AddCategoryButton(onPressed: _showAddCategoryPage),
                          const SizedBox(height: AppSpacing.xl),
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting &&
                              categories.isEmpty)
                            const Center(child: CircularProgressIndicator())
                          else if (categories.isEmpty)
                            const _EmptyCategoryState()
                          else
                            for (var i = 0; i < categories.length; i++) ...[
                              _CategoryCard(
                                category: categories[i],
                                isSelected: purchaseDraft.lines.containsKey(
                                  categories[i].id,
                                ),
                                onTap: () =>
                                    _toggleCategorySelection(categories[i]),
                              ),
                              if (i != categories.length - 1)
                                const SizedBox(height: AppSpacing.md),
                            ],
                        ],
                      );
                    },
                  ),
                ),
                _PurchaseBottomBar(
                  itemCount: _cartItemCount,
                  onContinue: _openPurchaseReview,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<LocalCategory> _filterCategories(List<LocalCategory> categories) {
    if (_query.isEmpty) {
      return categories;
    }

    return categories
        .where((category) => category.name.toLowerCase().contains(_query))
        .toList();
  }

  Future<void> _showAddCategoryPage() async {
    final draft = await showDialog<AddProductCategoryDraft>(
      context: context,
      useSafeArea: false,
      builder: (context) => const AddProductCategoryPage(),
    );

    if (draft == null || draft.name.trim().isEmpty) {
      return;
    }

    if (!mounted) {
      return;
    }

    try {
      await ref
          .read(appDatabaseProvider)
          .createProductCategory(draft.name, details: draft.details);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  int get _cartItemCount {
    return ref.read(cashPurchaseDraftProvider).lines.length;
  }

  void _toggleCategorySelection(LocalCategory category) {
    final draft = ref.read(cashPurchaseDraftProvider);
    final controller = ref.read(cashPurchaseDraftProvider.notifier);

    if (draft.lines.containsKey(category.id)) {
      controller.removeCategory(category.id);
      return;
    }

    controller.addCategory(category);
  }

  void _openPurchaseReview() {
    final selectedCategories = ref
        .read(cashPurchaseDraftProvider)
        .selectedLines
        .map((line) => line.category)
        .toList(growable: false);

    if (selectedCategories.isEmpty) {
      return;
    }

    context.push(AppRoutes.cashPurchaseReview, extra: selectedCategories);
  }
}

class _PurchaseSearchBar extends StatelessWidget {
  const _PurchaseSearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search product category...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.textMuted,
                ),
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF5FAF8),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(Icons.tune_rounded, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _AddCategoryButton extends StatelessWidget {
  const _AddCategoryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: AppShadows.button,
      ),
      child: SizedBox(
        height: 64,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
          ),
          child: Text(
            'প্রোডাক্ট ক্যাটাগরি বা নাম যোগ করুন',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final LocalCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = category.syncStatus == 'pending';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.05)
                : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            border: isSelected
                ? Border.all(color: AppColors.primary.withValues(alpha: 0.18))
                : null,
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            children: [
              if (isPending)
                Container(
                  width: 4,
                  height: 72,
                  margin: const EdgeInsets.only(right: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF1C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.blur_on_rounded,
                  color: Color(0xFFD88400),
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isPending ? 'সিঙ্ক অপেক্ষায়' : category.details ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              else
                const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCategoryState extends StatelessWidget {
  const _EmptyCategoryState();

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
        'কোনো প্রোডাক্ট ক্যাটাগরি নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PurchaseBottomBar extends StatelessWidget {
  const _PurchaseBottomBar({required this.itemCount, required this.onContinue});

  final int itemCount;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 86,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  boxShadow: AppShadows.soft,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6FAF8),
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: const Icon(
                        Icons.shopping_basket_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$itemCount টি\n',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: itemCount > 0
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            TextSpan(
                              text: 'আইটেম',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: itemCount > 0
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(AppRadii.xl),
                boxShadow: AppShadows.button,
              ),
              child: SizedBox(
                width: 162,
                height: 86,
                child: ElevatedButton(
                  onPressed: itemCount == 0 ? null : onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white.withValues(
                      alpha: 0.58,
                    ),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.xl),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'এগিয়ে যান',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
