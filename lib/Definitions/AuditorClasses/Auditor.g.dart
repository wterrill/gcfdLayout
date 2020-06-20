// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Auditor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditorAdapter extends TypeAdapter<Auditor> {
  @override
  final typeId = 12;

  @override
  Auditor read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auditor(
      auditorName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Auditor obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.auditorName);
  }
}
