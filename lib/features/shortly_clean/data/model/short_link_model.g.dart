// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_link_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortLinkModelAdapter extends TypeAdapter<ShortLinkModel> {
  @override
  final int typeId = 1;

  @override
  ShortLinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortLinkModel(
      id: fields[0] as String,
      fullShortLink: fields[1] as String,
      isCopied: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ShortLinkModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullShortLink)
      ..writeByte(2)
      ..write(obj.isCopied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortLinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
