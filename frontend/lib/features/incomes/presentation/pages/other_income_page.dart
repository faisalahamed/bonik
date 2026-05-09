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
import '../../application/income_providers.dart';
import 'other_income_categories_page.dart';

class OtherIncomePage extends ConsumerStatefulWidget {
  const OtherIncomePage({super.key});

  @override
  ConsumerState<OtherIncomePage> createState() => _OtherIncomePageState();
}

enum _IncomeSortMode { nameAsc, nameDesc, newest, oldest }

class _OtherIncomePageState extends ConsumerState<OtherIncomePage> {
  final _searchController = TextEditingController();
  var _query = '';
  _IncomeSortMode _sortMode = _IncomeSortMode.nameAsc;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  void _cycleSortMode() {
    setState(() {
      _sortMode = _IncomeSortMode
          .values[(_sortMode.index + 1) % _IncomeSortMode.values.length];
    });
  }

  Future<void> _showAddCategoryDialog() async {
    final draft = await showDialog<AddIncomeCategoryDraft>(
      context: context,
      builder: (context) => const AddIncomeCategoryDialog(),
    );

    if (draft == null || draft.name.trim().isEmpty) return;

    try {
      await ref.read(appDatabaseProvider).createIncomeCategory(
            draft.name,
            details: draft.details,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('নতুন আয়ের খাত যোগ করা হয়েছে')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('এরর: $error')),
      );
    }
  }


  String get _sortModeLabel {
    switch (_sortMode) {
      case _IncomeSortMode.nameAsc:
        return 'নাম (A-Z)';
      case _IncomeSortMode.nameDesc:
        return 'নাম (Z-A)';
      case _IncomeSortMode.newest:
        return 'নতুন আগে';
      case _IncomeSortMode.oldest:
        return 'পুরোনো আগে';
    }
  }

  List<LocalCategory> _filterCategories(List<LocalCategory> categories) {
    final filtered = _query.isEmpty
        ? List<LocalCategory>.of(categories)
        : categories
            .where(
              (item) => item.name.toLowerCase().contains(_query),
            )
            .toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case _IncomeSortMode.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case _IncomeSortMode.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case _IncomeSortMode.newest:
          return b.createdAt.compareTo(a.createdAt);
        case _IncomeSortMode.oldest:
          return a.createdAt.compareTo(b.createdAt);
      }
    });

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(incomeCategoriesProvider);
    final todayTotalAsync = ref.watch(todayIncomeTotalProvider);
    final todayTotal = todayTotalAsync.valueOrNull ?? 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _OtherIncomeTopBar(),
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
                categoriesAsync.when(
                  data: (items) {
                    final filtered = _filterCategories(items);
                    return ListView(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      children: [
                        _IncomeSummaryCard(total: todayTotal),
                        const SizedBox(height: AppSpacing.xl),
                        _OtherIncomeSearchBar(controller: _searchController),
                        const SizedBox(height: AppSpacing.lg),
                        _OtherIncomeActionRow(
                          onSort: _cycleSortMode,
                          onAdd: _showAddCategoryDialog,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _SortStatusLabel(label: _sortModeLabel),
                        const SizedBox(height: AppSpacing.xl),
                        if (filtered.isEmpty)
                          const _EmptyIncomeCategoryCard(
                            message: 'কোনো আয়ের খাত পাওয়া যায়নি।',
                          )
                        else
                          for (var i = 0; i < filtered.length; i++) ...[
                            _IncomeCategoryCard(
                              name: filtered[i].name,
                              onTap: () => context.push(
                                '${AppRoutes.otherIncomeCreate}/${Uri.encodeComponent(filtered[i].name)}',
                              ),
                            ),
                            if (i != filtered.length - 1)
                              const SizedBox(height: AppSpacing.md),
                          ],
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => ListView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    children: [
                      _IncomeSummaryCard(total: todayTotal),
                      const SizedBox(height: AppSpacing.xl),
                      _OtherIncomeSearchBar(controller: _searchController),
                      const SizedBox(height: AppSpacing.lg),
                      _OtherIncomeActionRow(
                        onSort: _cycleSortMode,
                        onAdd: _showAddCategoryDialog,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SortStatusLabel(label: _sortModeLabel),
                      const SizedBox(height: AppSpacing.xl),
                      _EmptyIncomeCategoryCard(
                        message: 'আয়ের খাত লোড করা যায়নি: $error',
                      ),
                    ],
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

class _OtherIncomeTopBar extends StatelessWidget {
  const _OtherIncomeTopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Text(
                  'আয় যোগ করুন',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IncomeSummaryCard extends StatelessWidget {
  const _IncomeSummaryCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'আজকের মোট আয়',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${total.toStringAsFixed(0)}৳',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // TODO: Navigate to income list
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'আয়ের তালিকা',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtherIncomeSearchBar extends StatelessWidget {
  const _OtherIncomeSearchBar({required this.controller});

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
                hintText: 'খোঁজ করুন...',
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

class _OtherIncomeActionRow extends StatelessWidget {
  const _OtherIncomeActionRow({required this.onSort, required this.onAdd});

  final VoidCallback onSort;
  final VoidCallback onAdd;

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
              onTap: onAdd,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'নতুন আয়ের খাত',
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
          onPressed: () => context.push(AppRoutes.otherIncomeCategories),
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

class _EmptyIncomeCategoryCard extends StatelessWidget {
  const _EmptyIncomeCategoryCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _IncomeCategoryCard extends StatelessWidget {
  const _IncomeCategoryCard({
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
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
                  color: const Color(0xFFFFE082), // Default yellow from image
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'INCOME CATEGORY',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F7F6),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  'আয় যোগ',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
