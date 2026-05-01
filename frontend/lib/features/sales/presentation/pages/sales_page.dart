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

final _salesProductsProvider = StreamProvider<List<LocalSalesProduct>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesProductsForCurrentShop(),
);

class SalesPage extends ConsumerStatefulWidget {
  const SalesPage({super.key});

  @override
  ConsumerState<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends ConsumerState<SalesPage> {
  final _searchController = TextEditingController();
  final Map<String, _SalesCartLine> _cart = {};
  String _query = '';

  int get _cartItemCount =>
      _cart.values.fold(0, (total, item) => total + item.quantity);

  double get _cartTotal => _cart.values.fold(
    0,
    (total, item) => total + (item.product.sellingPrice * item.quantity),
  );

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
    final productsState = ref.watch(_salesProductsProvider);

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
              child: productsState.when(
                data: (products) {
                  final filteredProducts = _filterProducts(products);

                  return ListView(
                    children: [
                      _SalesSearchBar(controller: _searchController),
                      const SizedBox(height: AppSpacing.xl),
                      _SalesHeaderRow(productCount: filteredProducts.length),
                      const SizedBox(height: AppSpacing.md),
                      _SalesProductList(
                        products: filteredProducts,
                        cart: _cart,
                        onProductTap: _addToCart,
                      ),
                    ],
                  );
                },
                loading: () => ListView(
                  children: [
                    _SalesSearchBar(controller: _searchController),
                    const SizedBox(height: AppSpacing.xl),
                    const Center(child: CircularProgressIndicator()),
                  ],
                ),
                error: (error, stackTrace) => ListView(
                  children: [
                    _SalesSearchBar(controller: _searchController),
                    const SizedBox(height: AppSpacing.xl),
                    const _EmptySalesProductState(
                      message: 'পণ্যের তালিকা লোড করা যায়নি',
                    ),
                  ],
                ),
              ),
            ),
            _SalesBottomBar(total: _cartTotal, itemCount: _cartItemCount),
          ],
        ),
      ),
    );
  }

  List<LocalSalesProduct> _filterProducts(List<LocalSalesProduct> products) {
    if (_query.isEmpty) {
      return products;
    }

    return products
        .where((product) => product.name.toLowerCase().contains(_query))
        .toList();
  }

  void _addToCart(LocalSalesProduct product) {
    final existingQuantity = _cart[product.id]?.quantity ?? 0;
    if (existingQuantity >= product.stockQuantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('স্টকের চেয়ে বেশি যোগ করা যাবে না')),
      );
      return;
    }

    setState(() {
      _cart[product.id] = _SalesCartLine(
        product: product,
        quantity: existingQuantity + 1,
      );
    });
  }
}

class _SalesSearchBar extends StatelessWidget {
  const _SalesSearchBar({required this.controller});

  final TextEditingController controller;

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
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
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
  const _SalesHeaderRow({required this.productCount});

  final int productCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'পণ্য তালিকা (${_bnNumber(productCount)})',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Row(
          children: [
            _SalesFilterChip(icon: Icons.filter_alt_outlined, label: 'ফিল্টার'),
            SizedBox(width: AppSpacing.sm),
            _SalesFilterChip(icon: Icons.sort_rounded, label: 'সোর্ট'),
          ],
        ),
      ],
    );
  }
}

class _SalesFilterChip extends StatelessWidget {
  const _SalesFilterChip({required this.icon, required this.label});

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
          Icon(icon, size: 18, color: AppColors.textSecondary),
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
  const _SalesProductList({
    required this.products,
    required this.cart,
    required this.onProductTap,
  });

  final List<LocalSalesProduct> products;
  final Map<String, _SalesCartLine> cart;
  final ValueChanged<LocalSalesProduct> onProductTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const _EmptySalesProductState(
        message: 'বিক্রির জন্য কোনো পণ্য পাওয়া যায়নি',
      );
    }

    return Column(
      children: [
        for (final product in products) ...[
          _SalesProductCard(
            product: product,
            selectedQuantity: cart[product.id]?.quantity ?? 0,
            onTap: () => onProductTap(product),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _EmptySalesProductState extends StatelessWidget {
  const _EmptySalesProductState({required this.message});

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

class _SalesProductCard extends StatelessWidget {
  const _SalesProductCard({
    required this.product,
    required this.selectedQuantity,
    required this.onTap,
  });

  final LocalSalesProduct product;
  final int selectedQuantity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLowStock = product.stockQuantity <= 5;
    final isSelected = selectedQuantity > 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF1FAF6)
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.4,
          ),
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
              child: const Icon(
                Icons.inventory_2_rounded,
                color: AppColors.primary,
                size: 34,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _StockBadge(
                        label: _stockLabel(product.stockQuantity, isLowStock),
                        isLowStock: isLowStock,
                      ),
                      if (isSelected)
                        _SelectedBadge(quantity: selectedQuantity),
                    ],
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
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 6),
                Text(
                  _money(product.sellingPrice),
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
                color: isSelected ? AppColors.primary : const Color(0xFFF0F8F5),
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: isSelected ? Colors.white : AppColors.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.label, required this.isLowStock});

  final String label;
  final bool isLowStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isLowStock ? const Color(0xFFFFEAEA) : const Color(0xFFE9F7F2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isLowStock
              ? const Color(0xFFC15151)
              : AppColors.primaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SelectedBadge extends StatelessWidget {
  const _SelectedBadge({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'কার্টে: ${_bnNumber(quantity)}টি',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SalesBottomBar extends StatelessWidget {
  const _SalesBottomBar({required this.total, required this.itemCount});

  final double total;
  final int itemCount;

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
                        color: Colors.white.withValues(alpha: 0.78),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _money(total),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
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
                      color: Colors.white.withValues(alpha: 0.14),
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
                      child: Text(
                        _bnNumber(itemCount),
                        style: const TextStyle(
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

class _SalesCartLine {
  const _SalesCartLine({required this.product, required this.quantity});

  final LocalSalesProduct product;
  final int quantity;
}

String _stockLabel(int stock, bool isLowStock) {
  final stockText = 'স্টক: ${_bnNumber(stock)}টি';
  return isLowStock ? 'স্টক শেষ পর্যায়ে: ${_bnNumber(stock)}টি' : stockText;
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
