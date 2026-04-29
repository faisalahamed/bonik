import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';
import '../../data/category_sync_service.dart';

class AddProductCategoryDraft {
  const AddProductCategoryDraft({required this.name, this.details});

  final String name;
  final String? details;
}

class AddProductCategoryPage extends ConsumerStatefulWidget {
  const AddProductCategoryPage({super.key});

  @override
  ConsumerState<AddProductCategoryPage> createState() =>
      _AddProductCategoryPageState();
}

class _AddProductCategoryPageState
    extends ConsumerState<AddProductCategoryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _scrollController = ScrollController();
  late final Stream<List<LocalCategory>> _categoriesStream;
  String? _editingCategoryId;

  bool get _isEditing => _editingCategoryId != null;

  @override
  void initState() {
    super.initState();
    _categoriesStream = ref
        .read(appDatabaseProvider)
        .watchProductCategoriesForCurrentShop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
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
                    controller: _scrollController,
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
                            _AddCategoryFormCard(
                              nameController: _nameController,
                              descriptionController: _descriptionController,
                              isEditing: _isEditing,
                              onCancelEdit: _isEditing
                                  ? _clearEditingState
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            _SaveCategoryButton(
                              isEditing: _isEditing,
                              onPressed: _save,
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            Text(
                              'বিদ্যমান প্রোডাক্ট ক্যাটাগরিসমূহ',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            StreamBuilder<List<LocalCategory>>(
                              stream: _categoriesStream,
                              builder: (context, snapshot) {
                                return _ExistingCategoryList(
                                  categories: snapshot.data ?? const [],
                                  isLoading:
                                      snapshot.connectionState ==
                                          ConnectionState.waiting &&
                                      !snapshot.hasData,
                                  editingCategoryId: _editingCategoryId,
                                  onEdit: _editCategory,
                                  onDelete: _deleteCategory,
                                );
                              },
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            Text(
                              'একটি নতুন বিভাগ তৈরি করুন যা আপনার পণ্যগুলো সুন্দরভাবে সাজাতে সাহায্য করবে।',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.textMuted,
                                    fontStyle: FontStyle.italic,
                                    height: 1.45,
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
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final details = _descriptionController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ক্যাটাগরির নাম লিখুন')));
      return;
    }

    final editingCategoryId = _editingCategoryId;
    if (editingCategoryId == null) {
      Navigator.of(
        context,
      ).pop(AddProductCategoryDraft(name: name, details: details));
      return;
    }

    try {
      await ref
          .read(appDatabaseProvider)
          .updateProductCategory(
            id: editingCategoryId,
            name: name,
            details: details,
          );
      if (!mounted) {
        return;
      }
      _clearEditingState();
      _syncProductCategories();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ক্যাটাগরি আপডেট হয়েছে')));
    } catch (error) {
      _showError(error);
    }
  }

  void _editCategory(LocalCategory category) {
    setState(() {
      _editingCategoryId = category.id;
      _nameController.text = category.name;
      _descriptionController.text = category.details ?? '';
    });
    _scrollToTop();
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  Future<void> _deleteCategory(LocalCategory category) async {
    try {
      await ref.read(appDatabaseProvider).deleteProductCategory(category.id);
      if (!mounted) {
        return;
      }
      if (_editingCategoryId == category.id) {
        _clearEditingState();
      }
      _syncProductCategories();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('"${category.name}" ডিলিট হয়েছে')));
    } catch (error) {
      _showError(error);
    }
  }

  void _clearEditingState() {
    setState(() {
      _editingCategoryId = null;
      _nameController.clear();
      _descriptionController.clear();
    });
  }

  void _syncProductCategories() {
    if (!mounted) {
      return;
    }

    ref
        .read(categorySyncServiceProvider)
        .syncProductCategories()
        .catchError((_) {});
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

class _AddCategoryFormCard extends StatelessWidget {
  const _AddCategoryFormCard({
    required this.nameController,
    required this.descriptionController,
    required this.isEditing,
    required this.onCancelEdit,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final bool isEditing;
  final VoidCallback? onCancelEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: AppShadows.soft,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 10,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadii.xl),
                  bottomLeft: Radius.circular(AppRadii.xl),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            isEditing ? 'ক্যাটাগরি এডিট' : 'নতুন এন্ট্রি',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        if (onCancelEdit != null)
                          IconButton(
                            onPressed: onCancelEdit,
                            color: AppColors.textMuted,
                            icon: const Icon(Icons.close_rounded),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _AddCategoryLabelInput(
                      label: 'ক্যাটাগরির নাম',
                      controller: nameController,
                      hintText: 'ক্যাটাগরির নাম',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _AddCategoryLabelInput(
                      label: 'পণ্যের বিস্তারিত',
                      controller: descriptionController,
                      hintText: 'ক্যাটাগরি সম্পর্কে বিস্তারিত লিখুন...',
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    //work later: add image upload feature
                    // const _CategoryImageUploadBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCategoryLabelInput extends StatelessWidget {
  const _AddCategoryLabelInput({
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          height: maxLines == 1 ? 50 : 74,
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            textInputAction: maxLines == 1
                ? TextInputAction.next
                : TextInputAction.newline,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.textMuted.withValues(alpha: 0.50),
                fontWeight: FontWeight.w700,
              ),
              filled: true,
              fillColor: AppColors.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                borderSide: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: maxLines == 1 ? AppSpacing.sm : AppSpacing.xs,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//work later: add image upload feature
// class _CategoryImageUploadBox extends StatelessWidget {
//   const _CategoryImageUploadBox();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'ক্যাটাগরি ইমেজ',
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             color: AppColors.primary,
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         const SizedBox(height: AppSpacing.md),
//         Container(
//           height: 142,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.surfaceContainerLow,
//             borderRadius: BorderRadius.circular(AppRadii.lg),
//             border: Border.all(
//               color: AppColors.primary.withValues(alpha: 0.22),
//               width: 2,
//               strokeAlign: BorderSide.strokeAlignInside,
//             ),
//           ),
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.add_a_photo_rounded,
//                     size: 44,
//                     color: AppColors.primary.withValues(alpha: 0.46),
//                   ),
//                   const SizedBox(height: AppSpacing.sm),
//                   Text(
//                     'ছবি আপলোড করুন',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                       color: AppColors.primary.withValues(alpha: 0.78),
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     'PNG, JPG অথবা JPEG',
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: AppColors.textMuted.withValues(alpha: 0.48),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _SaveCategoryButton extends StatelessWidget {
  const _SaveCategoryButton({required this.isEditing, required this.onPressed});

  final bool isEditing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppGradients.primaryButton,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.button,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.xl),
            ),
          ),
          child: Text(
            isEditing ? 'আপডেট করুন' : 'সেভ করুন',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
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
    required this.editingCategoryId,
    required this.onEdit,
    required this.onDelete,
  });

  final List<LocalCategory> categories;
  final bool isLoading;
  final String? editingCategoryId;
  final ValueChanged<LocalCategory> onEdit;
  final ValueChanged<LocalCategory> onDelete;

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
              isEditing: categories[i].id == editingCategoryId,
              onEdit: onEdit,
              onDelete: onDelete,
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

class _ExistingCategoryTile extends StatelessWidget {
  const _ExistingCategoryTile({
    required this.category,
    required this.isEditing,
    required this.onEdit,
    required this.onDelete,
  });

  final LocalCategory category;
  final bool isEditing;
  final ValueChanged<LocalCategory> onEdit;
  final ValueChanged<LocalCategory> onDelete;

  @override
  Widget build(BuildContext context) {
    final isPending = category.syncStatus == 'pending';
    final details = category.details?.trim();

    return ColoredBox(
      color: isEditing
          ? AppColors.primary.withValues(alpha: 0.05)
          : Colors.transparent,
      child: Padding(
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
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () => onDelete(category),
              color: AppColors.textMuted,
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
