import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<Store>> fetchStores() async {
    return const [];
  }
}
