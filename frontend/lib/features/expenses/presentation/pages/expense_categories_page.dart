import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';

final _expenseCategoriesProvider = StreamProvider<List<LocalCategory>>(
  (ref) =>
      ref.watch(appDatabaseProvider).watchExpenseCategoriesForCurrentShop(),
);

class ExpenseCategoriesPage extends ConsumerStatefulWidget {
  const ExpenseCategoriesPage({super.key});

  @override
  ConsumerState<ExpenseCategoriesPage> createState() =>
      _ExpenseCategoriesPageState();
}

class _ExpenseCategoriesPageState extends ConsumerState<ExpenseCategoriesPage> {
  final _nameController = TextEditingController();
  LocalCategory? _editingCategory;
  var _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(_expenseCategoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'নতুন খরচের খাত'),
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
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
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                gradient: AppGradients.backgroundGlowBottom,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: [
                _ExpenseCategoryFormCard(
                  controller: _nameController,
                  editingCategory: _editingCategory,
                  onCancelEdit: _clearForm,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SaveExpenseCategoryButton(
                  saving: _saving,
                  editing: _editingCategory != null,
                  onPressed: _saving ? null : _saveCategory,
                ),
                const SizedBox(height: AppSpacing.xl),
                categories.when(
                  data: (items) => _ExpenseCategoryListSection(
                    categories: items,
                    onEdit: _startEdit,
                    onDelete: _deleteCategory,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const _ExpenseCategoryListError(
                    message: 'খরচের খাত লোড করা যায়নি',
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const _ExpenseCategoryFooterNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCategory() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('খরচের খাতের নাম দিন')));
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final database = ref.read(appDatabaseProvider);
      final editing = _editingCategory;
      if (editing == null) {
        await database.createExpenseCategory(name);
      } else {
        await database.updateExpenseCategory(id: editing.id, name: name);
      }

      if (!mounted) {
        return;
      }
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            editing == null ? 'খরচের খাত সেভ হয়েছে' : 'খরচের খাত আপডেট হয়েছে',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  void _startEdit(LocalCategory category) {
    setState(() {
      _editingCategory = category;
      _nameController.text = category.name;
    });
  }

  Future<void> _deleteCategory(LocalCategory category) async {
    try {
      await ref.read(appDatabaseProvider).deleteExpenseCategory(category.id);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('খরচের খাত মুছে দেওয়া হয়েছে')),
      );
      if (_editingCategory?.id == category.id) {
        _clearForm();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void _clearForm() {
    setState(() {
      _editingCategory = null;
      _nameController.clear();
    });
  }
}

class _ExpenseCategoryFormCard extends StatelessWidget {
  const _ExpenseCategoryFormCard({
    required this.controller,
    required this.editingCategory,
    required this.onCancelEdit,
  });

  final TextEditingController controller;
  final LocalCategory? editingCategory;
  final VoidCallback onCancelEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        editingCategory == null
                            ? 'খরচের ধরনের নাম'
                            : 'খরচের খাত এডিট',
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (editingCategory != null)
                      TextButton(
                        onPressed: onCancelEdit,
                        child: const Text('বাতিল'),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'খরচের ধরনের নাম',
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

class _SaveExpenseCategoryButton extends StatelessWidget {
  const _SaveExpenseCategoryButton({
    required this.saving,
    required this.editing,
    required this.onPressed,
  });

  final bool saving;
  final bool editing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: AppShadows.button,
      ),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.onPrimary,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
          ),
          child: Text(
            saving ? 'সেভ হচ্ছে' : (editing ? 'আপডেট করুন' : 'সেভ করুন'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpenseCategoryListSection extends StatelessWidget {
  const _ExpenseCategoryListSection({
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  final List<LocalCategory> categories;
  final ValueChanged<LocalCategory> onEdit;
  final ValueChanged<LocalCategory> onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'বিদ্যমান খরচের খাতসমূহ',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            boxShadow: AppShadows.soft,
          ),
          child: categories.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Center(child: Text('এখনও কোনো খরচের খাত নেই')),
                )
              : Column(
                  children: [
                    for (var i = 0; i < categories.length; i++) ...[
                      _ExpenseCategoryListItem(
                        category: categories[i],
                        onEdit: () => onEdit(categories[i]),
                        onDelete: () => onDelete(categories[i]),
                      ),
                      if (i != categories.length - 1)
                        const Divider(
                          height: 1,
                          color: AppColors.surfaceContainerHigh,
                        ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _ExpenseCategoryListError extends StatelessWidget {
  const _ExpenseCategoryListError({required this.message});

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

class _ExpenseCategoryListItem extends StatelessWidget {
  const _ExpenseCategoryListItem({
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  final LocalCategory category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final icon = _iconForCategory(category.name);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: icon.background,
              shape: BoxShape.circle,
            ),
            child: Icon(icon.icon, color: icon.color, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  category.syncStatus == 'pending' ? 'সিঙ্ক বাকি' : 'সিঙ্কড',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_rounded, color: AppColors.textMuted),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseCategoryFooterNote extends StatelessWidget {
  const _ExpenseCategoryFooterNote();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text(
        'একটি নতুন বিভাগ তৈরি করুন যা আপনার দৈনিক খরচ সঠিকভাবে ট্র্যাক করতে সাহায্য করবে।',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
      ),
    );
  }
}

class _CategoryIconStyle {
  const _CategoryIconStyle({
    required this.icon,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final Color background;
  final Color color;
}

_CategoryIconStyle _iconForCategory(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('salary') || lower.contains('বেতন')) {
    return const _CategoryIconStyle(
      icon: Icons.payments_rounded,
      background: Color(0xFFE8F6EF),
      color: AppColors.primary,
    );
  }
  if (lower.contains('rent') || lower.contains('ভাড়া')) {
    return const _CategoryIconStyle(
      icon: Icons.home_rounded,
      background: Color(0xFFEAF7F2),
      color: AppColors.secondary,
    );
  }
  if (lower.contains('bill') || lower.contains('বিল')) {
    return const _CategoryIconStyle(
      icon: Icons.receipt_long_rounded,
      background: Color(0xFFF1F4F2),
      color: AppColors.primaryContainer,
    );
  }
  if (lower.contains('grocery') ||
      lower.contains('market') ||
      lower.contains('বাজার')) {
    return const _CategoryIconStyle(
      icon: Icons.shopping_cart_rounded,
      background: Color(0xFFE8F6EF),
      color: AppColors.primary,
    );
  }
  return const _CategoryIconStyle(
    icon: Icons.category_rounded,
    background: Color(0xFFE8F6EF),
    color: AppColors.primary,
  );
}
