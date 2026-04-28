import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold_message.dart';

class DashboardDesktopPage extends StatelessWidget {
  const DashboardDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldMessage(
        title: 'Desktop shell',
        message: 'Desktop and PC-specific layout can be added here later without disturbing the Android view structure.',
      ),
    );
  }
}
