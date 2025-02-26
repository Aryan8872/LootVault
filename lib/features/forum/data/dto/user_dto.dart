import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';


@JsonSerializable()
class UserDTO {
  @JsonKey(name: "_id")
  final String id;
  final String username;

  UserDTO({
    required this.id,
    required this.username,
  });

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}
