import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
  
  const LoginParams.initial():
  email='',
  password='';
  
  
  @override
  List<Object?> get props => [email ,password];
}


class LoginUsecase implements UsecaseWithParams<String,LoginParams>{
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUsecase(this.repository,this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
// IF api then store token in shared preferences
    return repository.loginUser(params.email, params.password).then(
      (value){
        return value.fold((failure)=>Left(failure),
         (token){
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.getToken().then((value){
            print(value);
          });
          return Right(token);
         }
         );
      }
    );  }

  
}