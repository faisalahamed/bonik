import '../entities/app_user.dart';

abstract class UserRepository {
  Future<List<AppUser>> fetchUsersForStore(String storeId);
}
