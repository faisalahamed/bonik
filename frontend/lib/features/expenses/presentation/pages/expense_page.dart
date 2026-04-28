import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'খরচ যোগ করুন'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: const [
            _ExpenseSummaryCard(),
            SizedBox(height: AppSpacing.xl),
            _ExpenseHeaderRow(),
            SizedBox(height: AppSpacing.md),
            _ExpenseSearchField(),
            SizedBox(height: AppSpacing.lg),
            _ExpenseCategoryGrid(),
          ],
        ),
      ),
    );
  }
}

class _ExpenseSummaryCard extends StatelessWidget {
  const _ExpenseSummaryCard();

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
                    color: Colors.white.withOpacity(0.75),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '০৳',
                  style: textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
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
  const _ExpenseSearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'খোঁজ করুন',
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _ExpenseCategoryGrid extends StatelessWidget {
  const _ExpenseCategoryGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      _ExpenseCategoryItemData(
        label: 'বেতন',
        icon: Icons.payments_rounded,
        iconBackground: Color(0xFFAAF0E1),
        iconColor: AppColors.primary,
      ),
      _ExpenseCategoryItemData(
        label: 'কেনা',
        icon: Icons.shopping_cart_rounded,
        iconBackground: Color(0xFFAAF0E1),
        iconColor: AppColors.primary,
      ),
      _ExpenseCategoryItemData(
        label: 'বিল',
        icon: Icons.description_rounded,
        iconBackground: AppColors.surfaceContainerHigh,
        iconColor: AppColors.primary,
      ),
      _ExpenseCategoryItemData(
        label: 'ভাড়া',
        icon: Icons.key_rounded,
        iconBackground: Color(0xFFAAF0E1),
        iconColor: AppColors.primary,
      ),
    ];

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.94,
      ),
      itemBuilder: (context, index) {
        return _ExpenseCategoryCard(item: items[index]);
      },
    );
  }
}

class _ExpenseCategoryCard extends StatelessWidget {
  const _ExpenseCategoryCard({
    required this.item,
  });

  final _ExpenseCategoryItemData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(
        '${AppRoutes.expenseCreate}/${Uri.encodeComponent(item.label)}',
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
                color: item.iconBackground,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 32,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              item.label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseCategoryItemData {
  const _ExpenseCategoryItemData({
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
}
