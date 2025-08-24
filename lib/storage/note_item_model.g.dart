// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteItemModelAdapter extends TypeAdapter<NoteItemModel> {
  @override
  final int typeId = 1;

  @override
  NoteItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as String,
      lastEdited: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.lastEdited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
