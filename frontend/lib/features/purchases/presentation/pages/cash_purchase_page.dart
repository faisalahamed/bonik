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
import '../../application/cash_purchase_draft_controller.dart';

class AddProductCategoryDraft {
  const AddProductCategoryDraft({required this.name, this.details});

  final String name;
  final String? details;
}

enum _CategorySortMode { nameAsc, nameDesc, newest, oldest }

class CashPurchasePage extends ConsumerStatefulWidget {
  const CashPurchasePage({super.key});

  @override
  ConsumerState<CashPurchasePage> createState() => _CashPurchasePageState();
}

class _CashPurchasePageState extends ConsumerState<CashPurchasePage> {
  final _searchController = TextEditingController();
  String _query = '';
  _CategorySortMode _sortMode = _CategorySortMode.nameAsc;

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
      body: Column(
        children: [
          _PurchaseTopBar(itemCount: purchaseDraft.lines.length),
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
                StreamBuilder<List<LocalCategory>>(
                  stream: database.watchProductCategoriesForCurrentShop(),
                  builder: (context, snapshot) {
                    final categories = _filterCategories(snapshot.data ?? []);

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        100,
                      ),
                      children: [
                        _PurchaseSearchBar(controller: _searchController),
                        const SizedBox(height: AppSpacing.lg),
                        _PurchaseActionRow(
                          onShowDialog: _showAddCategoryDialog,
                          onNavigate: _navigateToManageCategories,
                          onSort: _cycleSortMode,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _SortStatusLabel(label: _sortModeLabel),
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
              ],
            ),
          ),
          _PurchaseBottomAction(
            onPressed: _openPurchaseReview,
            enabled: purchaseDraft.lines.isNotEmpty,
          ),
        ],
      ),
    );
  }

  List<LocalCategory> _filterCategories(List<LocalCategory> categories) {
    final filtered = _query.isEmpty
        ? List<LocalCategory>.of(categories)
        : categories
              .where((category) => category.name.toLowerCase().contains(_query))
              .toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case _CategorySortMode.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case _CategorySortMode.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case _CategorySortMode.newest:
          return b.createdAt.compareTo(a.createdAt);
        case _CategorySortMode.oldest:
          return a.createdAt.compareTo(b.createdAt);
      }
    });

    return filtered;
  }

  String get _sortModeLabel {
    switch (_sortMode) {
      case _CategorySortMode.nameAsc:
        return 'Sort: A-Z';
      case _CategorySortMode.nameDesc:
        return 'Sort: Z-A';
      case _CategorySortMode.newest:
        return 'Sort: Newest first';
      case _CategorySortMode.oldest:
        return 'Sort: Oldest first';
    }
  }

  void _cycleSortMode() {
    setState(() {
      _sortMode = switch (_sortMode) {
        _CategorySortMode.nameAsc => _CategorySortMode.nameDesc,
        _CategorySortMode.nameDesc => _CategorySortMode.newest,
        _CategorySortMode.newest => _CategorySortMode.oldest,
        _CategorySortMode.oldest => _CategorySortMode.nameAsc,
      };
    });
  }

  Future<void> _showAddCategoryDialog() async {
    final draft = await showDialog<AddProductCategoryDraft>(
      context: context,
      builder: (context) => const _AddCategoryDialog(),
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

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ক্যাটাগরি সফলভাবে যোগ করা হয়েছে')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void _navigateToManageCategories() {
    context.push(AppRoutes.manageProductCategories);
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

class _PurchaseTopBar extends StatelessWidget {
  const _PurchaseTopBar({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'পণ্য ক্রয়',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$itemCount',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseSearchBar extends StatelessWidget {
  const _PurchaseSearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search product category...',
                hintStyle: TextStyle(color: AppColors.textMuted),
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseActionRow extends StatelessWidget {
  const _PurchaseActionRow({
    required this.onShowDialog,
    required this.onNavigate,
    required this.onSort,
  });

  final VoidCallback onShowDialog;
  final VoidCallback onNavigate;
  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallActionIconButton(icon: Icons.sort_rounded, onPressed: onSort),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.button,
            ),
            child: InkWell(
              onTap: onShowDialog,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'প্রোডক্ট ক্যাটাগরি যোগ করুন',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SmallActionIconButton(
          icon: Icons.add_box_outlined,
          onPressed: onNavigate,
        ),
      ],
    );
  }
}

class _SortStatusLabel extends StatelessWidget {
  const _SortStatusLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SmallActionIconButton extends StatelessWidget {
  const _SmallActionIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.textPrimary),
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF1F7F6) : Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
        border: isSelected
            ? const Border(left: BorderSide(color: AppColors.primary, width: 4))
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 42,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFE082)
                      : const Color(0xFFB2DFDB),
                  borderRadius: BorderRadius.circular(4),
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
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.details?.toUpperCase() ?? 'NO DETAILS',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: AppSpacing.sm,
              //         vertical: 4,
              //       ),
              //       decoration: BoxDecoration(
              //         color: const Color(0xFFE0F2F1),
              //         borderRadius: BorderRadius.circular(99),
              //       ),
              //       child: Text(
              //         '১২০ টি',
              //         style: textTheme.labelMedium?.copyWith(
              //           color: AppColors.primary,
              //           fontWeight: FontWeight.w800,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(height: 2),
              //     Text(
              //       'স্টক আছে',
              //       style: textTheme.labelSmall?.copyWith(
              //         color: AppColors.textMuted,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.chevron_right_rounded,
                color: isSelected ? AppColors.textMuted : AppColors.primary,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseBottomAction extends StatelessWidget {
  const _PurchaseBottomAction({required this.onPressed, required this.enabled});

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.surfaceContainer)),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            color: enabled
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            boxShadow: AppShadows.button,
          ),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(AppRadii.lg),
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
                const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ],
            ),
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

class _AddCategoryDialog extends StatefulWidget {
  const _AddCategoryDialog();

  @override
  State<_AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<_AddCategoryDialog> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.add_box_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'নতুন ক্যাটাগরি',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'ক্যাটাগরির নাম',
                hintText: 'উদা: ইলেকট্রনিক্স',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                prefixIcon: const Icon(Icons.label_outline_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _detailsController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'বিস্তারিত (ঐচ্ছিক)',
                hintText: 'ক্যাটাগরি সম্পর্কে কিছু লিখুন...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                prefixIcon: const Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('বাতিল'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.trim();
                      if (name.isEmpty) return;
                      Navigator.pop(
                        context,
                        AddProductCategoryDraft(
                          name: name,
                          details: _detailsController.text.trim(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                    ),
                    child: const Text('সেভ করুন'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
