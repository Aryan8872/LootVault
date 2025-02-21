import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';


part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String fullName;
  final String userName;
  final String? image;
  final String phoneNo;
  final String email;

  final String password;

  const AuthApiModel(
      {this.userId,
      required this.fullName,
      required this.userName,
      this.image,
      required this.phoneNo,
      required this.email,
      required this.password});

  factory AuthApiModel.fromJson(Map<String, dynamic> json)=>
  _$AuthApiModelFromJson(json);

  Map<String,dynamic> toJson()=>_$AuthApiModelToJson(this);


  AuthEntity toEntity(){
    return AuthEntity(
      userId: userId,
      username: userName,
      fullName: fullName,
      email: email,
      password: password,
      phoneNo: phoneNo,
      image: image
      );
  }

    factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      image: entity.image,
      phoneNo: entity.phoneNo,
      userName: entity.username,
    );
  }

    static List<AuthEntity> toEntityList(List<AuthApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<AuthApiModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((entity) => AuthApiModel.fromEntity(entity))
        .toList();
  }

  


  @override
  // TODO: implement props
  List<Object?> get props =>
      [userId, fullName,email, userName, image, phoneNo, userName, password];
}
