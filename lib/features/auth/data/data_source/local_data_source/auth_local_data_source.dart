import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/auth/data/data_source/auth_data_source.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource{
  final HiveService hiveService;

  AuthLocalDataSource({required this.hiveService});


  @override
  Future<void> createUser(AuthEntity entity)async {
    try{
      var userModel = AuthHiveModel.fromEntity(entity);
      await hiveService.createUser(userModel);
      getalluser();
    }
    catch(e){
      throw Exception(e);
    }
  }

  @override
Future<String> loginUser(String username, String password) async {
  try {
    final user = await hiveService.login(username, password);
    if (user?.email=='') {
      throw Exception("Invalid email or password");
    }
    return Future.value("success");
  } catch (e) {
    return Future.error(e);
  }
}

  
  @override
  Future<List<AuthHiveModel>> getalluser()async {
    var data = await hiveService.getAllAuth();
    var lest = AuthHiveModel.toEntityList(data);
    print(lest);
    return data;
  }


}