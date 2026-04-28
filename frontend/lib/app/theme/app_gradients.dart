import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primary,
      AppColors.primaryContainer,
    ],
  );

  static const LinearGradient backgroundGlowTop = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0x12006D5B),
      Color(0x00006D5B),
    ],
  );

  static const LinearGradient backgroundGlowBottom = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0x12006A63),
      Color(0x00006A63),
    ],
  );

  const AppGradients._();
}
