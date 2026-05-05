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

final _inventoryProductsProvider = StreamProvider<List<LocalSalesProduct>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesProductsForCurrentShop(),
);

const _inventoryAccentColors = [
  Color(0xFFFFB11A),
  Color(0xFF00A884),
  Color(0xFF4B7BEC),
  Color(0xFFE056FD),
];

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage> {
  final _searchController = TextEditingController();
  String _query = '';

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
    final productsState = ref.watch(_inventoryProductsProvider);

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
                productsState.when(
                  data: (products) {
                    final filteredProducts = _filterProducts(products);

                    return _InventoryList(
                      products: filteredProducts,
                      allProducts: products,
                      controller: _searchController,
                    );
                  },
                  loading: () => _InventoryList(
                    products: const [],
                    allProducts: const [],
                    controller: _searchController,
                    message: 'স্টকের তথ্য লোড হচ্ছে...',
                    showLoading: true,
                  ),
                  error: (error, stackTrace) => _InventoryList(
                    products: const [],
                    allProducts: const [],
                    controller: _searchController,
                    message: 'স্টকের তথ্য লোড করা যায়নি',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<LocalSalesProduct> _filterProducts(List<LocalSalesProduct> products) {
    if (_query.isEmpty) {
      return products;
    }

    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(_query) ||
              (product.description?.toLowerCase().contains(_query) ?? false),
        )
        .toList();
  }
}

class _InventoryList extends StatelessWidget {
  const _InventoryList({
    required this.products,
    required this.allProducts,
    required this.controller,
    this.message,
    this.showLoading = false,
  });

  final List<LocalSalesProduct> products;
  final List<LocalSalesProduct> allProducts;
  final TextEditingController controller;
  final String? message;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    final totalStock = allProducts.fold<int>(
      0,
      (sum, product) => sum + product.stockQuantity,
    );
    final stockValue = allProducts.fold<double>(
      0,
      (sum, product) => sum + product.stockValue,
    );
    final totalProfit = allProducts.fold<double>(
      0,
      (sum, product) => sum + product.expectedProfit,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      children: [
        _InventoryStatsRow(stockValue: stockValue, totalProfit: totalProfit),
        const SizedBox(height: AppSpacing.lg),
        _InventorySearchRow(controller: controller),
        const SizedBox(height: AppSpacing.lg),
        _InventoryHeaderRow(totalStock: totalStock),
        const SizedBox(height: AppSpacing.md),
        if (showLoading)
          const Center(child: CircularProgressIndicator())
        else if (message != null)
          _InventoryEmptyCard(message: message!)
        else if (products.isEmpty)
          const _InventoryEmptyCard(message: 'কোনো পণ্য পাওয়া যায়নি')
        else
          for (var i = 0; i < products.length; i++) ...[
            _InventoryItemCard(
              icon: Icons.category_rounded,
              title: products[i].name,
              invoiceText: '#${products[i].description ?? 'বর্ণনা নেই'}',
              stockText: '${_bnNumber(products[i].stockQuantity)} টি',

              priceText: '${_money(products[i].sellingPrice)}/পিস',
              accentColor:
                  _inventoryAccentColors[i % _inventoryAccentColors.length],
              salesText: _money(products[i].expectedProfit),
              warningStock: products[i].stockQuantity <= 5,
              onTap: () =>
                  context.push(AppRoutes.inventoryDetails, extra: products[i]),
            ),
            if (i != products.length - 1) const SizedBox(height: AppSpacing.md),
          ],
      ],
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
  const _InventoryStatsRow({
    required this.stockValue,
    required this.totalProfit,
  });

  final double stockValue;
  final double totalProfit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _InventoryStatCard(
            title: 'স্টক মূল্য',
            value: _money(stockValue),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _InventoryStatCard(
            title: 'সামগ্র লাভ',
            value: _money(totalProfit),
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
  const _InventorySearchRow({required this.controller});

  final TextEditingController controller;

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
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
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
  const _InventoryHeaderRow({required this.totalStock});

  final int totalStock;

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
          'মোট স্টক ${_bnNumber(totalStock)} টি পণ্য',
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
    this.icon,
    this.accentColor,
    this.warningStock = false,
    this.onTap,
  });

  final IconData? icon;
  final String title;
  final String stockText;
  final String invoiceText;
  final String priceText;
  final String salesText;
  final Color? accentColor;
  final bool warningStock;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Ink(
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
                      ? accentColor!.withValues(alpha: 0.15)
                      : AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                alignment: Alignment.center,
                child: Icon(
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
        ),
      ),
    );
  }
}

class _InventoryEmptyCard extends StatelessWidget {
  const _InventoryEmptyCard({required this.message});

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
