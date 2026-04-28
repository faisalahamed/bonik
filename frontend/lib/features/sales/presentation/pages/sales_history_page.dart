import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SalesHistoryTopBar(),
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
                    _SalesHeroCard(),
                    SizedBox(height: AppSpacing.md),
                    _SalesFilterTabs(),
                    SizedBox(height: AppSpacing.md),
                    _SalesSearchBox(),
                    SizedBox(height: AppSpacing.lg),
                    _SectionTitle(title: 'সাম্প্রতিক লেনদেন'),
                    SizedBox(height: AppSpacing.md),
                    _SalesHistoryItemCard(
                      code: '#TKQD9DMA5J0F6DT',
                      name: 'রুহাইয়া স্টোর',
                      amount: '১,৪৭৮.৬ ৳',
                      dateTime: '27 January 2026 | 12:00',
                      statusText: 'নগদ টাকা',
                      statusBackground: Color(0xFFE4FBF6),
                      statusColor: Color(0xFF1A9F83),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _SalesHistoryItemCard(
                      code: '#LM49ZIPX90W2',
                      name: 'আতিক মহল',
                      amount: '৫,৮৩০.০ ৳',
                      dateTime: '27 January 2026 | 11:15',
                      statusText: 'বিকাশের টাকা',
                      statusBackground: Color(0xFFE9F5F0),
                      statusColor: AppColors.primary,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _SalesHistoryItemCard(
                      code: '#B077Y2RKTS4',
                      name: 'মো: কামাল হোসেন',
                      amount: '২,১৫০.০ ৳',
                      dateTime: '26 January 2026 | 18:45',
                      statusText: 'বাকি',
                      statusBackground: Color(0xFFFFECEC),
                      statusColor: Color(0xFFD9534F),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _SalesHistoryItemCard(
                      code: '#P2K8MV55T9',
                      name: 'আনিকা তাসনুম',
                      amount: '৮৯০.৫ ৳',
                      dateTime: '26 January 2026 | 15:20',
                      statusText: 'নগদ টাকা',
                      statusBackground: Color(0xFFE4FBF6),
                      statusColor: Color(0xFF1A9F83),
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

class _SalesHistoryTopBar extends StatelessWidget {
  const _SalesHistoryTopBar();

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
                  'বেচার খাতা',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F6F1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesHeroCard extends StatelessWidget {
  const _SalesHeroCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.button,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '০১ জানুয়ারি, ২০২৪ - ৩১ ডিসেম্বর, ২০২৪',
              style: textTheme.labelMedium?.copyWith(
                color: Colors.white.withOpacity(0.92),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'মোট বিক্রি',
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.84),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 30,
              ),
              Expanded(
                child: Text(
                  '৩,৯২,৫৬৩.৩ ৳',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'গত মাসের চেয়ে ২৫% বেশি',
              style: textTheme.labelMedium?.copyWith(
                color: Colors.white.withOpacity(0.92),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesFilterTabs extends StatelessWidget {
  const _SalesFilterTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _SalesFilterChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _SalesFilterChip(label: 'মাস')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _SalesFilterChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _SalesFilterChip(label: 'সব সময়')),
        SizedBox(width: AppSpacing.sm),
        _SalesSortChip(),
      ],
    );
  }
}

class _SalesFilterChip extends StatelessWidget {
  const _SalesFilterChip({
    required this.label,
    this.active = false,
  });

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        gradient: active ? AppGradients.primaryButton : null,
        color: active ? null : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: active ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _SalesSortChip extends StatelessWidget {
  const _SalesSortChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: const Icon(
        Icons.tune_rounded,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _SalesSearchBox extends StatelessWidget {
  const _SalesSearchBox();

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
          hintText: 'অনুসন্ধান করুন (নাম, মোবাইল, রিসিপ্ট)',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _SalesHistoryItemCard extends StatelessWidget {
  const _SalesHistoryItemCard({
    required this.code,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.statusText,
    required this.statusBackground,
    required this.statusColor,
  });

  final String code;
  final String name;
  final String amount;
  final String dateTime;
  final String statusText;
  final Color statusBackground;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(AppRoutes.salesHistoryDetails),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                code,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    amount,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 15,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            dateTime,
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusBackground,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                    child: Text(
                      statusText,
                      style: textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w800,
                      ),
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
