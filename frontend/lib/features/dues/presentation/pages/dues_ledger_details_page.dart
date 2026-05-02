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

final _dueHistoryProvider =
    StreamProvider.family<List<LocalDueHistoryEntry>, LocalDuesLedgerEntry>(
      (ref, entry) =>
          ref.watch(appDatabaseProvider).watchDueHistoryForLedgerEntry(entry),
    );

class DuesLedgerDetailsPage extends ConsumerWidget {
  const DuesLedgerDetailsPage({super.key, this.entry});

  final LocalDuesLedgerEntry? entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = entry == null
        ? null
        : ref.watch(_dueHistoryProvider(entry!));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _DueDetailsTopBar(),
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
                    108,
                  ),
                  children: [
                    _ProfileSummaryCard(entry: entry),
                    const SizedBox(height: AppSpacing.md),
                    const _HistoryTitle(),
                    const SizedBox(height: AppSpacing.sm),
                    if (entry == null)
                      const _DueHistoryCard(
                        rows: [],
                        errorMessage: 'বাকির তথ্য পাওয়া যায়নি',
                      )
                    else
                      history!.when(
                        data: (rows) =>
                            _DueHistoryCard(entry: entry!, rows: rows),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => const _DueHistoryCard(
                          rows: [],
                          errorMessage: 'বাকির হিস্টোরি পাওয়া যায়নি',
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
                _DueBottomActions(entry: entry),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DueDetailsTopBar extends StatelessWidget {
  const _DueDetailsTopBar();

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
                    'বাকির বিবরণ (Dues Ledger)',
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

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({required this.entry});

  final LocalDuesLedgerEntry? entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final name = entry?.name ?? 'Habib Rahman';
    final phone = entry?.phone.isEmpty ?? true
        ? '+880 1712-345678'
        : entry!.phone;
    final receivable = entry?.isReceivable ?? true;
    final balance = entry?.dueAmount ?? 500.5;
    final accentColor = receivable
        ? AppColors.secondary
        : const Color(0xFFD9534F);
    final balanceColor = receivable
        ? AppColors.primary
        : const Color(0xFFD9534F);

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
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(name),
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
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
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.soft,
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 66,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      '${receivable ? 'বর্তমান পাওনা' : 'বর্তমান দেনা'}: ${_money(balance)}',
                      style: textTheme.titleLarge?.copyWith(
                        color: balanceColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      boxShadow: AppShadows.button,
                    ),
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                        ),
                        child: Text(
                          'Reminder',
                          style: textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
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

class _HistoryTitle extends StatelessWidget {
  const _HistoryTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'DUE HISTORY',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _DueHistoryCard extends StatelessWidget {
  const _DueHistoryCard({required this.rows, this.entry, this.errorMessage});

  final LocalDuesLedgerEntry? entry;
  final List<LocalDueHistoryEntry> rows;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          const _DueHistoryHeader(),
          const Divider(height: 1, color: AppColors.surfaceContainerHigh),
          if (errorMessage != null)
            _DueHistoryEmptyRow(message: errorMessage!)
          else if (rows.isEmpty)
            const _DueHistoryEmptyRow(message: 'কোনো হিস্টোরি পাওয়া যায়নি')
          else
            for (var i = 0; i < rows.length; i++) ...[
              _DueHistoryRow.fromEntry(rows[i], entry!),
              if (i != rows.length - 1)
                const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            ],
        ],
      ),
    );
  }
}

class _DueHistoryEmptyRow extends StatelessWidget {
  const _DueHistoryEmptyRow({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
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

class _DueHistoryHeader extends StatelessWidget {
  const _DueHistoryHeader();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: AppColors.textMuted,
      fontWeight: FontWeight.w800,
    );

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('তারিখ ও বিবরণ', style: style)),
          Expanded(flex: 2, child: Text('নিয়েছি', style: style)),
          Expanded(flex: 2, child: Text('দিয়েছি', style: style)),
          Expanded(
            flex: 2,
            child: Text('ব্যালেন্স', textAlign: TextAlign.right, style: style),
          ),
        ],
      ),
    );
  }
}

class _DueHistoryRow extends StatelessWidget {
  const _DueHistoryRow({
    required this.dateMonth,
    required this.dateDay,
    required this.refText,
    this.receiving,
    this.giving,
    required this.balance,
  });

  factory _DueHistoryRow.fromEntry(
    LocalDueHistoryEntry row,
    LocalDuesLedgerEntry ledger,
  ) {
    final isInvoice = ledger.isReceivable
        ? row.sourceType == 'sale'
        : row.sourceType == 'purchase';
    final receivesColumn = ledger.isReceivable ? !isInvoice : isInvoice;
    final givesColumn = ledger.isReceivable ? isInvoice : !isInvoice;

    return _DueHistoryRow(
      dateMonth: _monthShort(row.createdAt.month),
      dateDay: _banglaNumber(row.createdAt.day.toString().padLeft(2, '0')),
      refText: _historyRef(row),
      receiving: receivesColumn ? '+${_moneyPlain(row.amount)}' : null,
      giving: givesColumn ? '-${_moneyPlain(row.amount)}' : null,
      balance: _money(row.balance),
    );
  }

  final String dateMonth;
  final String dateDay;
  final String refText;
  final String? receiving;
  final String? giving;
  final String balance;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateMonth,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dateDay,
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        refText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: receiving == null
                    ? const Text('-')
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4FBF6),
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: Text(
                          receiving!,
                          textAlign: TextAlign.center,
                          style: textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: giving == null
                    ? const Text('-')
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE3E3),
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: Text(
                          giving!,
                          textAlign: TextAlign.center,
                          style: textTheme.titleSmall?.copyWith(
                            color: const Color(0xFFD9534F),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Text(
                    balance,
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.edit_rounded, color: AppColors.primary, size: 20),
              SizedBox(width: AppSpacing.md),
              Icon(Icons.delete_rounded, color: Color(0xFFD9534F), size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _DueBottomActions extends StatelessWidget {
  const _DueBottomActions({required this.entry});

  final LocalDuesLedgerEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => context.push(AppRoutes.duesGiving, extra: entry),
                borderRadius: BorderRadius.circular(AppRadii.xl),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E3),
                    borderRadius: BorderRadius.circular(AppRadii.xl),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color(0xFFD9534F),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'দিচ্ছি (Giving)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFD9534F),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: InkWell(
                onTap: () => context.push(AppRoutes.duesTaking, extra: entry),
                borderRadius: BorderRadius.circular(AppRadii.xl),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF6F8),
                    borderRadius: BorderRadius.circular(AppRadii.xl),
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
          ],
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

String _moneyPlain(double value) {
  final fixed = value.toStringAsFixed(
    value.truncateToDouble() == value ? 0 : 2,
  );
  return _banglaNumber(fixed);
}

String _historyRef(LocalDueHistoryEntry row) {
  return switch (row.sourceType) {
    'sale' => 'বিক্রি ইনভয়েস',
    'customer_payment' => 'কাস্টমার পেমেন্ট',
    'purchase' => 'কেনা ইনভয়েস',
    'purchase_payment' => 'সাপ্লায়ার পেমেন্ট',
    _ => 'লেনদেন',
  };
}

String _monthShort(int month) {
  const months = [
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
  return months[month - 1];
}

String _initials(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) {
    return '?';
  }

  return String.fromCharCode(trimmed.runes.first).toUpperCase();
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
