import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.shadowTint,
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color(0x29005344),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  const AppShadows._();
}
