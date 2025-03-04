import 'package:loot_vault/features/auth/data/model/auth_api_model.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<void> createUser(AuthEntity entity);
  Future<String> loginUser(String username, String password);
  Future<List<AuthHiveModel>> getalluser();
  Future<AuthApiModel> updateProfile(AuthEntity user);
    Future<AuthApiModel> getUserData(String userId);

  Future<void> changePassword(
      String userId, String currentPassword, String newPassword);

}
