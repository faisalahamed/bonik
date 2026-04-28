import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class TopCustomersReportPage extends StatelessWidget {
  const TopCustomersReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _TopCustomersTopBar(),
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
                    _TopCustomersFilters(),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomersDateCard(),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomersSearchBox(),
                    SizedBox(height: AppSpacing.lg),
                    _TopCustomersTableHeader(),
                    SizedBox(height: AppSpacing.sm),
                    _TopCustomerCard(
                      initials: 'আ',
                      name: 'আরিফ হোসেন',
                      phone: '01712XXXXXX',
                      dateText: '২৫ জানুয়ারি',
                      amount: '৳ ৪৮,৫০০',
                      tagText: 'নিয়মিত গ্রাহক',
                      tagColor: AppColors.primary,
                      tagBackground: Color(0xFFE4FBF6),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomerCard(
                      initials: 'ম',
                      name: 'মাসুদুর রশীদ',
                      phone: '01819XXXXXX',
                      dateText: '২৫ জানুয়ারি',
                      amount: '৳ ২১,৩০০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomerCard(
                      initials: 'স',
                      name: 'সাজ্জাদ আহমেদ',
                      phone: '01911XXXXXX',
                      dateText: '২৫ জানুয়ারি',
                      amount: '৳ ৫,৭৫০',
                      accentColor: Color(0xFFF3B3B3),
                      tagText: 'বকেয়া আছে',
                      tagColor: Color(0xFFD9534F),
                      tagBackground: Color(0xFFFFE7E7),
                    ),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomerCard(
                      initials: 'ত',
                      name: 'তানভীর আলম',
                      phone: '01552XXXXXX',
                      dateText: '২৫ জানুয়ারি',
                      amount: '৳ ৬,৯১০',
                    ),
                    SizedBox(height: AppSpacing.md),
                    _TopCustomerCard(
                      initials: 'ক',
                      name: 'কামাল উদ্দিন',
                      phone: '01715XXXXXX',
                      dateText: '২০ জানুয়ারি',
                      amount: '৳ ১,০৪,০০০',
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

class _TopCustomersTopBar extends StatelessWidget {
  const _TopCustomersTopBar();

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
                  'গ্রাহক রিপোর্ট',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopCustomersFilters extends StatelessWidget {
  const _TopCustomersFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _TopCustomersChip(label: 'দিন', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _TopCustomersChip(label: 'মাস')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _TopCustomersChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _TopCustomersChip(label: 'কাস্টম')),
      ],
    );
  }
}

class _TopCustomersChip extends StatelessWidget {
  const _TopCustomersChip({
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
        color: active
            ? AppColors.surfaceContainerLowest
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: active ? AppShadows.soft : null,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
      ),
    );
  }
}

class _TopCustomersDateCard extends StatelessWidget {
  const _TopCustomersDateCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _CircleIconButton(icon: Icons.chevron_left_rounded),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadii.xl),
              boxShadow: AppShadows.soft,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '০১ জানুয়ারি ২০২৪ - ৩০ জানুয়ারি ২০২৪',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _CircleIconButton(icon: Icons.chevron_right_rounded),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
      ),
    );
  }
}

class _TopCustomersSearchBox extends StatelessWidget {
  const _TopCustomersSearchBox();

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
          hintText: 'খুঁজুন (নাম, মোবাইল)',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _TopCustomersTableHeader extends StatelessWidget {
  const _TopCustomersTableHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'গ্রাহক',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'মোবাইল/\nতারিখ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'মোট ক্রয়',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCustomerCard extends StatelessWidget {
  const _TopCustomerCard({
    required this.initials,
    required this.name,
    required this.phone,
    required this.dateText,
    required this.amount,
    this.accentColor = const Color(0xFF9EDFD5),
    this.tagText,
    this.tagColor,
    this.tagBackground,
  });

  final String initials;
  final String name;
  final String phone;
  final String dateText;
  final String amount;
  final Color accentColor;
  final String? tagText;
  final Color? tagColor;
  final Color? tagBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 98,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.xl),
                bottomLeft: Radius.circular(AppRadii.xl),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF91EFE6),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        if (tagText != null) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tagBackground,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              tagText!,
                              style:
                                  Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: tagColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          phone,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateText,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.textMuted,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        amount,
                        textAlign: TextAlign.right,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
