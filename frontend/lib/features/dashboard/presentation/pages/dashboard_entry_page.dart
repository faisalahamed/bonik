import 'package:flutter/material.dart';

import '../../../../core/platform/app_platform.dart';
import 'dashboard_android_page.dart';
import 'dashboard_desktop_page.dart';

class DashboardEntryPage extends StatelessWidget {
  const DashboardEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = AppPlatformResolver.resolve(context);

    return switch (platform) {
      AppPlatform.android => const DashboardAndroidPage(),
      AppPlatform.desktop => const DashboardDesktopPage(),
    };
  }
}
