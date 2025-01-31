import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
