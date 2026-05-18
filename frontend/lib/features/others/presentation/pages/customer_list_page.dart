import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/database/app_database.dart';

enum _CustomerSortMode { nameAsc, nameDesc, newest, oldest }

final _customersProvider = StreamProvider<List<LocalCustomer>>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchCustomersForCurrentShop();
});

class CustomerListPage extends ConsumerStatefulWidget {
  const CustomerListPage({super.key});

  @override
  ConsumerState<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends ConsumerState<CustomerListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  _CustomerSortMode _sortMode = _CustomerSortMode.newest;

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

  List<LocalCustomer> _filterCustomers(List<LocalCustomer> customers) {
    final filtered = _searchQuery.isEmpty
        ? List<LocalCustomer>.of(customers)
        : customers.where((customer) {
            final name = customer.name.toLowerCase();
            final phone = (customer.phone ?? '').toLowerCase();
            final address = (customer.address ?? '').toLowerCase();
            return name.contains(_searchQuery) ||
                phone.contains(_searchQuery) ||
                address.contains(_searchQuery);
          }).toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case _CustomerSortMode.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case _CustomerSortMode.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case _CustomerSortMode.newest:
          return b.createdAt.compareTo(a.createdAt);
        case _CustomerSortMode.oldest:
          return a.createdAt.compareTo(b.createdAt);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(_customersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _CustomerTopBar(),
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
                customersAsync.when(
                  data: (customers) {
                    final filteredCustomers = _filterCustomers(customers);

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.lg,
                      ),
                      children: [
                        _CustomerSearchBox(controller: _searchController),
                        const SizedBox(height: AppSpacing.lg),
                        _CustomerActionRow(
                          onSort: _cycleSortMode,
                          onAdd: () => _showCustomerDialog(),
                          onFilter: _showSortSheet,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _SortStatusLabel(label: _sortModeLabel),
                        const SizedBox(height: AppSpacing.xl),
                        _SectionTitle(
                          title: 'কাস্টমার তালিকা',
                          count: filteredCustomers.length,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        if (filteredCustomers.isEmpty)
                          _EmptyCard(
                            message: _searchQuery.isEmpty
                                ? 'কোনো কাস্টমার পাওয়া যায়নি'
                                : 'এই নামে কোনো কাস্টমার নেই',
                          )
                        else
                          for (
                            var i = 0;
                            i < filteredCustomers.length;
                            i++
                          ) ...[
                            _CustomerCard(
                              customer: filteredCustomers[i],
                              onEdit: () => _showCustomerDialog(
                                customer: filteredCustomers[i],
                              ),
                              onDelete: () =>
                                  _confirmDelete(filteredCustomers[i]),
                            ),
                            if (i != filteredCustomers.length - 1)
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
      case _CustomerSortMode.nameAsc:
        return 'Sort: A-Z';
      case _CustomerSortMode.nameDesc:
        return 'Sort: Z-A';
      case _CustomerSortMode.newest:
        return 'Sort: Newest first';
      case _CustomerSortMode.oldest:
        return 'Sort: Oldest first';
    }
  }

  void _cycleSortMode() {
    setState(() {
      _sortMode = switch (_sortMode) {
        _CustomerSortMode.nameAsc => _CustomerSortMode.nameDesc,
        _CustomerSortMode.nameDesc => _CustomerSortMode.newest,
        _CustomerSortMode.newest => _CustomerSortMode.oldest,
        _CustomerSortMode.oldest => _CustomerSortMode.nameAsc,
      };
    });
  }

  Future<void> _showSortSheet() async {
    final selected = await showModalBottomSheet<_CustomerSortMode>(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
      ),
      builder: (context) => _CustomerSortSheet(selected: _sortMode),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() => _sortMode = selected);
  }

  Future<void> _showCustomerDialog({LocalCustomer? customer}) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => _CustomerFormDialog(customer: customer),
    );

    if (saved != true || !mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          customer == null
              ? 'কাস্টমার সফলভাবে যোগ করা হয়েছে'
              : 'কাস্টমার সফলভাবে আপডেট করা হয়েছে',
        ),
      ),
    );
  }

  Future<void> _confirmDelete(LocalCustomer customer) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('কাস্টমার ডিলিট করবেন?'),
        content: Text('${customer.name} তালিকা থেকে সরিয়ে দেওয়া হবে।'),
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

    await ref.read(appDatabaseProvider).deleteCustomer(customer.id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('কাস্টমার ডিলিট করা হয়েছে')));
  }
}

class _CustomerTopBar extends StatelessWidget {
  const _CustomerTopBar();

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
                    'কাস্টমার তালিকা',
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

class _CustomerSearchBox extends StatelessWidget {
  const _CustomerSearchBox({required this.controller});

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
                hintText: 'কাস্টমারের নাম বা মোবাইল নম্বর দিয়ে খুঁজুন',
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

class _CustomerActionRow extends StatelessWidget {
  const _CustomerActionRow({
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
                    'কাস্টমার যোগ',
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

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
  });

  final LocalCustomer customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initials = _getInitials(customer.name);

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
              color: const Color(0xFFB9F3E7),
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
                  customer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customer.phone == null || customer.phone!.trim().isEmpty
                      ? 'নম্বর নেই'
                      : _bnNumber(customer.phone!),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (customer.address != null &&
                    customer.address!.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    customer.address!,
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
              _CustomerIconButton(
                icon: Icons.edit_rounded,
                color: AppColors.primary,
                onPressed: onEdit,
              ),
              const SizedBox(width: AppSpacing.xs),
              _CustomerIconButton(
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

class _CustomerIconButton extends StatelessWidget {
  const _CustomerIconButton({
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

class _CustomerSortSheet extends StatelessWidget {
  const _CustomerSortSheet({required this.selected});

  final _CustomerSortMode selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort customers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _SortTile(
              title: 'A-Z',
              icon: Icons.sort_by_alpha_rounded,
              selected: selected == _CustomerSortMode.nameAsc,
              onTap: () => Navigator.pop(context, _CustomerSortMode.nameAsc),
            ),
            _SortTile(
              title: 'Z-A',
              icon: Icons.sort_by_alpha_rounded,
              selected: selected == _CustomerSortMode.nameDesc,
              onTap: () => Navigator.pop(context, _CustomerSortMode.nameDesc),
            ),
            _SortTile(
              title: 'Newest first',
              icon: Icons.arrow_downward_rounded,
              selected: selected == _CustomerSortMode.newest,
              onTap: () => Navigator.pop(context, _CustomerSortMode.newest),
            ),
            _SortTile(
              title: 'Oldest first',
              icon: Icons.arrow_upward_rounded,
              selected: selected == _CustomerSortMode.oldest,
              onTap: () => Navigator.pop(context, _CustomerSortMode.oldest),
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

class _CustomerFormDialog extends ConsumerStatefulWidget {
  const _CustomerFormDialog({this.customer});

  final LocalCustomer? customer;

  @override
  ConsumerState<_CustomerFormDialog> createState() =>
      _CustomerFormDialogState();
}

class _CustomerFormDialogState extends ConsumerState<_CustomerFormDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String? _nameErrorText;
  bool _isSaving = false;

  bool get _isEditing => widget.customer != null;

  @override
  void initState() {
    super.initState();
    final customer = widget.customer;
    if (customer != null) {
      _nameController.text = customer.name;
      _phoneController.text = customer.phone ?? '';
      _addressController.text = customer.address ?? '';
    }
    _nameController.addListener(_clearNameError);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_clearNameError)
      ..dispose();
    _phoneController.dispose();
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
                          ? 'কাস্টমার এডিট করুন'
                          : 'নতুন কাস্টমার যোগ করুন',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _nameController,
                autofocus: true,
                enabled: !_isSaving,
                decoration: InputDecoration(
                  labelText: 'কাস্টমারের নাম',
                  hintText: 'উদা: Rahim Uddin',
                  errorText: _nameErrorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _phoneController,
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
                  hintText: 'কাস্টমারের ঠিকানা',
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

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameErrorText = 'কাস্টমারের নাম লিখুন');
      return;
    }

    setState(() {
      _isSaving = true;
      _nameErrorText = null;
    });

    try {
      final database = ref.read(appDatabaseProvider);
      if (_isEditing) {
        await database.updateCustomer(
          id: widget.customer!.id,
          name: name,
          phone: _phoneController.text,
          address: _addressController.text,
        );
      } else {
        await database.createCustomer(
          name: name,
          phone: _phoneController.text,
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
