import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';


// dart run build_runner build -d

part 'auth_hive_model.g.dart';

@HiveType(typeId:HiveTableConstant.userTableId )
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String userName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phoneNo;

  @HiveField(5)
  final String password;
  @HiveField(6)
  final String? image;


   AuthHiveModel(
      {String? userId,
      required this.userName,
      required this.fullName,
      required this.email,
      required this.phoneNo,
      this.image,
      required this.password}):userId= userId?? const Uuid().v4();


  const AuthHiveModel.initial({
    this.userId="",
    this.userName= "",
    this.fullName="",
    this.email="",
    this.password="",
    this.phoneNo = "",
    this.image=""
  });

  factory AuthHiveModel.fromEntity(AuthEntity entity){
    return AuthHiveModel(
      fullName: entity.fullName,
      userName: entity.username,
      email: entity.email,
      userId: entity.userId,
      password: entity.password,
      phoneNo: entity.phoneNo,
      image: entity.image
    );
  }
  AuthEntity toEntity(){
    return AuthEntity(
      userId:userId , 
      username: userName,
      fullName: fullName, 
      email: email, 
      phoneNo:phoneNo,
      password: password,
      image:image
      );
  }

    static List<AuthHiveModel> fromEntitytoList(List<AuthEntity> entities) {
    return entities.map((e) => AuthHiveModel.fromEntity(e)).toList();
  }

  static List<AuthEntity> toEntityList(List<AuthHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }
  @override
  List<Object?> get props => [userId];
}
