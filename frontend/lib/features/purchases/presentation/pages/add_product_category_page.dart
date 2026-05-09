import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

enum _CategoryListMode { active, deleted }

class AddProductCategoryPage extends ConsumerStatefulWidget {
  const AddProductCategoryPage({super.key});

  @override
  ConsumerState<AddProductCategoryPage> createState() =>
      _AddProductCategoryPageState();
}

class _AddProductCategoryPageState
    extends ConsumerState<AddProductCategoryPage> {
  late final Stream<List<LocalCategory>> _categoriesStream;
  late final Stream<List<LocalCategory>> _deletedCategoriesStream;
  LocalCategory? _categoryPendingDelete;
  LocalCategory? _categoryPendingRestore;
  _CategoryListMode _listMode = _CategoryListMode.active;

  @override
  void initState() {
    super.initState();
    _categoriesStream = ref
        .read(appDatabaseProvider)
        .watchProductCategoriesForCurrentShop();
    _deletedCategoriesStream = ref
        .read(appDatabaseProvider)
        .watchDeletedProductCategoriesForCurrentShop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColors.background,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            _AddCategoryHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: -120,
                    left: -70,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: AppGradients.backgroundGlowBottom,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.xxl,
                      AppSpacing.lg,
                      AppSpacing.xxl,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 620),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _CategoryListToggle(
                              selectedMode: _listMode,
                              onChanged: (mode) {
                                setState(() {
                                  _listMode = mode;
                                });
                              },
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            if (_listMode == _CategoryListMode.active)
                              Text(
                                'বিদ্যমান প্রোডাক্ট ক্যাটাগরিসমূহ',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            if (_listMode == _CategoryListMode.active)
                              const SizedBox(height: AppSpacing.lg),
                            if (_listMode == _CategoryListMode.active)
                              StreamBuilder<List<LocalCategory>>(
                                stream: _categoriesStream,
                                builder: (context, snapshot) {
                                  return _ExistingCategoryList(
                                    categories: snapshot.data ?? const [],
                                    isLoading:
                                        snapshot.connectionState ==
                                            ConnectionState.waiting &&
                                        !snapshot.hasData,
                                    onDelete: _deleteCategory,
                                    onEdit: _editCategory,
                                  );
                                },
                              ),
                            const SizedBox(height: AppSpacing.xxl),
                            if (_listMode == _CategoryListMode.deleted)
                              Text(
                                'ডিলিট করা প্রোডাক্ট ক্যাটাগরিসমূহ',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            if (_listMode == _CategoryListMode.deleted)
                              const SizedBox(height: AppSpacing.lg),
                            if (_listMode == _CategoryListMode.deleted)
                              StreamBuilder<List<LocalCategory>>(
                                stream: _deletedCategoriesStream,
                                builder: (context, snapshot) {
                                  return _DeletedCategoryList(
                                    categories: snapshot.data ?? const [],
                                    isLoading:
                                        snapshot.connectionState ==
                                            ConnectionState.waiting &&
                                        !snapshot.hasData,
                                    onRestore: _restoreCategory,
                                  );
                                },
                              ),
                            const SizedBox(height: AppSpacing.xxl),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_categoryPendingDelete != null)
                    _DeleteCategoryConfirmation(
                      category: _categoryPendingDelete!,
                      onCancel: _cancelDelete,
                      onConfirm: _confirmDelete,
                    ),
                  if (_categoryPendingRestore != null)
                    _RestoreCategoryConfirmation(
                      category: _categoryPendingRestore!,
                      onCancel: _cancelRestore,
                      onConfirm: _confirmRestore,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteCategory(LocalCategory category) async {
    setState(() {
      _categoryPendingDelete = category;
    });
  }

  Future<void> _restoreCategory(LocalCategory category) async {
    setState(() {
      _categoryPendingRestore = category;
    });
  }

  void _cancelDelete() {
    setState(() {
      _categoryPendingDelete = null;
    });
  }

  void _cancelRestore() {
    setState(() {
      _categoryPendingRestore = null;
    });
  }

  Future<void> _confirmDelete() async {
    final category = _categoryPendingDelete;
    if (category == null) {
      return;
    }

    try {
      await ref.read(appDatabaseProvider).deleteProductCategory(category.id);
      if (!mounted) {
        return;
      }
      setState(() {
        _categoryPendingDelete = null;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('"${category.name}" ডিলিট হয়েছে')));
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _confirmRestore() async {
    final category = _categoryPendingRestore;
    if (category == null) {
      return;
    }

    try {
      await ref.read(appDatabaseProvider).restoreProductCategory(category.id);
      if (!mounted) {
        return;
      }
      setState(() {
        _categoryPendingRestore = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${category.name}" ফিরিয়ে আনা হয়েছে')),
      );
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _editCategory(LocalCategory category) async {
    final draft = await showDialog<AddProductCategoryDraft>(
      context: context,
      builder: (context) => _AddCategoryDialog(
        initialName: category.name,
        initialDetails: category.details,
      ),
    );

    if (draft == null || draft.name.trim().isEmpty) {
      return;
    }

    try {
      await ref.read(appDatabaseProvider).updateProductCategory(
            id: category.id,
            name: draft.name,
            details: draft.details,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ক্যাটাগরি আপডেট করা হয়েছে')),
      );
    } catch (error) {
      _showError(error);
    }
  }

  void _showError(Object error) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error.toString())));
  }
}

class _AddCategoryHeader extends StatelessWidget {
  const _AddCategoryHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      color: const Color(0xFF043F32),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_rounded, size: 32),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'নতুন ক্যাটাগরি',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryListToggle extends StatelessWidget {
  const _CategoryListToggle({
    required this.selectedMode,
    required this.onChanged,
  });

  final _CategoryListMode selectedMode;
  final ValueChanged<_CategoryListMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CategoryListToggleButton(
              label: 'বিদ্যমান',
              icon: Icons.category_rounded,
              isSelected: selectedMode == _CategoryListMode.active,
              onPressed: () => onChanged(_CategoryListMode.active),
            ),
          ),
          Expanded(
            child: _CategoryListToggleButton(
              label: 'ডিলিট করা',
              icon: Icons.delete_rounded,
              isSelected: selectedMode == _CategoryListMode.deleted,
              onPressed: () => onChanged(_CategoryListMode.deleted),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryListToggleButton extends StatelessWidget {
  const _CategoryListToggleButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : AppColors.primary,
          backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
        ),
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _DeleteCategoryConfirmation extends StatelessWidget {
  const _DeleteCategoryConfirmation({
    required this.category,
    required this.onCancel,
    required this.onConfirm,
  });

  final LocalCategory category;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.24)),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 620),
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  boxShadow: AppShadows.button,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ক্যাটাগরি ডিলিট করবেন?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '"${category.name}" লোকাল থেকে সরানো হবে এবং অনলাইনে সিঙ্ক হবে।',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: onCancel,
                            child: const Text('না'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('ডিলিট'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExistingCategoryList extends StatelessWidget {
  const _ExistingCategoryList({
    required this.categories,
    required this.isLoading,
    required this.onDelete,
    required this.onEdit,
  });

  final List<LocalCategory> categories;
  final bool isLoading;
  final ValueChanged<LocalCategory> onDelete;
  final ValueChanged<LocalCategory> onEdit;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.soft,
        ),
        child: Text(
          'এখনও কোনো ক্যাটাগরি নেই',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          for (var i = 0; i < categories.length; i++) ...[
            _ExistingCategoryTile(
              category: categories[i],
              onDelete: onDelete,
              onEdit: onEdit,
            ),
            if (i != categories.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.textMuted.withValues(alpha: 0.16),
              ),
          ],
        ],
      ),
    );
  }
}

class _RestoreCategoryConfirmation extends StatelessWidget {
  const _RestoreCategoryConfirmation({
    required this.category,
    required this.onCancel,
    required this.onConfirm,
  });

  final LocalCategory category;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.24)),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 620),
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  boxShadow: AppShadows.button,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ক্যাটাগরি ফিরিয়ে আনবেন?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '"${category.name}" আবার বিদ্যমান ক্যাটাগরি তালিকায় ফিরবে এবং অনলাইনে সিঙ্ক হবে।',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: onCancel,
                            child: const Text('না'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('ফিরিয়ে আনুন'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeletedCategoryList extends StatelessWidget {
  const _DeletedCategoryList({
    required this.categories,
    required this.isLoading,
    required this.onRestore,
  });

  final List<LocalCategory> categories;
  final bool isLoading;
  final ValueChanged<LocalCategory> onRestore;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.soft,
        ),
        child: Text(
          'কোনো ডিলিট করা ক্যাটাগরি নেই',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          for (var i = 0; i < categories.length; i++) ...[
            _DeletedCategoryTile(category: categories[i], onRestore: onRestore),
            if (i != categories.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.textMuted.withValues(alpha: 0.16),
              ),
          ],
        ],
      ),
    );
  }
}

class _DeletedCategoryTile extends StatelessWidget {
  const _DeletedCategoryTile({required this.category, required this.onRestore});

  final LocalCategory category;
  final ValueChanged<LocalCategory> onRestore;

  @override
  Widget build(BuildContext context) {
    final details = category.details?.trim();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.textMuted.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_rounded,
              color: AppColors.textMuted.withValues(alpha: 0.86),
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.72),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (details != null && details.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    details,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (category.deletedAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'ডিলিট: ${_formatDeletedAt(category.deletedAt!)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => onRestore(category),
            color: AppColors.primary,
            icon: const Icon(Icons.restore_rounded),
          ),
        ],
      ),
    );
  }

  String _formatDeletedAt(DateTime value) {
    final local = value.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final year = local.year.toString();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}

class _AddCategoryDialog extends StatefulWidget {
  final String? initialName;
  final String? initialDetails;

  const _AddCategoryDialog({this.initialName, this.initialDetails});

  @override
  State<_AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<_AddCategoryDialog> {
  late final _nameController = TextEditingController(text: widget.initialName);
  late final _detailsController =
      TextEditingController(text: widget.initialDetails);

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  widget.initialName != null
                      ? Icons.edit_note_rounded
                      : Icons.add_box_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  widget.initialName != null
                      ? 'ক্যাটাগরি এডিট'
                      : 'নতুন ক্যাটাগরি',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: _nameController,
              autofocus: widget.initialName == null,
              decoration: InputDecoration(
                labelText: 'ক্যাটাগরির নাম',
                hintText: 'উদা: ইলেকট্রনিক্স',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                prefixIcon: const Icon(Icons.label_outline_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _detailsController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'বিস্তারিত (ঐচ্ছিক)',
                hintText: 'ক্যাটাগরি সম্পর্কে কিছু লিখুন...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                prefixIcon: const Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('বাতিল'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.trim();
                      if (name.isEmpty) return;
                      Navigator.pop(
                        context,
                        AddProductCategoryDraft(
                          name: name,
                          details: _detailsController.text.trim(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                    ),
                    child: const Text('সেভ করুন'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExistingCategoryTile extends StatelessWidget {
  const _ExistingCategoryTile({
    required this.category,
    required this.onDelete,
    required this.onEdit,
  });

  final LocalCategory category;
  final ValueChanged<LocalCategory> onDelete;
  final ValueChanged<LocalCategory> onEdit;

  @override
  Widget build(BuildContext context) {
    final isPending = category.syncStatus == 'pending';
    final details = category.details?.trim();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.category_rounded,
              color: AppColors.primary,
              size: isPending ? 24 : 28,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (details != null && details.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    details,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => onEdit(category),
            color: AppColors.textMuted,
            icon: const Icon(Icons.edit_note_rounded),
          ),
          IconButton(
            onPressed: () => onDelete(category),
            color: AppColors.textMuted,
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
    );
  }
}

class AddProductCategoryDraft {
  const AddProductCategoryDraft({
    required this.name,
    this.details = '',
  });

  final String name;
  final String details;
}
