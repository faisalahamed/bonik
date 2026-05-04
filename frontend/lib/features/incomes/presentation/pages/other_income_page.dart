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
                    _IncomeCategoryGrid(),
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

class _IncomeCategoryGrid extends ConsumerWidget {
  const _IncomeCategoryGrid();

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
        return GridView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            final iconStyle = _iconForIncomeCategory(category.name);

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push(
                  '${AppRoutes.otherIncomeCreate}/${Uri.encodeComponent(category.name)}',
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
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: iconStyle.background,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: Icon(
                          iconStyle.icon,
                          color: iconStyle.color,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        category.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
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
