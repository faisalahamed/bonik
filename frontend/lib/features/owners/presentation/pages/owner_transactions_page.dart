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

final _ownerTransactionsProvider =
    StreamProvider<List<LocalOwnerTransactionEntry>>(
      (ref) =>
          ref.watch(appDatabaseProvider).watchOwnerTransactionsForCurrentShop(),
    );

class OwnerTransactionsPage extends ConsumerWidget {
  const OwnerTransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(_ownerTransactionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _OwnerTransactionsTopBar(),
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
                transactions.when(
                  data: (entries) => _OwnerTransactionsList(entries: entries),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      const _OwnerTransactionsList(entries: []),
                ),
                const _OwnerBottomActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerTransactionsTopBar extends StatelessWidget {
  const _OwnerTransactionsTopBar();

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
                    'মালিক দিলো / নিলো',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: Colors.white,
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

class _OwnerTransactionsList extends StatelessWidget {
  const _OwnerTransactionsList({required this.entries});

  final List<LocalOwnerTransactionEntry> entries;

  @override
  Widget build(BuildContext context) {
    final sortedEntries = [...entries]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final totalGiven = entries
        .where((entry) => entry.isGiven)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
    final totalTaken = entries
        .where((entry) => entry.isTaken)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
    final balance = totalGiven - totalTaken;
    final balancesById = _runningBalancesById(entries);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      children: [
        _OwnerProfileCard(
          totalGiven: totalGiven,
          totalTaken: totalTaken,
          balance: balance,
        ),
        const SizedBox(height: AppSpacing.md),
        const _OwnerHistoryFilters(),
        const SizedBox(height: AppSpacing.md),
        const _OwnerHistoryHeader(),
        const SizedBox(height: AppSpacing.md),
        if (sortedEntries.isEmpty)
          const _OwnerEmptyHistoryCard()
        else
          for (var i = 0; i < sortedEntries.length; i++) ...[
            _OwnerHistoryEntry.fromEntry(
              sortedEntries[i],
              balance: balancesById[sortedEntries[i].id] ?? 0,
            ),
            if (i != sortedEntries.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        const SizedBox(height: 104),
      ],
    );
  }
}

class _OwnerProfileCard extends StatelessWidget {
  const _OwnerProfileCard({
    required this.totalGiven,
    required this.totalTaken,
    required this.balance,
  });

  final double totalGiven;
  final double totalTaken;
  final double balance;

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
            height: 252,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.xl),
                bottomLeft: Radius.circular(AppRadii.xl),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _OwnerMetricCard(
                          title: 'মোট দিয়েছে',
                          value: _money(totalGiven),
                          background: const Color(0xFFE8FBF4),
                          valueColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _OwnerMetricCard(
                          title: 'মোট নিয়েছে',
                          value: _money(totalTaken),
                          background: const Color(0xFFFFEAEA),
                          valueColor: const Color(0xFFD9534F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _OwnerBalanceCard(balance: balance),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerMetricCard extends StatelessWidget {
  const _OwnerMetricCard({
    required this.title,
    required this.value,
    required this.background,
    required this.valueColor,
  });

  final String title;
  final String value;
  final Color background;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerBalanceCard extends StatelessWidget {
  const _OwnerBalanceCard({required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ব্যালেন্স',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _money(balance),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: balance < 0
                        ? const Color(0xFFD9534F)
                        : AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerHistoryFilters extends StatelessWidget {
  const _OwnerHistoryFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _OwnerFilterChip(label: 'দিন')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _OwnerFilterChip(label: 'মাস', active: true)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _OwnerFilterChip(label: 'বছর')),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _OwnerFilterChip(label: 'কাস্টম ফ্রি')),
      ],
    );
  }
}

class _OwnerFilterChip extends StatelessWidget {
  const _OwnerFilterChip({required this.label, this.active = false});

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

class _OwnerHistoryHeader extends StatelessWidget {
  const _OwnerHistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DUE HISTORY',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'তারিখ ও বিবরণ',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'দিয়েছে',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'নিয়েছে',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'ব্যালেন্স',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OwnerHistoryEntry extends StatelessWidget {
  const _OwnerHistoryEntry({
    required this.dateMonth,
    required this.day,
    required this.reference,
    required this.credit,
    required this.debit,
    required this.balance,
  });

  factory _OwnerHistoryEntry.fromEntry(
    LocalOwnerTransactionEntry entry, {
    required double balance,
  }) {
    return _OwnerHistoryEntry(
      dateMonth: _monthShort(entry.createdAt.month),
      day: _banglaNumber(entry.createdAt.day.toString().padLeft(2, '0')),
      reference: _reference(entry),
      credit: entry.isGiven ? '+${_plainMoney(entry.amount)}' : '-',
      debit: entry.isTaken ? '-${_plainMoney(entry.amount)}' : '-',
      balance: _money(balance),
    );
  }

  final String dateMonth;
  final String day;
  final String reference;
  final String credit;
  final String debit;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateMonth,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            day,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          reference,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: credit == '-'
                      ? _DashText(text: credit)
                      : _TxnBadge(
                          text: credit,
                          background: const Color(0xFFE4FBF6),
                          color: AppColors.primary,
                        ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: debit == '-'
                      ? _DashText(text: debit)
                      : _TxnBadge(
                          text: debit,
                          background: const Color(0xFFFFE7E7),
                          color: const Color(0xFFD9534F),
                        ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      balance,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0xFFD9534F),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashText extends StatelessWidget {
  const _DashText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _TxnBadge extends StatelessWidget {
  const _TxnBadge({
    required this.text,
    required this.background,
    required this.color,
  });

  final String text;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _OwnerEmptyHistoryCard extends StatelessWidget {
  const _OwnerEmptyHistoryCard();

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
        'এখনো মালিকের কোনো লেনদেন নেই',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OwnerBottomActions extends StatelessWidget {
  const _OwnerBottomActions();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppSpacing.md,
      right: AppSpacing.md,
      bottom: AppSpacing.md,
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push(AppRoutes.ownerGiving),
                borderRadius: BorderRadius.circular(AppRadii.xl),
                child: Container(
                  height: 78,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE7E7),
                    borderRadius: BorderRadius.circular(AppRadii.xl),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color(0xFFB43737),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'দিচ্ছি (Giving)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFB43737),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push(AppRoutes.ownerTaking),
                borderRadius: BorderRadius.circular(AppRadii.xl),
                child: Container(
                  height: 78,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5FAFD),
                    borderRadius: BorderRadius.circular(AppRadii.xl),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'নিচ্ছি (Taking)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Map<String, double> _runningBalancesById(
  List<LocalOwnerTransactionEntry> entries,
) {
  final sorted = [...entries]
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  final balances = <String, double>{};
  var balance = 0.0;
  for (final entry in sorted) {
    balance += entry.isGiven ? entry.amount : -entry.amount;
    balances[entry.id] = balance;
  }
  return balances;
}

String _reference(LocalOwnerTransactionEntry entry) {
  final note = entry.note?.trim();
  if (note != null && note.isNotEmpty) {
    return note;
  }

  final referenceId = entry.referenceId?.trim();
  if (referenceId != null && referenceId.isNotEmpty) {
    return 'Ref: ${referenceId.length > 8 ? referenceId.substring(0, 8) : referenceId}';
  }

  return entry.isGiven ? 'Owner given' : 'Owner taken';
}

String _money(double value) {
  final sign = value < 0 ? '-' : '';
  return '$sign৳ ${_plainMoney(value.abs())}';
}

String _plainMoney(double value) {
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
  return _banglaNumber(fixed);
}

String _monthShort(int month) {
  const names = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  return names[month - 1];
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
