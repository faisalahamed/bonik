import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

class ExpenseCategoriesPage extends StatelessWidget {
  const ExpenseCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'নতুন খরচের খাত'),
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
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
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                gradient: AppGradients.backgroundGlowBottom,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: const [
                _ExpenseCategoryFormCard(),
                SizedBox(height: AppSpacing.xl),
                _SaveExpenseCategoryButton(),
                SizedBox(height: AppSpacing.xl),
                _ExpenseCategoryListSection(),
                SizedBox(height: AppSpacing.xl),
                _ExpenseCategoryFooterNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseCategoryFormCard extends StatelessWidget {
  const _ExpenseCategoryFormCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
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
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'খরচের ধরনের নাম',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'খরচের ধরনের নাম',
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

class _SaveExpenseCategoryButton extends StatelessWidget {
  const _SaveExpenseCategoryButton();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: AppShadows.button,
      ),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.onPrimary,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
          ),
          child: Text(
            'সেভ করুন',
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

class _ExpenseCategoryListSection extends StatelessWidget {
  const _ExpenseCategoryListSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const categories = [
      _ExpenseCategoryListItemData(
        label: 'Salary / বেতন',
        icon: Icons.payments_rounded,
        iconBackground: Color(0xFFE8F6EF),
        iconColor: AppColors.primary,
      ),
      _ExpenseCategoryListItemData(
        label: 'Rent / ভাড়া',
        icon: Icons.home_rounded,
        iconBackground: Color(0xFFEAF7F2),
        iconColor: AppColors.secondary,
      ),
      _ExpenseCategoryListItemData(
        label: 'Bills / বিল',
        icon: Icons.receipt_long_rounded,
        iconBackground: Color(0xFFF1F4F2),
        iconColor: AppColors.primaryContainer,
      ),
      _ExpenseCategoryListItemData(
        label: 'Groceries / বাজার',
        icon: Icons.shopping_cart_rounded,
        iconBackground: Color(0xFFE8F6EF),
        iconColor: AppColors.primary,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'বিদ্যমান খরচের খাতসমূহ',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            children: [
              for (var i = 0; i < categories.length; i++) ...[
                _ExpenseCategoryListItem(item: categories[i]),
                if (i != categories.length - 1)
                  const Divider(
                    height: 1,
                    color: AppColors.surfaceContainerHigh,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpenseCategoryListItem extends StatelessWidget {
  const _ExpenseCategoryListItem({
    required this.item,
  });

  final _ExpenseCategoryListItemData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: item.iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: item.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_rounded,
              color: AppColors.textMuted,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseCategoryFooterNote extends StatelessWidget {
  const _ExpenseCategoryFooterNote();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text(
        'একটি নতুন বিভাগ তৈরি করুন যা আপনার দৈনিক খরচ সঠিকভাবে ট্র্যাক করতে সাহায্য করবে।',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
      ),
    );
  }
}

class _ExpenseCategoryListItemData {
  const _ExpenseCategoryListItemData({
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
