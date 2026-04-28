import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _InventoryTopBar(),
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
                    AppSpacing.lg,
                  ),
                  children: const [
                    _InventoryStatsRow(),
                    SizedBox(height: AppSpacing.lg),
                    _InventorySearchRow(),
                    SizedBox(height: AppSpacing.lg),
                    _InventoryHeaderRow(),
                    SizedBox(height: AppSpacing.md),
                    _InventoryItemCard(
                      emoji: '🥭',
                      title: 'আম (Mango)',
                      stockText: '৪৫০ টি',
                      invoiceText: '#INV-001',
                      priceText: '৳ ১,০০,০০০',
                      salesText: '৳ ২০,০০০',
                      accentColor: Color(0xFFFFB11A),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _InventoryItemCard(
                      icon: Icons.category_rounded,
                      title: 'টেস্ট প্রোজেক্ট',
                      stockText: '২১ পিস',
                      invoiceText: '#INV-042',
                      priceText: '৳ ৬,৫০০/পিস',
                      salesText: '৳ ৮০০',
                      warningStock: true,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _InventoryItemCard(
                      emoji: '🪵',
                      title: 'সিরামিক টাইলস',
                      stockText: '৮০ স্কয়ার ফিট',
                      invoiceText: '#INV-108',
                      priceText: '৳ ২০/sqft',
                      salesText: '৳ ৮৫',
                    ),
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

class _InventoryTopBar extends StatelessWidget {
  const _InventoryTopBar();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
        boxShadow: AppShadows.soft,
      ),
      child: SafeArea(
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
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'স্টকের হিসাব',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InventoryStatsRow extends StatelessWidget {
  const _InventoryStatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Expanded(
        //   child: _InventoryStatCard(
        //     title: 'মোট স্টক',
        //     value: '২,৮৫০',
        //   ),
        // ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _InventoryStatCard(
            title: 'স্টক মূল্য',
            value: '৳ ১,৮8,00,000',
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _InventoryStatCard(
            title: 'সামগ্র লাভ',
            value: '৳ ১,৮8,00,000',
            highlighted: true,
          ),
        ),
      ],
    );
  }
}

class _InventoryStatCard extends StatelessWidget {
  const _InventoryStatCard({
    required this.title,
    required this.value,
    this.highlighted = false,
  });

  final String title;
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: highlighted ? AppGradients.primaryButton : null,
        color: highlighted ? null : const Color(0xFFE7F6F8),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: highlighted ? Colors.white70 : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: highlighted ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _InventorySearchRow extends StatelessWidget {
  const _InventorySearchRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.soft,
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'পণ্য খুঁজুন...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            boxShadow: AppShadows.soft,
          ),
          child: const Icon(Icons.tune_rounded, color: AppColors.primary),
        ),
      ],
    );
  }
}

class _InventoryHeaderRow extends StatelessWidget {
  const _InventoryHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'পণ্যের তালিকা',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          // '৫টি পণ্য পাওয়া গেছে',
          'মোট স্টক ৫,৫৫,৫৫৫ টি পণ্য',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  const _InventoryItemCard({
    required this.title,
    required this.stockText,
    required this.invoiceText,
    required this.priceText,
    required this.salesText,
    this.emoji,
    this.icon,
    this.accentColor,
    this.warningStock = false,
  });

  final String? emoji;
  final IconData? icon;
  final String title;
  final String stockText;
  final String invoiceText;
  final String priceText;
  final String salesText;
  final Color? accentColor;
  final bool warningStock;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: accentColor != null
                  ? accentColor!.withOpacity(0.15)
                  : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            alignment: Alignment.center,
            child: emoji != null
                ? Text(emoji!, style: const TextStyle(fontSize: 38))
                : Icon(
                    icon ?? Icons.inventory_2_rounded,
                    color: AppColors.textSecondary,
                    size: 34,
                  ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: stockText,
                        style: TextStyle(
                          color: warningStock
                              ? const Color(0xFFD9534F)
                              : AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: '  $invoiceText',
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                    ],
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
                priceText,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    const TextSpan(
                      text: 'লাভ: ',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(
                      text: salesText,
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
