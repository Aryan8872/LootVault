import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/forum/data/model/post_hive_model.dart';
import 'package:loot_vault/features/games/data/model/game_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_student_management.db';

    Hive.init(path);
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PostHiveModelAdapter());
    Hive.registerAdapter(GameHiveModelAdapter());
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
      var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () =>
            const AuthHiveModel.initial(), // Return null if no match is found
      );
      return auth;
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  Future<void> createUser(AuthHiveModel model) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(model.userId, model);
  }

  Future<void> createGame(GameHiveModel model) async {
    var box = await Hive.openBox<GameHiveModel>(HiveTableConstant.gameBox);
    await box.put(model.gameId, model);
  }

  Future<List<GameHiveModel>> getAllGames() async {
    var box = await Hive.openBox<GameHiveModel>(HiveTableConstant.gameBox);
    return box.values.toList();
  }

  Future<void> createPost(PostHiveModel model) async {
    print('hive service ma data $model');
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.put(model.postId, model);
  }

  Future<List<PostHiveModel>> getallPost() async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    var post = box.values.toList();
    print("post haru hive bata ${post.toList()}");
    return post;
  }
}
