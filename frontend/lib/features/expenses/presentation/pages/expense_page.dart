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

class _ExpensePageState extends ConsumerState<ExpensePage> {
  final _searchController = TextEditingController();
  var _query = '';

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
    final categories = ref.watch(_expenseCategoriesProvider);
    final todayTotal = ref.watch(_todayExpenseTotalProvider).valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'খরচ যোগ করুন'),
      body: SafeArea(
        top: false,
        child: categories.when(
          data: (items) {
            final filtered = _query.isEmpty
                ? items
                : items
                      .where(
                        (item) =>
                            item.name.toLowerCase().contains(_query) ||
                            (item.details ?? '').toLowerCase().contains(_query),
                      )
                      .toList();

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _ExpenseSummaryCard(total: todayTotal),
                const SizedBox(height: AppSpacing.xl),
                const _ExpenseHeaderRow(),
                const SizedBox(height: AppSpacing.md),
                _ExpenseSearchField(controller: _searchController),
                const SizedBox(height: AppSpacing.lg),
                _ExpenseCategoryGrid(categories: filtered),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _ExpenseSummaryCard(total: todayTotal),
              const SizedBox(height: AppSpacing.xl),
              const _ExpenseHeaderRow(),
              const SizedBox(height: AppSpacing.md),
              _ExpenseSearchField(controller: _searchController),
              const SizedBox(height: AppSpacing.lg),
              const _EmptyExpenseCategoryCard(
                message: 'খরচের খাত লোড করা যায়নি',
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
                    'ব্যয়ের তালিকা',
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

class _ExpenseHeaderRow extends StatelessWidget {
  const _ExpenseHeaderRow();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'নতুন খরচ',
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => context.push(AppRoutes.expenseCategories),
              borderRadius: BorderRadius.circular(AppRadii.sm),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                  boxShadow: AppShadows.button,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            TextButton(
              onPressed: () => context.push(AppRoutes.expenseCategories),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: const Text('খরচের খাত'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExpenseSearchField extends StatelessWidget {
  const _ExpenseSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'খোঁজ করুন',
        prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted),
      ),
    );
  }
}

class _ExpenseCategoryGrid extends StatelessWidget {
  const _ExpenseCategoryGrid({required this.categories});

  final List<LocalCategory> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const _EmptyExpenseCategoryCard(
        message: 'এখনও কোনো খরচের খাত নেই',
      );
    }

    return GridView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.94,
      ),
      itemBuilder: (context, index) {
        return _ExpenseCategoryCard(category: categories[index]);
      },
    );
  }
}

class _ExpenseCategoryCard extends StatelessWidget {
  const _ExpenseCategoryCard({required this.category});

  final LocalCategory category;

  @override
  Widget build(BuildContext context) {
    final icon = _iconForCategory(category.name);

    return InkWell(
      onTap: () => context.push(
        '${AppRoutes.expenseCreate}/${Uri.encodeComponent(category.name)}',
      ),
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: icon.background,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Icon(icon.icon, color: icon.color, size: 32),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
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
