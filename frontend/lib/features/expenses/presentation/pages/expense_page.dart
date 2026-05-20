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

class AddExpenseCategoryDraft {
  const AddExpenseCategoryDraft({required this.name, this.details});

  final String name;
  final String? details;
}

final _expenseCategoriesProvider = StreamProvider<List<LocalCategory>>(
  (ref) =>
      ref.watch(appDatabaseProvider).watchExpenseCategoriesForCurrentShop(),
);

final _todayExpenseTotalProvider = StreamProvider<double>(
  (ref) =>
      ref.watch(appDatabaseProvider).watchTodayExpenseTotalForCurrentShop(),
);

class ExpensePage extends ConsumerStatefulWidget {
  const ExpensePage({super.key});

  @override
  ConsumerState<ExpensePage> createState() => _ExpensePageState();
}

enum _ExpenseSortMode { nameAsc, nameDesc, newest, oldest }

class _ExpensePageState extends ConsumerState<ExpensePage> {
  final _searchController = TextEditingController();
  var _query = '';
  _ExpenseSortMode _sortMode = _ExpenseSortMode.nameAsc;

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
      _sortMode = _ExpenseSortMode
          .values[(_sortMode.index + 1) % _ExpenseSortMode.values.length];
    });
  }

  String get _sortModeLabel {
    switch (_sortMode) {
      case _ExpenseSortMode.nameAsc:
        return 'নাম (A-Z)';
      case _ExpenseSortMode.nameDesc:
        return 'নাম (Z-A)';
      case _ExpenseSortMode.newest:
        return 'নতুন আগে';
      case _ExpenseSortMode.oldest:
        return 'পুরোনো আগে';
    }
  }

  List<LocalCategory> _filterCategories(List<LocalCategory> categories) {
    final filtered = _query.isEmpty
        ? List<LocalCategory>.of(categories)
        : categories
              .where(
                (item) =>
                    item.name.toLowerCase().contains(_query) ||
                    (item.details ?? '').toLowerCase().contains(_query),
              )
              .toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case _ExpenseSortMode.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case _ExpenseSortMode.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case _ExpenseSortMode.newest:
          return b.createdAt.compareTo(a.createdAt);
        case _ExpenseSortMode.oldest:
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

  Future<void> _showAddCategoryDialog() async {
    final draft = await showDialog<AddExpenseCategoryDraft>(
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
          .createExpenseCategory(draft.name, details: draft.details);

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

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(_expenseCategoriesProvider);
    final todayTotal = ref.watch(_todayExpenseTotalProvider).valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ExpenseTopBar(),
          Expanded(
            child: categories.when(
              data: (items) {
                final filtered = _filterCategories(items);

                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    _ExpenseSummaryCard(total: todayTotal),
                    const SizedBox(height: AppSpacing.xl),
                    _ExpenseSearchBar(controller: _searchController),
                    const SizedBox(height: AppSpacing.lg),
                    _ExpenseActionRow(
                      onNavigate: _showAddCategoryDialog,
                      onSort: _cycleSortMode,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _SortStatusLabel(label: _sortModeLabel),
                    const SizedBox(height: AppSpacing.xl),
                    if (filtered.isEmpty)
                      const _EmptyExpenseCategoryCard(
                        message: 'এখনও কোনো খরচের খাত নেই',
                      )
                    else
                      for (var i = 0; i < filtered.length; i++) ...[
                        _ExpenseCategoryCard(category: filtered[i]),
                        if (i != filtered.length - 1)
                          const SizedBox(height: AppSpacing.md),
                      ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  _ExpenseSummaryCard(total: todayTotal),
                  const SizedBox(height: AppSpacing.xl),
                  _ExpenseSearchBar(controller: _searchController),
                  const SizedBox(height: AppSpacing.lg),
                  _ExpenseActionRow(
                    onNavigate: () => context.push(AppRoutes.expenseCategories),
                    onSort: _cycleSortMode,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SortStatusLabel(label: _sortModeLabel),
                  const SizedBox(height: AppSpacing.xl),
                  const _EmptyExpenseCategoryCard(
                    message: 'খরচের খাত লোড করা যায়নি',
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

class _ExpenseTopBar extends StatelessWidget {
  const _ExpenseTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
        boxShadow: AppShadows.soft,
      ),
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
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'খরচ যোগ করুন',
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

class _ExpenseSummaryCard extends StatelessWidget {
  const _ExpenseSummaryCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
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
                  'আজকের মোট খরচ',
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _money(total),
                  style: textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          InkWell(
            onTap: () => context.push(AppRoutes.expenseHistory),
            borderRadius: BorderRadius.circular(AppRadii.md),
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
                    Icons.list_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'খরচের খাতা',
                    style: textTheme.labelMedium?.copyWith(
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

class _ExpenseSearchBar extends StatelessWidget {
  const _ExpenseSearchBar({required this.controller});

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
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(
                  Icons.clear_rounded,
                  color: AppColors.textMuted,
                  size: 24,
                ),
              );
            },
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

class _ExpenseActionRow extends StatelessWidget {
  const _ExpenseActionRow({required this.onNavigate, required this.onSort});

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
              onTap: onNavigate,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: Colors.white),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'নতুন খরচের খাত',
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
          icon: Icons.archive_outlined,
          onPressed: () => context.push(AppRoutes.expenseCategories),
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

class _ExpenseCategoryCard extends StatelessWidget {
  const _ExpenseCategoryCard({required this.category});

  final LocalCategory category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final icon = _iconForCategory(category.name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: InkWell(
        onTap: () => context.push(
          '${AppRoutes.expenseCreate}/${Uri.encodeComponent(category.name)}',
        ),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 42,
                decoration: BoxDecoration(
                  color: icon.background,
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
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyExpenseCategoryCard extends StatelessWidget {
  const _EmptyExpenseCategoryCard({required this.message});

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

class _CategoryIconStyle {
  const _CategoryIconStyle({
    required this.icon,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final Color background;
  final Color color;
}

_CategoryIconStyle _iconForCategory(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('salary') || lower.contains('বেতন')) {
    return const _CategoryIconStyle(
      icon: Icons.payments_rounded,
      background: Color(0xFFAAF0E1),
      color: AppColors.primary,
    );
  }
  if (lower.contains('rent') || lower.contains('ভাড়া')) {
    return const _CategoryIconStyle(
      icon: Icons.key_rounded,
      background: Color(0xFFEAF7F2),
      color: AppColors.primary,
    );
  }
  if (lower.contains('bill') || lower.contains('বিল')) {
    return const _CategoryIconStyle(
      icon: Icons.description_rounded,
      background: AppColors.surfaceContainerHigh,
      color: AppColors.primary,
    );
  }
  if (lower.contains('market') ||
      lower.contains('grocery') ||
      lower.contains('কেনা') ||
      lower.contains('বাজার')) {
    return const _CategoryIconStyle(
      icon: Icons.shopping_cart_rounded,
      background: Color(0xFFAAF0E1),
      color: AppColors.primary,
    );
  }
  return const _CategoryIconStyle(
    icon: Icons.category_rounded,
    background: Color(0xFFE8F6EF),
    color: AppColors.primary,
  );
}

String _money(double value) {
  final fixed = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
  return '৳ ${_bnNumber(fixed)}';
}

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
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
                  'নতুন খরচের খাত',
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
                labelText: 'খরচের নাম',
                hintText: 'উদাঃ  বেতন, ভাড়া, বিদ্যুৎ বিল ইত্যাদি',
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
                labelText: 'নোট (ঐচ্ছিক)',
                hintText:
                    'এখানে আপনি খরচের খাত সম্পর্কে অতিরিক্ত তথ্য দিতে পারেন',
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
                        AddExpenseCategoryDraft(
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
