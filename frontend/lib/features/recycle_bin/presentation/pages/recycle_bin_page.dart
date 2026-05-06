import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

final _recycleBinEntriesProvider = StreamProvider<List<LocalRecycleBinEntry>>(
  (ref) =>
      ref.watch(appDatabaseProvider).watchRecycleBinEntriesForCurrentShop(),
);

class RecycleBinPage extends ConsumerWidget {
  const RecycleBinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState = ref.watch(_recycleBinEntriesProvider);
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _RecycleBinTopBar(),
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
                entriesState.when(
                  data: (entries) {
                    if (entries.isEmpty) {
                      return const Center(
                        child: _RecycleBinEmptyCard(
                          message: 'রিসাইকেল বিন খালি',
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: entries.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return _RecycleBinItemCard(
                          entry: entry,
                          onRestore: () =>
                              _handleRestore(context, database, entry),
                          onDelete: () =>
                              _handleDelete(context, database, entry),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRestore(
    BuildContext context,
    AppDatabase database,
    LocalRecycleBinEntry entry,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('পুনরুদ্ধার নিশ্চিত করুন'),
        content: Text('আপনি কি "${entry.displayTitle}" পুনরুদ্ধার করতে চান?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('না'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('হ্যাঁ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await database.restoreRecycleBinEntry(entry.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('সফলভাবে পুনরুদ্ধার করা হয়েছে')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('ত্রুটি: $e')));
        }
      }
    }
  }

  Future<void> _handleDelete(
    BuildContext context,
    AppDatabase database,
    LocalRecycleBinEntry entry,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('স্থায়ীভাবে মুছে ফেলা'),
        content: Text(
          'আপনি কি নিশ্চিত যে আপনি "${entry.displayTitle}" স্থায়ীভাবে মুছে ফেলতে চান? এটি আর ফিরে পাওয়া যাবে না।',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('না'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'মুছে ফেলুন',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await database.permanentlyDeleteRecycleBinEntry(entry.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('স্থায়ীভাবে মুছে ফেলা হয়েছে')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('ত্রুটি: $e')));
        }
      }
    }
  }
}

class _RecycleBinTopBar extends StatelessWidget {
  const _RecycleBinTopBar();

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
                  Icons.delete_sweep_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'রিসাইকেল বিন',
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

class _RecycleBinItemCard extends StatelessWidget {
  const _RecycleBinItemCard({
    required this.entry,
    required this.onRestore,
    required this.onDelete,
  });

  final LocalRecycleBinEntry entry;
  final VoidCallback onRestore;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                alignment: Alignment.center,
                child: Icon(
                  _getIconForTable(entry.sourceTableName),
                  color: AppColors.textSecondary,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.displayTitle,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (entry.displaySubtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        entry.displaySubtitle!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      'মুছে ফেলা হয়েছে: ${_formatDate(entry.deletedAt)}',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onRestore,
                  icon: const Icon(Icons.restore_rounded, size: 18),
                  label: const Text('Restore'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_forever_rounded, size: 18),
                  label: const Text('Delete'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForTable(String tableName) {
    switch (tableName.toLowerCase()) {
      case 'local_sales':
        return Icons.shopping_cart_outlined;
      case 'local_purchases':
        return Icons.shopping_bag_outlined;
      case 'local_expenses':
        return Icons.money_off_rounded;
      case 'local_customers':
        return Icons.person_outline_rounded;
      case 'local_purchase_items':
        return Icons.inventory_2_outlined;
      case 'local_categories':
        return Icons.category_outlined;
      default:
        return Icons.restore_from_trash_outlined;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _RecycleBinEmptyCard extends StatelessWidget {
  const _RecycleBinEmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.delete_outline_rounded,
          size: 80,
          color: AppColors.textMuted.withValues(alpha: 0.3),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
