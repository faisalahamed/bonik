import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';

final incomeCategoriesProvider = StreamProvider<List<LocalCategory>>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchIncomeCategoriesForCurrentShop();
});

final todayIncomeTotalProvider = StreamProvider<double>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchTodayIncomeTotalForCurrentShop();
});
