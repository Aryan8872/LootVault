// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 3;

  @override
  PostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveModel(
      postId: fields[0] as String?,
      postUser: fields[1] as String,
      title: fields[2] as String,
      content: fields[3] as String,
      likes: (fields[4] as List?)?.cast<String>(),
      dislikes: (fields[5] as List?)?.cast<String>(),
      postComments: (fields[6] as List?)?.cast<CommentHiveModel>(),
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.postUser)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.likes)
      ..writeByte(5)
      ..write(obj.dislikes)
      ..writeByte(6)
      ..write(obj.postComments)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
