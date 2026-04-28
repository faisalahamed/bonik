import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold_message.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldMessage(
        title: 'User management',
        message: 'This feature can manage users inside the currently selected store.',
      ),
    );
  }
}
