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
import '../../application/sales_cart_controller.dart';

final _salesProductsProvider = StreamProvider<List<LocalSalesProduct>>(
  (ref) => ref.watch(appDatabaseProvider).watchSalesProductsForCurrentShop(),
);

class SalesPage extends ConsumerStatefulWidget {
  const SalesPage({super.key, this.saleId});

  final String? saleId;

  @override
  ConsumerState<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends ConsumerState<SalesPage> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _loadingEditSale = false;
  String? _loadedEditSaleId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncEditSale());
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
    final cartLines = ref.watch(salesCartProvider);
    final cartController = ref.watch(salesCartProvider.notifier);
    final editSession = ref.watch(salesEditSessionProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppGradients.primaryButton),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              color: AppColors.onPrimary,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            Expanded(
              child: Text(
                editSession.isEditing ? 'বিক্রি এডিট করুন' : 'বিক্রি করুন',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (editSession.isEditing)
            const Icon(Icons.edit_rounded, color: Colors.white),
          IconButton(
            onPressed: () => context.push(AppRoutes.salesCart),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_rounded, color: Colors.white),
                if (cartController.itemCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC15151),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _bnNumber(cartController.itemCount),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
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
              child: _loadingEditSale
                  ? const Center(child: CircularProgressIndicator())
                  : productsState.when(
                      data: (products) {
                        final availableProducts = _withSelectedCartProducts(
                          products,
                          cartLines,
                        );
                        final filteredProducts = _filterProducts(
                          availableProducts,
                          cartLines,
                        );

                        return ListView(
                          children: [
                            _SalesSearchBar(controller: _searchController),
                            const SizedBox(height: AppSpacing.xl),
                            _SalesHeaderRow(
                              productCount: filteredProducts.length,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _SalesProductList(
                              products: filteredProducts,
                              cartLines: cartLines,
                              onProductTap: _addToCart,
                              onProductDecrease: _decreaseFromCart,
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
            _SalesBottomBar(
              total: cartController.total,
              itemCount: cartController.itemCount,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _syncEditSale() async {
    final saleId = widget.saleId;
    if (saleId == null || saleId.isEmpty) {
      if (ref.read(salesEditSessionProvider).isEditing) {
        ref.read(salesEditSessionProvider.notifier).clear();
        ref.read(salesCartProvider.notifier).clear();
        ref.read(salesCheckoutProvider.notifier).clear();
      }
      return;
    }
    if (_loadedEditSaleId == saleId || _loadingEditSale) {
      return;
    }

    setState(() {
      _loadingEditSale = true;
    });
    ref.read(salesCartProvider.notifier).clear();
    ref.read(salesCheckoutProvider.notifier).clear();
    ref.read(salesEditSessionProvider.notifier).clear();

    try {
      final draft = await ref
          .read(appDatabaseProvider)
          .getSaleEditDraft(saleId);
      ref.read(salesEditSessionProvider.notifier).start(draft);
      _loadedEditSaleId = saleId;
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
      context.pop();
    } finally {
      if (mounted) {
        setState(() {
          _loadingEditSale = false;
        });
      }
    }
  }

  List<LocalSalesProduct> _filterProducts(
    List<LocalSalesProduct> products,
    List<SalesCartLine> cartLines,
  ) {
    List<LocalSalesProduct> filtered;
    if (_query.isEmpty) {
      filtered = List.of(products);
    } else {
      filtered = products.where((product) {
        final isSelected = cartLines.any(
          (line) => _sameProductForSalesList(line.product, product),
        );
        if (isSelected) return true;

        return product.name.toLowerCase().contains(_query) ||
            (product.description?.toLowerCase().contains(_query) ?? false);
      }).toList();
    }

    filtered.sort((a, b) {
      final aSelected = cartLines.any(
        (line) => _sameProductForSalesList(line.product, a),
      );
      final bSelected = cartLines.any(
        (line) => _sameProductForSalesList(line.product, b),
      );
      if (aSelected && !bSelected) return -1;
      if (!aSelected && bSelected) return 1;
      return 0;
    });

    return filtered;
  }

  List<LocalSalesProduct> _withSelectedCartProducts(
    List<LocalSalesProduct> products,
    List<SalesCartLine> cartLines,
  ) {
    final merged = [...products];
    for (final line in cartLines) {
      final exists = merged.any(
        (product) => _sameProductForSalesList(product, line.product),
      );
      if (!exists) {
        merged.add(line.product);
      }
    }
    return merged;
  }

  void _addToCart(LocalSalesProduct product) {
    final added = ref.read(salesCartProvider.notifier).addProduct(product);
    if (!added) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('স্টকের চেয়ে বেশি যোগ করা যাবে না')),
      );
    }
  }

  void _decreaseFromCart(LocalSalesProduct product) {
    final cartController = ref.read(salesCartProvider.notifier);
    final quantity = cartController.quantityForProduct(product);
    if (quantity <= 1) {
      cartController.removeProduct(product);
    } else {
      cartController.decreaseProduct(product);
    }
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
          if (controller.text.isNotEmpty)
            IconButton(
              onPressed: () => controller.clear(),
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.textMuted,
                size: 24,
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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmall = screenWidth < 380;

    if (isSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'পণ্য তালিকা (${_bnNumber(productCount)})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Row(
            children: [
              _SalesFilterChip(
                icon: Icons.filter_alt_outlined,
                label: 'ফিল্টার',
              ),
              SizedBox(width: AppSpacing.sm),
              _SalesFilterChip(icon: Icons.sort_rounded, label: 'সোর্ট'),
            ],
          ),
        ],
      );
    }

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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmall = screenWidth < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? AppSpacing.sm : AppSpacing.md,
        vertical: isSmall ? AppSpacing.xs : AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          Icon(icon, size: isSmall ? 16 : 18, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style:
                (isSmall
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.labelMedium)
                    ?.copyWith(
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
    required this.cartLines,
    required this.onProductTap,
    required this.onProductDecrease,
  });

  final List<LocalSalesProduct> products;
  final List<SalesCartLine> cartLines;
  final ValueChanged<LocalSalesProduct> onProductTap;
  final ValueChanged<LocalSalesProduct> onProductDecrease;

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
            selectedQuantity: _quantityFor(product),
            onTap: () => onProductTap(product),
            onDecrease: () => onProductDecrease(product),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  int _quantityFor(LocalSalesProduct product) {
    for (final line in cartLines) {
      if (_sameProductForSalesList(line.product, product)) {
        return line.quantity;
      }
    }
    return 0;
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
    required this.onDecrease,
  });

  final LocalSalesProduct product;
  final int selectedQuantity;
  final VoidCallback onTap;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final isLowStock = product.stockQuantity <= 5;
    final isSelected = selectedQuantity > 0;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmallScreen = screenWidth < 380;

    final cardPadding = isSmallScreen ? AppSpacing.sm : AppSpacing.md;
    final elementSpacing = isSmallScreen ? AppSpacing.sm : AppSpacing.md;
    final iconSize = isSmallScreen ? 48.0 : 60.0;
    final iconInnerSize = isSmallScreen ? 22.0 : 28.0;
    final buttonSize = isSmallScreen ? 36.0 : 40.0;
    final buttonIconSize = isSmallScreen ? 16.0 : 20.0;

    return InkWell(
      onTap: isSelected ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: Container(
        padding: EdgeInsets.all(cardPadding),
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
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F4),
                borderRadius: BorderRadius.circular(
                  isSmallScreen ? AppRadii.sm : AppRadii.md,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.inventory_2_outlined,
                color: AppColors.primary,
                size: iconInnerSize,
              ),
            ),
            SizedBox(width: elementSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        (isSmallScreen
                                ? Theme.of(context).textTheme.titleSmall
                                : Theme.of(context).textTheme.titleMedium)
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                  ),
                  if (_hasText(product.categoryName)) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _hasText(product.categoryDetails)
                                ? '${product.categoryName} (${product.categoryDetails})'
                                : product.categoryName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isSmallScreen ? 10 : 11,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (_hasText(product.description)) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      _StockBadge(
                        label: _stockLabel(product.stockQuantity, isLowStock),
                        isLowStock: isLowStock,
                        isSmall: isSmallScreen,
                      ),
                      if (isSelected)
                        _SelectedBadge(
                          quantity: selectedQuantity,
                          isSmall: isSmallScreen,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: elementSpacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'মূল্য',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontSize: isSmallScreen ? 10 : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _money(product.sellingPrice),
                  style:
                      (isSmallScreen
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context).textTheme.titleLarge)
                          ?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      _CompactActionButton(
                        icon: Icons.remove_rounded,
                        color: const Color(0xFFC15151),
                        backgroundColor: const Color(0xFFFFEAEA),
                        size: buttonSize,
                        iconSize: buttonIconSize,
                        onTap: onDecrease,
                      ),
                      SizedBox(width: isSmallScreen ? 6.0 : 8.0),
                    ],
                    _CompactActionButton(
                      icon: isSelected
                          ? Icons.add_rounded
                          : Icons.add_shopping_cart_rounded,
                      color: isSelected ? Colors.white : AppColors.primary,
                      backgroundColor: isSelected
                          ? AppColors.primary
                          : const Color(0xFFF0F8F5),
                      size: buttonSize,
                      iconSize: buttonIconSize,
                      onTap: onTap,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactActionButton extends StatelessWidget {
  const _CompactActionButton({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.size,
    required this.iconSize,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          child: Icon(icon, color: color, size: iconSize),
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({
    required this.label,
    required this.isLowStock,
    this.isSmall = false,
  });

  final String label;
  final bool isLowStock;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : AppSpacing.sm,
        vertical: isSmall ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: isLowStock ? const Color(0xFFFFEAEA) : const Color(0xFFE9F7F2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style:
            (isSmall
                    ? Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(fontSize: 10)
                    : Theme.of(context).textTheme.labelSmall)
                ?.copyWith(
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
  const _SelectedBadge({required this.quantity, this.isSmall = false});

  final int quantity;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : AppSpacing.sm,
        vertical: isSmall ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'কার্টে: ${_bnNumber(quantity)}টি',
        style:
            (isSmall
                    ? Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(fontSize: 10)
                    : Theme.of(context).textTheme.labelSmall)
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmallScreen = screenWidth < 380;

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
                      style:
                          (isSmallScreen
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.headlineMedium)
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                  ],
                ),
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

bool _hasText(String? value) {
  return value != null && value.trim().isNotEmpty;
}

bool _sameProductForSalesList(LocalSalesProduct left, LocalSalesProduct right) {
  return _salesProductListKey(left) == _salesProductListKey(right);
}

String _salesProductListKey(LocalSalesProduct product) {
  return '${product.categoryId ?? ''}\u001F${product.name.trim().toLowerCase()}';
}

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}
