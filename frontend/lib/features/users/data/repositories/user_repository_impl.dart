import '../../domain/entities/app_user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<AppUser>> fetchUsersForStore(String storeId) async {
    return const [];
  }
}
