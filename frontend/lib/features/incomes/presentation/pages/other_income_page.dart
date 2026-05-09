import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../application/income_providers.dart';

class OtherIncomePage extends StatelessWidget {
  const OtherIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  children: const [
                    _IncomeSummaryCard(),
                    SizedBox(height: AppSpacing.xl),
                    _IncomeHeaderRow(),
                    SizedBox(height: AppSpacing.md),
                    _IncomeSearchBox(),
                    SizedBox(height: AppSpacing.lg),
                    _IncomeCategoryList(),
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

class _IncomeSummaryCard extends ConsumerWidget {
  const _IncomeSummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTotalAsync = ref.watch(todayIncomeTotalProvider);
    final todayTotal = todayTotalAsync.valueOrNull ?? 0.0;

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
                  '${todayTotal.toStringAsFixed(0)}৳',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}

class _IncomeHeaderRow extends StatelessWidget {
  const _IncomeHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'নতুন আয়',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        InkWell(
          onTap: () => context.push(AppRoutes.otherIncomeCategories),
          borderRadius: BorderRadius.circular(AppRadii.md),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryButton,
              borderRadius: BorderRadius.circular(AppRadii.md),
              boxShadow: AppShadows.button,
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'আয়ের খাত',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _IncomeSearchBox extends StatelessWidget {
  const _IncomeSearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'আয় খুঁজুন',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _IncomeCategoryList extends ConsumerWidget {
  const _IncomeCategoryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(incomeCategoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Text('কোনো আয়ের খাত পাওয়া যায়নি।'),
            ),
          );
        }
        return ListView.separated(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final category = categories[index];
            return _IncomeCategoryCard(
              name: category.name,
              onTap: () => context.push(
                '${AppRoutes.otherIncomeCreate}/${Uri.encodeComponent(category.name)}',
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('আয়ের খাত লোড করা যায়নি: $error'),
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

class _IncomeCategoryIconStyle {
  const _IncomeCategoryIconStyle({
    required this.icon,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final Color background;
  final Color color;
}

_IncomeCategoryIconStyle _iconForIncomeCategory(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('bonus') || lower.contains('বোনাস')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.payments_rounded,
      background: Color(0xFFE8F6EF),
      color: AppColors.primary,
    );
  }
  if (lower.contains('commission') || lower.contains('কমিশন')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.sell_rounded,
      background: Color(0xFFEAF7F2),
      color: AppColors.secondary,
    );
  }
  if (lower.contains('investment') || lower.contains('বিনিয়োগ')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.receipt_long_rounded,
      background: Color(0xFFF1F4F2),
      color: AppColors.primaryContainer,
    );
  }
  return const _IncomeCategoryIconStyle(
    icon: Icons.category_rounded,
    background: Color(0xFFE8F6EF),
    color: AppColors.primary,
  );
}
