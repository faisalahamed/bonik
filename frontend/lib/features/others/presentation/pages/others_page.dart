import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _OthersTopBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: const [
                // _OthersIntroCard(),
                SizedBox(height: AppSpacing.lg),
                _SectionTitle(title: 'পার্টি ব্যবস্থাপনা'),
                SizedBox(height: AppSpacing.md),
                _ActionGrid(
                  items: [
                    _OthersActionData(
                      title: 'কাস্টমার',
                      subtitle: 'নতুন ক্রেতার তথ্য সংরক্ষণ',
                      icon: Icons.person_add_alt_1_rounded,
                      iconBackground: Color(0xFFEAF1FF),
                      iconColor: Color(0xFF4169C8),
                      route: AppRoutes.customers,
                    ),
                    _OthersActionData(
                      title: 'সাপ্লায়ার',
                      subtitle: 'পণ্য সরবরাহকারীর তথ্য যোগ',
                      icon: Icons.group_add_rounded,
                      iconBackground: Color(0xFFE8F6EF),
                      iconColor: AppColors.primary,
                      route: AppRoutes.suppliers,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xl),
                _SectionTitle(title: 'পণ্য ব্যবস্থাপনা'),
                SizedBox(height: AppSpacing.md),
                _ActionGrid(
                  items: [
                    _OthersActionData(
                      title: 'পণ্যের নামের তালিকা',
                      subtitle: 'বিক্রি/ক্রয়ের জন্য পণ্য তৈরি',
                      icon: Icons.add_box_rounded,
                      iconBackground: Color(0xFFFFF0E6),
                      iconColor: Color(0xFFCE6D1D),
                      route: AppRoutes.productCategories,
                    ),
                    _OthersActionData(
                      title: 'পণ্য ফেরত',
                      subtitle: 'বিক্রিত পণ্য ফেরত নিন',
                      icon: Icons.refresh_rounded,
                      iconBackground: AppColors.surfaceContainerHigh,
                      iconColor: AppColors.textSecondary,
                      route: AppRoutes.salesReturn,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xl),
                _SectionTitle(title: 'অতিরিক্ত টুলস'),
                SizedBox(height: AppSpacing.md),
                _ActionGrid(
                  items: [
                    _OthersActionData(
                      title: 'Note Pad',
                      subtitle: 'দ্রুত নোট লিখুন ও সংরক্ষণ করুন',
                      icon: Icons.note_alt_rounded,
                      iconBackground: Color(0xFFEAF1FF),
                      iconColor: Color(0xFF4169C8),
                      route: AppRoutes.notePad,
                    ),
                    _OthersActionData(
                      title: 'Recycle Bin',
                      subtitle: 'ডিলিট হওয়া ডাটা দেখুন',
                      icon: Icons.restore_from_trash_rounded,
                      iconBackground: AppColors.surfaceContainerHigh,
                      iconColor: AppColors.textSecondary,
                      route: AppRoutes.recycleBin,
                    ),
                    _OthersActionData(
                      title: 'রিপোর্ট',
                      subtitle: 'বিক্রি, ক্রয় ও লাভের রিপোর্ট',
                      icon: Icons.bar_chart_rounded,
                      iconBackground: Color(0xFFEAF7F2),
                      iconColor: AppColors.primaryContainer,
                      route: AppRoutes.reports,
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

class _OthersTopBar extends StatelessWidget {
  const _OthersTopBar();

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
                Expanded(
                  child: Text(
                    'অন্যান্য',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Icon(Icons.apps_rounded, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OthersIntroCard extends StatelessWidget {
  const _OthersIntroCard();

  @override
  Widget build(BuildContext context) {
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
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF7F2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'দ্রুত ব্যবস্থাপনা',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'কাস্টমার, সাপ্লায়ার এবং পণ্যের দরকারি কাজ এখান থেকে করুন।',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.items});

  final List<_OthersActionData> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => _OthersActionCard(data: items[index]),
    );
  }
}

class _OthersActionCard extends StatelessWidget {
  const _OthersActionCard({required this.data});

  final _OthersActionData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.route == null ? null : () => context.push(data.route!),
      borderRadius: BorderRadius.circular(AppRadii.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: data.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(data.icon, color: data.iconColor, size: 24),
            ),
            const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: Center(
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OthersActionData {
  const _OthersActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String? route;
}
