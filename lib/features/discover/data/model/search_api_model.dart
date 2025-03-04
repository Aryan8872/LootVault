import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';


part 'search_api_model.g.dart';

@JsonSerializable()
class SearchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String fullName;
  final String userName;
  final String? image;
  final String phoneNo;
  final String email;

  final String password;

  const SearchApiModel(
      {this.userId,
      required this.fullName,
      required this.userName,
      this.image,
      required this.phoneNo,
      required this.email,
      required this.password});

  factory SearchApiModel.fromJson(Map<String, dynamic> json)=>
  _$SearchApiModelFromJson(json);

  Map<String,dynamic> toJson()=>_$SearchApiModelToJson(this);


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

    factory SearchApiModel.fromEntity(AuthEntity entity) {
    return SearchApiModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      image: entity.image,
      phoneNo: entity.phoneNo,
      userName: entity.username,
    );
  }

    static List<AuthEntity> toEntityList(List<SearchApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<SearchApiModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((entity) => SearchApiModel.fromEntity(entity))
        .toList();
  }

  


  @override
  // TODO: implement props
  List<Object?> get props =>
      [userId, fullName,email, userName, image, phoneNo, userName, password];
}
