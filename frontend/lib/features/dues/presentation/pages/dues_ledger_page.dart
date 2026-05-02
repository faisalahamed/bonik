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

final _duesSummaryProvider = StreamProvider<LocalDuesSummary>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchDuesSummaryForCurrentShop();
});

final _duesLedgerProvider = StreamProvider<List<LocalDuesLedgerEntry>>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchDuesLedgerForCurrentShop();
});

class DuesLedgerPage extends ConsumerStatefulWidget {
  const DuesLedgerPage({super.key});

  @override
  ConsumerState<DuesLedgerPage> createState() => _DuesLedgerPageState();
}

class _DuesLedgerPageState extends ConsumerState<DuesLedgerPage> {
  var _selectedFilter = _DuesLedgerFilter.all;

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(_duesSummaryProvider).valueOrNull;
    final ledgerEntries = ref.watch(_duesLedgerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _DuesTopBar(),
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
                  children: [
                    _ReceivablePayableRow(
                      receivable: summary?.receivable ?? 0,
                      payable: summary?.payable ?? 0,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _DuesSearchBox(),
                    const SizedBox(height: AppSpacing.md),
                    _DuesFilterRow(
                      selectedFilter: _selectedFilter,
                      onFilterSelected: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _DuesSectionTitle(title: 'সাম্প্রতিক লেনদেন'),
                    const SizedBox(height: AppSpacing.md),
                    ...ledgerEntries.when(
                      data: (entries) {
                        final filteredEntries = _filterEntries(
                          entries,
                          _selectedFilter,
                        );

                        if (filteredEntries.isEmpty) {
                          return [
                            _DuesEmptyCard(
                              message: _emptyMessage(_selectedFilter),
                            ),
                          ];
                        }

                        return [
                          for (var i = 0; i < filteredEntries.length; i++) ...[
                            _DuesPersonCard.fromEntry(filteredEntries[i]),
                            if (i != filteredEntries.length - 1)
                              const SizedBox(height: AppSpacing.md),
                          ],
                        ];
                      },
                      loading: () => [
                        const Center(child: CircularProgressIndicator()),
                      ],
                      error: (error, stackTrace) => [
                        const _DuesEmptyCard(message: 'বাকির ডাটা পাওয়া যায়নি'),
                      ],
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

class _DuesTopBar extends StatelessWidget {
  const _DuesTopBar();

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
                    'বাকির খাতা',
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

class _ReceivablePayableRow extends StatelessWidget {
  const _ReceivablePayableRow({
    required this.receivable,
    required this.payable,
  });

  final double receivable;
  final double payable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AmountSummaryCard(
            title: 'পাবো (RECEIVABLE)',
            amount: _money(receivable),
            accentColor: AppColors.secondary,
            amountColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _AmountSummaryCard(
            title: 'দিবো (PAYABLE)',
            amount: _money(payable),
            accentColor: Color(0xFFD9534F),
            amountColor: Color(0xFFD9534F),
          ),
        ),
      ],
    );
  }
}

class _AmountSummaryCard extends StatelessWidget {
  const _AmountSummaryCard({
    required this.title,
    required this.amount,
    required this.accentColor,
    required this.amountColor,
  });

  final String title;
  final String amount;
  final Color accentColor;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w800,
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

class _DuesSearchBox extends StatelessWidget {
  const _DuesSearchBox();

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
          hintText: 'কাস্টমারের নাম বা মোবাইল নম্বর দিয়ে খুঁজুন',
          prefixIcon: Icon(Icons.group_add_rounded),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _DuesFilterRow extends StatelessWidget {
  const _DuesFilterRow({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final _DuesLedgerFilter selectedFilter;
  final ValueChanged<_DuesLedgerFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DuesFilterChip(
            label: '∞ সব',
            active: selectedFilter == _DuesLedgerFilter.all,
            onTap: () => onFilterSelected(_DuesLedgerFilter.all),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _DuesFilterChip(
            label: '↙ পাবো',
            active: selectedFilter == _DuesLedgerFilter.receivable,
            onTap: () => onFilterSelected(_DuesLedgerFilter.receivable),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _DuesFilterChip(
            label: '↗ দিবো',
            active: selectedFilter == _DuesLedgerFilter.payable,
            onTap: () => onFilterSelected(_DuesLedgerFilter.payable),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _DuesSortChip(),
      ],
    );
  }
}

class _DuesFilterChip extends StatelessWidget {
  const _DuesFilterChip({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Ink(
          height: 42,
          decoration: BoxDecoration(
            gradient: active ? AppGradients.primaryButton : null,
            color: active ? null : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: active ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DuesSortChip extends StatelessWidget {
  const _DuesSortChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: const Icon(Icons.tune_rounded, color: AppColors.primary),
    );
  }
}

class _DuesSectionTitle extends StatelessWidget {
  const _DuesSectionTitle({required this.title});

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

class _DuesPersonCard extends StatelessWidget {
  const _DuesPersonCard({
    required this.initials,
    required this.name,
    required this.phone,
    required this.timeText,
    required this.dateText,
    required this.amountLabel,
    required this.amount,
    required this.amountBackground,
    required this.amountColor,
    this.mutedAvatar = false,
    this.entry,
  });

  factory _DuesPersonCard.fromEntry(LocalDuesLedgerEntry entry) {
    final receivable = entry.isReceivable;
    return _DuesPersonCard(
      initials: _initials(entry.name),
      name: entry.name,
      phone: entry.phone.isEmpty ? 'নম্বর নেই' : entry.phone,
      timeText: _relativeDate(entry.createdAt),
      dateText: _dateOnly(entry.createdAt),
      amountLabel: receivable ? 'পাবো' : 'দিবো',
      amount: _money(entry.dueAmount),
      amountBackground: receivable
          ? const Color(0xFFD8F8E8)
          : const Color(0xFFFFE3E3),
      amountColor: receivable ? AppColors.primary : const Color(0xFFD9534F),
      mutedAvatar: !receivable,
      entry: entry,
    );
  }

  final String initials;
  final String name;
  final String phone;
  final String timeText;
  final String dateText;
  final String amountLabel;
  final String amount;
  final Color amountBackground;
  final Color amountColor;
  final bool mutedAvatar;
  final LocalDuesLedgerEntry? entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(AppRoutes.duesLedgerDetails, extra: entry),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: mutedAvatar
                      ? const Color(0xFFEAEAE8)
                      : const Color(0xFFB9F3E7),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$phone ${dateText.isNotEmpty ? '•' : ''} $timeText'
                          .trim(),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (dateText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        dateText,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 98,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: amountBackground,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      amount,
                      textAlign: TextAlign.right,
                      style: textTheme.titleLarge?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DuesEmptyCard extends StatelessWidget {
  const _DuesEmptyCard({required this.message});

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
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
  return '৳ ${_banglaNumber(fixed)}';
}

String _initials(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) {
    return '?';
  }

  return String.fromCharCode(trimmed.runes.first).toUpperCase();
}

String _relativeDate(DateTime value) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final date = DateTime(value.year, value.month, value.day);
  final difference = today.difference(date).inDays;

  if (difference == 0) {
    return 'আজ';
  }
  if (difference == 1) {
    return 'গতকাল';
  }
  if (difference > 1 && difference < 7) {
    return '${_banglaNumber(difference.toString())} দিন আগে';
  }

  return _dateOnly(value);
}

String _dateOnly(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return _banglaNumber('$day/$month/${value.year}');
}

enum _DuesLedgerFilter { all, receivable, payable }

List<LocalDuesLedgerEntry> _filterEntries(
  List<LocalDuesLedgerEntry> entries,
  _DuesLedgerFilter filter,
) {
  return switch (filter) {
    _DuesLedgerFilter.all => entries,
    _DuesLedgerFilter.receivable =>
      entries.where((entry) => entry.isReceivable).toList(),
    _DuesLedgerFilter.payable =>
      entries.where((entry) => !entry.isReceivable).toList(),
  };
}

String _emptyMessage(_DuesLedgerFilter filter) {
  return switch (filter) {
    _DuesLedgerFilter.all => 'কোনো বাকি লেনদেন নেই',
    _DuesLedgerFilter.receivable => 'পাওয়ার মতো কোনো বাকি নেই',
    _DuesLedgerFilter.payable => 'দেওয়ার মতো কোনো বাকি নেই',
  };
}

String _banglaNumber(String value) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

  var result = value;
  for (var i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], bangla[i]);
  }
  return result;
}
