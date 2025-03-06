// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameHiveModelAdapter extends TypeAdapter<GameHiveModel> {
  @override
  final int typeId = 1;

  @override
  GameHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHiveModel(
      gameId: fields[0] as String?,
      gameName: fields[1] as String,
      gamePlatform: fields[6] as dynamic,
      gameDescription: fields[2] as String,
      gameImagePath: fields[3] as String,
      category: fields[4] as dynamic,
      gamePrice: fields[5] as num,
    );
  }

  @override
  void write(BinaryWriter writer, GameHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.gameId)
      ..writeByte(1)
      ..write(obj.gameName)
      ..writeByte(2)
      ..write(obj.gameDescription)
      ..writeByte(3)
      ..write(obj.gameImagePath)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.gamePrice)
      ..writeByte(6)
      ..write(obj.gamePlatform);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
