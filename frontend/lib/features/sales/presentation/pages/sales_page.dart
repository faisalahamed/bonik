import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'বিক্রি করুন'),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -70,
              child: Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  gradient: AppGradients.backgroundGlowTop,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                108,
              ),
              child: ListView(
                children: const [
                  _SalesSearchBar(),
                  SizedBox(height: AppSpacing.xl),
                  _SalesHeaderRow(),
                  SizedBox(height: AppSpacing.md),
                  _SalesProductList(),
                ],
              ),
            ),
            const _SalesBottomBar(),
          ],
        ),
      ),
    );
  }
}

class _SalesSearchBar extends StatelessWidget {
  const _SalesSearchBar();

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
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'পণ্য খোঁজ করুন',
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF8),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesHeaderRow extends StatelessWidget {
  const _SalesHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'পণ্য তালিকা',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
        ),
        const Row(
          children: [
            _SalesFilterChip(
              icon: Icons.filter_alt_outlined,
              label: 'ফিল্টার',
            ),
            SizedBox(width: AppSpacing.sm),
            _SalesFilterChip(
              icon: Icons.sort_rounded,
              label: 'সোর্ট',
            ),
          ],
        ),
      ],
    );
  }
}

class _SalesFilterChip extends StatelessWidget {
  const _SalesFilterChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _SalesProductList extends StatelessWidget {
  const _SalesProductList();

  @override
  Widget build(BuildContext context) {
    const items = [
      _SalesItemData(
        emoji: '🍇',
        name: 'আঙ্গুর',
        stock: 'স্টক: ১২৫ কেজি',
        price: '৳ ১৮০.০০',
      ),
      _SalesItemData(
        emoji: '🍎',
        name: 'আপেল',
        stock: 'স্টক: ৮৫ কেজি',
        price: '৳ ২২০.০০',
      ),
      _SalesItemData(
        emoji: '🥭',
        name: 'আম',
        stock: 'স্টক শেষ পর্যায়ে: ৫ কেজি',
        price: '৳ ১৫০.০০',
        warning: true,
      ),
      _SalesItemData(
        emoji: '🍄',
        name: 'আলু',
        stock: 'স্টক: ৫০০ কেজি',
        price: '৳ ৪০.০০',
      ),
      _SalesItemData(
        emoji: '☕',
        name: 'কফি',
        stock: 'স্টক: ১৭ কেজি',
        price: '৳ ১,২০০.০০',
      ),
    ];

    return Column(
      children: [
        for (final item in items) ...[
          _SalesProductCard(item: item),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _SalesProductCard extends StatelessWidget {
  const _SalesProductCard({
    required this.item,
  });

  final _SalesItemData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: Color(0xFFF4F7F6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              item.emoji,
              style: const TextStyle(fontSize: 34),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: item.warning
                        ? const Color(0xFFFFEAEA)
                        : const Color(0xFFE9F7F2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.stock,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: item.warning
                              ? const Color(0xFFC15151)
                              : AppColors.primaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'মূল্য',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                item.price,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F8F5),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.add_shopping_cart_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesBottomBar extends StatelessWidget {
  const _SalesBottomBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'নির্বাচিত পণ্যমূল্য',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white.withOpacity(0.78),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '৳ ১,৩৪৮.৮০',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    margin: const EdgeInsets.only(right: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: -2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B5F52),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '৩',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => context.push(AppRoutes.salesCart),
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.primary,
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

class _SalesItemData {
  const _SalesItemData({
    required this.emoji,
    required this.name,
    required this.stock,
    required this.price,
    this.warning = false,
  });

  final String emoji;
  final String name;
  final String stock;
  final String price;
  final bool warning;
}
