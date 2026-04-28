import 'package:flutter/material.dart';

import '../constants/app_breakpoints.dart';

enum AppPlatform { android, desktop }

class AppPlatformResolver {
  static AppPlatform resolve(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= AppBreakpoints.desktop) {
      return AppPlatform.desktop;
    }

    return AppPlatform.android;
  }

  const AppPlatformResolver._();
}
