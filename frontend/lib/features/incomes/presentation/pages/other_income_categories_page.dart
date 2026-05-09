import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../application/income_providers.dart';

enum _CategoryListMode { active, deleted }

class OtherIncomeCategoriesPage extends ConsumerStatefulWidget {
  const OtherIncomeCategoriesPage({super.key});

  @override
  ConsumerState<OtherIncomeCategoriesPage> createState() =>
      _OtherIncomeCategoriesPageState();
}

class _OtherIncomeCategoriesPageState
    extends ConsumerState<OtherIncomeCategoriesPage> {
  LocalCategory? _categoryPendingDelete;
  LocalCategory? _categoryPendingRestore;
  _CategoryListMode _listMode = _CategoryListMode.active;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(incomeCategoriesProvider);
    final deletedCategoriesAsync = ref.watch(deletedIncomeCategoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _AddCategoryHeader(
            onBack: () => Navigator.of(context).pop(),
            onAdd: _addCategory,
          ),
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
                              'বিদ্যমান আয়ের খাতসমূহ',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          if (_listMode == _CategoryListMode.active)
                            const SizedBox(height: AppSpacing.lg),
                          if (_listMode == _CategoryListMode.active)
                            categoriesAsync.when(
                              data: (items) => _ExistingCategoryList(
                                categories: items,
                                isLoading: false,
                                onDelete: _deleteCategory,
                                onEdit: _editCategory,
                              ),
                              loading: () => _ExistingCategoryList(
                                categories: const [],
                                isLoading: true,
                                onDelete: (_) {},
                                onEdit: (_) {},
                              ),
                              error: (err, _) => Center(child: Text(err.toString())),
                            ),
                          const SizedBox(height: AppSpacing.xxl),
                          if (_listMode == _CategoryListMode.deleted)
                            Text(
                              'ডিলিট করা আয়ের খাতসমূহ',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          if (_listMode == _CategoryListMode.deleted)
                            const SizedBox(height: AppSpacing.lg),
                          if (_listMode == _CategoryListMode.deleted)
                            deletedCategoriesAsync.when(
                              data: (items) => _DeletedCategoryList(
                                categories: items,
                                isLoading: false,
                                onRestore: _restoreCategory,
                              ),
                              loading: () => _DeletedCategoryList(
                                categories: const [],
                                isLoading: true,
                                onRestore: (_) {},
                              ),
                              error: (err, _) => Center(child: Text(err.toString())),
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
    );
  }

  Future<void> _addCategory() async {
    final draft = await showDialog<AddIncomeCategoryDraft>(
      context: context,
      builder: (context) => const AddIncomeCategoryDialog(),
    );

    if (draft == null || draft.name.trim().isEmpty) return;

    try {
      await ref
          .read(appDatabaseProvider)
          .createIncomeCategory(draft.name, details: draft.details);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('নতুন আয়ের খাত যোগ করা হয়েছে')),
      );
    } catch (error) {
      _showError(error);
    }
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
    if (category == null) return;

    try {
      await ref.read(appDatabaseProvider).deleteIncomeCategory(category.id);
      if (!mounted) return;
      setState(() {
        _categoryPendingDelete = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${category.name}" ডিলিট হয়েছে')),
      );
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _confirmRestore() async {
    final category = _categoryPendingRestore;
    if (category == null) return;

    try {
      await ref.read(appDatabaseProvider).restoreIncomeCategory(category.id);
      if (!mounted) return;
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
    final draft = await showDialog<AddIncomeCategoryDraft>(
      context: context,
      builder: (context) => AddIncomeCategoryDialog(
        initialName: category.name,
        initialDetails: category.details,
      ),
    );

    if (draft == null || draft.name.trim().isEmpty) return;

    try {
      await ref.read(appDatabaseProvider).updateIncomeCategory(
            id: category.id,
            name: draft.name,
            details: draft.details,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('আয়ের খাত আপডেট করা হয়েছে')),
      );
    } catch (error) {
      _showError(error);
    }
  }

  void _showError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString())),
    );
  }
}

class _AddCategoryHeader extends StatelessWidget {
  const _AddCategoryHeader({required this.onBack, required this.onAdd});
  final VoidCallback onBack;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryButton,
        boxShadow: AppShadows.soft,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'আয়ের খাতসমূহ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onAdd,
                icon: const Icon(
                  Icons.add_box_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
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
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          _CategoryListToggleButton(
            title: 'বিদ্যমান',
            isSelected: selectedMode == _CategoryListMode.active,
            onPressed: () => onChanged(_CategoryListMode.active),
          ),
          _CategoryListToggleButton(
            title: 'ডিলিট করা',
            isSelected: selectedMode == _CategoryListMode.deleted,
            onPressed: () => onChanged(_CategoryListMode.deleted),
          ),
        ],
      ),
    );
  }
}

class _CategoryListToggleButton extends StatelessWidget {
  const _CategoryListToggleButton({
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadii.md),
            boxShadow: isSelected ? AppShadows.soft : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textMuted,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
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
          'এখনও কোনো আয়ের খাত নেই',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < categories.length; i++) ...[
          _ExistingCategoryTile(
            category: categories[i],
            onDelete: onDelete,
            onEdit: onEdit,
          ),
          if (i != categories.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xs,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFB2DFDB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.syncStatus == 'pending' ? 'সিঙ্ক বাকি' : 'সিঙ্কড',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onEdit(category),
              color: AppColors.textMuted,
              icon: const Icon(Icons.edit_note_rounded, size: 22),
            ),
            IconButton(
              onPressed: () => onDelete(category),
              color: AppColors.textMuted,
              icon: const Icon(Icons.delete_rounded, size: 22),
            ),
          ],
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
          'কোনো ডিলিট করা আয়ের খাত নেই',
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
                      'আয়ের খাত ডিলিট করবেন?',
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
                      'আয়ের খাত ফিরিয়ে আনবেন?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '"${category.name}" আবার বিদ্যমান তালিকায় ফিরবে এবং অনলাইনে সিঙ্ক হবে।',
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

class AddIncomeCategoryDialog extends StatefulWidget {
  final String? initialName;
  final String? initialDetails;

  const AddIncomeCategoryDialog({
    super.key,
    this.initialName,
    this.initialDetails,
  });

  @override
  State<AddIncomeCategoryDialog> createState() => _AddIncomeCategoryDialogState();
}

class _AddIncomeCategoryDialogState extends State<AddIncomeCategoryDialog> {
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
                  widget.initialName != null ? 'আয়ের খাত এডিট' : 'নতুন আয়ের খাত',
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
                labelText: 'খাতের নাম',
                hintText: 'উদা: বোনাস',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                prefixIcon: const Icon(Icons.label_outline_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: 'বিস্তারিত (ঐচ্ছিক)',
                hintText: 'খাত সম্পর্কে কিছু লিখুন...',
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
                        AddIncomeCategoryDraft(
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

class AddIncomeCategoryDraft {
  const AddIncomeCategoryDraft({required this.name, this.details});
  final String name;
  final String? details;
}
