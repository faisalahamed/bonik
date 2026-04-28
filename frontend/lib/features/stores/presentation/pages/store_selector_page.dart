import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold_message.dart';

class StoreSelectorPage extends StatelessWidget {
  const StoreSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldMessage(
        title: 'Store selector',
        message: 'Use this page for choosing or switching between stores after login.',
      ),
    );
  }
}
