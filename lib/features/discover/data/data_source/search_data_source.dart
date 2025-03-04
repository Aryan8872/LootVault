import 'package:loot_vault/features/auth/data/model/auth_api_model.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/discover/data/model/search_api_model.dart';

abstract interface class ISearchDataSource {
  
  Future<List<SearchApiModel>> getalluser();
 


}
