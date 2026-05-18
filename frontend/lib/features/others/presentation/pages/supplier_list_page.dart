import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

enum _SupplierSortMode { nameAsc, nameDesc, newest, oldest }

final _suppliersProvider = StreamProvider<List<LocalSupplier>>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchSuppliersForCurrentShop();
});

class SupplierListPage extends ConsumerStatefulWidget {
  const SupplierListPage({super.key});

  @override
  ConsumerState<SupplierListPage> createState() => _SupplierListPageState();
}

class _SupplierListPageState extends ConsumerState<SupplierListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  _SupplierSortMode _sortMode = _SupplierSortMode.nameAsc;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LocalSupplier> _filterSuppliers(List<LocalSupplier> suppliers) {
    final filtered = _searchQuery.isEmpty
        ? List<LocalSupplier>.of(suppliers)
        : suppliers.where((supplier) {
            final name = supplier.name.toLowerCase();
            final mobile = (supplier.mobile ?? '').toLowerCase();
            final address = (supplier.address ?? '').toLowerCase();
            return name.contains(_searchQuery) ||
                mobile.contains(_searchQuery) ||
                address.contains(_searchQuery);
          }).toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case _SupplierSortMode.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case _SupplierSortMode.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case _SupplierSortMode.newest:
          return b.createdAt.compareTo(a.createdAt);
        case _SupplierSortMode.oldest:
          return a.createdAt.compareTo(b.createdAt);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(_suppliersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _SupplierTopBar(),
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
                suppliersAsync.when(
                  data: (suppliers) {
                    final filteredSuppliers = _filterSuppliers(suppliers);

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.lg,
                      ),
                      children: [
                        _SupplierSearchBox(controller: _searchController),
                        const SizedBox(height: AppSpacing.lg),
                        _SupplierActionRow(
                          onSort: _cycleSortMode,
                          onAdd: () => _showSupplierDialog(),
                          onFilter: _showSortSheet,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _SortStatusLabel(label: _sortModeLabel),
                        const SizedBox(height: AppSpacing.xl),
                        _SectionTitle(
                          title: 'সাপ্লায়ার তালিকা',
                          count: filteredSuppliers.length,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        if (filteredSuppliers.isEmpty)
                          _EmptyCard(
                            message: _searchQuery.isEmpty
                                ? 'কোনো সাপ্লায়ার পাওয়া যায়নি'
                                : 'এই নামে কোনো সাপ্লায়ার নেই',
                          )
                        else
                          for (
                            var i = 0;
                            i < filteredSuppliers.length;
                            i++
                          ) ...[
                            _SupplierCard(
                              supplier: filteredSuppliers[i],
                              onEdit: () => _showSupplierDialog(
                                supplier: filteredSuppliers[i],
                              ),
                              onDelete: () =>
                                  _confirmDelete(filteredSuppliers[i]),
                            ),
                            if (i != filteredSuppliers.length - 1)
                              const SizedBox(height: AppSpacing.md),
                          ],
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      const Center(child: Text('ডাটা লোড করতে সমস্যা হয়েছে')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _sortModeLabel {
    switch (_sortMode) {
      case _SupplierSortMode.nameAsc:
        return 'Sort: A-Z';
      case _SupplierSortMode.nameDesc:
        return 'Sort: Z-A';
      case _SupplierSortMode.newest:
        return 'Sort: Newest first';
      case _SupplierSortMode.oldest:
        return 'Sort: Oldest first';
    }
  }

  void _cycleSortMode() {
    setState(() {
      _sortMode = switch (_sortMode) {
        _SupplierSortMode.nameAsc => _SupplierSortMode.nameDesc,
        _SupplierSortMode.nameDesc => _SupplierSortMode.newest,
        _SupplierSortMode.newest => _SupplierSortMode.oldest,
        _SupplierSortMode.oldest => _SupplierSortMode.nameAsc,
      };
    });
  }

  Future<void> _showSortSheet() async {
    final selected = await showModalBottomSheet<_SupplierSortMode>(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
      ),
      builder: (context) => _SupplierSortSheet(selected: _sortMode),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() => _sortMode = selected);
  }

  Future<void> _showSupplierDialog({LocalSupplier? supplier}) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => _SupplierFormDialog(supplier: supplier),
    );

    if (saved != true || !mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          supplier == null
              ? 'সাপ্লায়ার সফলভাবে যোগ করা হয়েছে'
              : 'সাপ্লায়ার সফলভাবে আপডেট করা হয়েছে',
        ),
      ),
    );
  }

  Future<void> _confirmDelete(LocalSupplier supplier) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('সাপ্লায়ার ডিলিট করবেন?'),
        content: Text('${supplier.name} তালিকা থেকে সরিয়ে দেওয়া হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD9534F),
              foregroundColor: Colors.white,
            ),
            child: const Text('ডিলিট'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    await ref.read(appDatabaseProvider).deleteSupplier(supplier.id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('সাপ্লায়ার ডিলিট করা হয়েছে')));
  }
}

class _SupplierTopBar extends StatelessWidget {
  const _SupplierTopBar();

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
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    'সাপ্লায়ার তালিকা',
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

class _SupplierSearchBox extends StatelessWidget {
  const _SupplierSearchBox({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'সাপ্লায়ারের নাম বা মোবাইল নম্বর দিয়ে খুঁজুন',
                hintStyle: TextStyle(color: AppColors.textMuted),
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupplierActionRow extends StatelessWidget {
  const _SupplierActionRow({
    required this.onSort,
    required this.onAdd,
    required this.onFilter,
  });

  final VoidCallback onSort;
  final VoidCallback onAdd;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallActionIconButton(icon: Icons.sort_rounded, onPressed: onSort),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              boxShadow: AppShadows.button,
            ),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'সাপ্লায়ার যোগ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SmallActionIconButton(icon: Icons.tune_rounded, onPressed: onFilter),
      ],
    );
  }
}

class _SmallActionIconButton extends StatelessWidget {
  const _SmallActionIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}

class _SortStatusLabel extends StatelessWidget {
  const _SortStatusLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            '${_bnNumber(count)} জন',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _SupplierCard extends StatelessWidget {
  const _SupplierCard({
    required this.supplier,
    required this.onEdit,
    required this.onDelete,
  });

  final LocalSupplier supplier;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initials = _getInitials(supplier.name);

    return Container(
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
              color: const Color(0xFFE8F6EF),
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
                  supplier.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  supplier.mobile == null || supplier.mobile!.trim().isEmpty
                      ? 'নম্বর নেই'
                      : _bnNumber(supplier.mobile!),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (supplier.address != null &&
                    supplier.address!.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    supplier.address!,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SupplierIconButton(
                icon: Icons.edit_rounded,
                color: AppColors.primary,
                onPressed: onEdit,
              ),
              const SizedBox(width: AppSpacing.xs),
              _SupplierIconButton(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFD9534F),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return String.fromCharCode(trimmed.runes.first).toUpperCase();
  }
}

class _SupplierIconButton extends StatelessWidget {
  const _SupplierIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: color, size: 21),
      ),
    );
  }
}

class _SupplierSortSheet extends StatelessWidget {
  const _SupplierSortSheet({required this.selected});

  final _SupplierSortMode selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort suppliers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _SortTile(
              title: 'A-Z',
              icon: Icons.sort_by_alpha_rounded,
              selected: selected == _SupplierSortMode.nameAsc,
              onTap: () => Navigator.pop(context, _SupplierSortMode.nameAsc),
            ),
            _SortTile(
              title: 'Z-A',
              icon: Icons.sort_by_alpha_rounded,
              selected: selected == _SupplierSortMode.nameDesc,
              onTap: () => Navigator.pop(context, _SupplierSortMode.nameDesc),
            ),
            _SortTile(
              title: 'Newest first',
              icon: Icons.arrow_downward_rounded,
              selected: selected == _SupplierSortMode.newest,
              onTap: () => Navigator.pop(context, _SupplierSortMode.newest),
            ),
            _SortTile(
              title: 'Oldest first',
              icon: Icons.arrow_upward_rounded,
              selected: selected == _SupplierSortMode.oldest,
              onTap: () => Navigator.pop(context, _SupplierSortMode.oldest),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  const _SortTile({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: selected ? AppColors.primary : AppColors.textMuted,
      ),
      title: Text(title),
      trailing: selected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
    );
  }
}

class _SupplierFormDialog extends ConsumerStatefulWidget {
  const _SupplierFormDialog({this.supplier});

  final LocalSupplier? supplier;

  @override
  ConsumerState<_SupplierFormDialog> createState() =>
      _SupplierFormDialogState();
}

class _SupplierFormDialogState extends ConsumerState<_SupplierFormDialog> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  String? _nameErrorText;
  bool _isSaving = false;

  bool get _isEditing => widget.supplier != null;

  @override
  void initState() {
    super.initState();
    final supplier = widget.supplier;
    if (supplier != null) {
      _nameController.text = supplier.name;
      _mobileController.text = supplier.mobile ?? '';
      _addressController.text = supplier.address ?? '';
    }
    _nameController.addListener(_clearNameError);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_clearNameError)
      ..dispose();
    _mobileController.dispose();
    _addressController.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    _isEditing
                        ? Icons.edit_rounded
                        : Icons.person_add_alt_1_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _isEditing
                          ? 'সাপ্লায়ার এডিট করুন'
                          : 'নতুন সাপ্লায়ার যোগ করুন',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              if (!_isEditing && _canPickContacts) ...[
                OutlinedButton.icon(
                  onPressed: _isSaving ? null : _pickFromContacts,
                  icon: const Icon(Icons.contacts_rounded),
                  label: const Text('ফোন বুক থেকে নিন'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              TextField(
                controller: _nameController,
                autofocus: true,
                enabled: !_isSaving,
                decoration: InputDecoration(
                  labelText: 'সাপ্লায়ারের নাম',
                  hintText: 'উদা: Rahim Enterprise',
                  errorText: _nameErrorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  prefixIcon: const Icon(Icons.storefront_outlined),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _mobileController,
                enabled: !_isSaving,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'মোবাইল নম্বর',
                  hintText: 'উদা: 01XXXXXXXXX',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  prefixIcon: const Icon(Icons.call_outlined),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _addressController,
                enabled: !_isSaving,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'ঠিকানা',
                  hintText: 'সাপ্লায়ারের ঠিকানা',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text('বাতিল'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _submit,
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
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('সেভ করুন'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearNameError() {
    if (_nameErrorText == null) {
      return;
    }
    setState(() => _nameErrorText = null);
  }

  Future<void> _pickFromContacts() async {
    if (!_canPickContacts) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('এই ডিভাইসে ফোন বুক থেকে নেওয়া যাবে না')),
      );
      return;
    }

    final status = await FlutterContacts.permissions.request(
      PermissionType.read,
    );
    if (status != PermissionStatus.granted) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('কন্টাক্ট পারমিশন দেওয়া হয়নি')),
      );
      return;
    }

    final contactId = await FlutterContacts.native.showPicker();
    if (contactId == null) {
      return;
    }

    final contact = await FlutterContacts.get(
      contactId,
      properties: {ContactProperty.name, ContactProperty.phone},
    );
    if (!mounted || contact == null) {
      return;
    }

    final name = (contact.displayName ?? '').trim();
    final phone = contact.phones.isEmpty
        ? ''
        : _cleanPhoneNumber(contact.phones.first.number);

    setState(() {
      if (name.isNotEmpty) {
        _nameController.text = name;
      }
      if (phone.isNotEmpty) {
        _mobileController.text = phone;
      }
    });
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameErrorText = 'সাপ্লায়ারের নাম লিখুন');
      return;
    }

    setState(() {
      _isSaving = true;
      _nameErrorText = null;
    });

    try {
      final database = ref.read(appDatabaseProvider);
      if (_isEditing) {
        await database.updateSupplier(
          id: widget.supplier!.id,
          name: name,
          mobile: _mobileController.text,
          address: _addressController.text,
        );
      } else {
        await database.createSupplier(
          name: name,
          mobile: _mobileController.text,
          address: _addressController.text,
        );
      }

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSaving = false;
        _nameErrorText = error.toString();
      });
    }
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      width: double.infinity,
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

String _bnNumber(Object value) {
  const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  return value.toString().replaceAllMapped(
    RegExp(r'\d'),
    (match) => digits[int.parse(match.group(0)!)],
  );
}

String _cleanPhoneNumber(String value) {
  return value.replaceAll(RegExp(r'[\s\-()]'), '').trim();
}

bool get _canPickContacts {
  if (kIsWeb) {
    return false;
  }
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
