import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/widgets/auth_top_bar.dart';
import '../../application/income_providers.dart';

class OtherIncomeCategoriesPage extends ConsumerStatefulWidget {
  const OtherIncomeCategoriesPage({super.key});

  @override
  ConsumerState<OtherIncomeCategoriesPage> createState() =>
      _OtherIncomeCategoriesPageState();
}

class _OtherIncomeCategoriesPageState
    extends ConsumerState<OtherIncomeCategoriesPage> {
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
    final categoriesAsync = ref.watch(incomeCategoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthTopBar(title: 'নতুন আয়ের খাত'),
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
                _IncomeCategoryFormCard(
                  controller: _nameController,
                  editingCategory: _editingCategory,
                  onCancelEdit: _clearForm,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SaveIncomeCategoryButton(
                  saving: _saving,
                  editing: _editingCategory != null,
                  onPressed: _saving ? null : _saveCategory,
                ),
                const SizedBox(height: AppSpacing.xl),
                categoriesAsync.when(
                  data: (items) => _IncomeCategoryListSection(
                    categories: items,
                    onEdit: _startEdit,
                    onDelete: _deleteCategory,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const _IncomeCategoryListError(
                    message: 'আয়ের খাত লোড করা যায়নি',
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const _IncomeCategoryFooterNote(),
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
      ).showSnackBar(const SnackBar(content: Text('আয়ের খাতের নাম দিন')));
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final database = ref.read(appDatabaseProvider);
      final editing = _editingCategory;
      if (editing == null) {
        await database.createIncomeCategory(name);
      } else {
        await database.updateIncomeCategory(id: editing.id, name: name);
      }

      if (!mounted) {
        return;
      }
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            editing == null ? 'আয়ের খাত সেভ হয়েছে' : 'আয়ের খাত আপডেট হয়েছে',
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
      await ref.read(appDatabaseProvider).deleteIncomeCategory(category.id);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('আয়ের খাত মুছে দেওয়া হয়েছে')),
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

class _IncomeCategoryFormCard extends StatelessWidget {
  const _IncomeCategoryFormCard({
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
                            ? 'আয়ের ধরনের নাম'
                            : 'আয়ের খাত এডিট',
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
                    hintText: 'আয়ের ধরনের নাম',
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

class _SaveIncomeCategoryButton extends StatelessWidget {
  const _SaveIncomeCategoryButton({
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

class _IncomeCategoryListSection extends StatelessWidget {
  const _IncomeCategoryListSection({
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
            'বিদ্যমান আয়ের খাতসমূহ',
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
                  child: Center(child: Text('এখনও কোনো আয়ের খাত নেই')),
                )
              : Column(
                  children: [
                    for (var i = 0; i < categories.length; i++) ...[
                      _IncomeCategoryListItem(
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

class _IncomeCategoryListError extends StatelessWidget {
  const _IncomeCategoryListError({required this.message});

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

class _IncomeCategoryListItem extends StatelessWidget {
  const _IncomeCategoryListItem({
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  final LocalCategory category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final iconStyle = _iconForIncomeCategory(category.name);

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
              color: iconStyle.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconStyle.icon,
              color: iconStyle.color,
              size: 22,
            ),
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
            icon: const Icon(
              Icons.edit_rounded,
              color: AppColors.textMuted,
            ),
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

class _IncomeCategoryFooterNote extends StatelessWidget {
  const _IncomeCategoryFooterNote();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text(
        'একটি নতুন বিভাগ তৈরি করুন যা আপনার অন্যান্য আয়ের উৎস সঠিকভাবে ট্র্যাক করতে সাহায্য করবে।',
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

class _IncomeCategoryIconStyle {
  const _IncomeCategoryIconStyle({
    required this.icon,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final Color background;
  final Color color;
}

_IncomeCategoryIconStyle _iconForIncomeCategory(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('bonus') || lower.contains('বোনাস')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.payments_rounded,
      background: Color(0xFFE8F6EF),
      color: AppColors.primary,
    );
  }
  if (lower.contains('commission') || lower.contains('কমিশন')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.sell_rounded,
      background: Color(0xFFEAF7F2),
      color: AppColors.secondary,
    );
  }
  if (lower.contains('investment') || lower.contains('বিনিয়োগ')) {
    return const _IncomeCategoryIconStyle(
      icon: Icons.receipt_long_rounded,
      background: Color(0xFFF1F4F2),
      color: AppColors.primaryContainer,
    );
  }
  return const _IncomeCategoryIconStyle(
    icon: Icons.category_rounded,
    background: Color(0xFFE8F6EF),
    color: AppColors.primary,
  );
}
