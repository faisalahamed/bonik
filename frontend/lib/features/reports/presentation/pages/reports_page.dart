import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  static const List<_ReportMenuItemData> _reports = [
    _ReportMenuItemData(
      label: 'সেলস রিপোর্ট',
      icon: Icons.receipt_long_rounded,
      route: AppRoutes.reportSales,
    ),
    _ReportMenuItemData(
      label: 'ক্রয় রিপোর্ট',
      icon: Icons.shopping_cart_rounded,
      route: AppRoutes.reportPurchase,
    ),
    _ReportMenuItemData(
      label: 'স্টক রিপোর্ট',
      icon: Icons.inventory_2_rounded,
      route: AppRoutes.reportStock,
    ),
    _ReportMenuItemData(
      label: 'প্রোডাক্ট রিপোর্ট',
      icon: Icons.grid_view_rounded,
      route: AppRoutes.reportProduct,
    ),
    _ReportMenuItemData(
      label: 'টপ কাস্টমার',
      icon: Icons.groups_rounded,
      route: AppRoutes.reportTopCustomers,
    ),
    _ReportMenuItemData(
      label: 'লাভ-ক্ষতি রিপোর্ট',
      icon: Icons.query_stats_rounded,
      route: AppRoutes.reportProfitLoss,
    ),
    _ReportMenuItemData(
      label: 'ব্যয় রিপোর্ট',
      icon: Icons.currency_exchange_rounded,
      route: AppRoutes.reportExpense,
    ),
    _ReportMenuItemData(
      label: 'সাপ্লায়ার রিপোর্ট',
      icon: Icons.local_shipping_rounded,
      route: AppRoutes.reportSuppliers,
    ),
    _ReportMenuItemData(
      label: 'অন্যান্য আয় রিপোর্ট',
      icon: Icons.account_balance_rounded,
      route: AppRoutes.reportOtherIncome,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _ReportsTopBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: -70,
                  right: -60,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.backgroundGlowTop,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -90,
                  left: -70,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.backgroundGlowBottom,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  itemCount: _reports.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 0.87,
                  ),
                  itemBuilder: (context, index) {
                    return _ReportMenuCard(item: _reports[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportsTopBar extends StatelessWidget {
  const _ReportsTopBar();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
        boxShadow: AppShadows.soft,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadii.xl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 78,
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
                Expanded(
                  child: Text(
                    'রিপোর্টসমূহ',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

class _ReportMenuCard extends StatelessWidget {
  const _ReportMenuCard({
    required this.item,
  });

  final _ReportMenuItemData item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.route == null ? null : () => context.push(item.route!),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8FBF4),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Icon(
                  item.icon,
                  color: AppColors.primaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: 76,
                      child: Text(
                        item.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                      ),
                    ),
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

class _ReportMenuItemData {
  const _ReportMenuItemData({
    required this.label,
    required this.icon,
    this.route,
  });

  final String label;
  final IconData icon;
  final String? route;
}
