// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Audit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditAdapter extends TypeAdapter<Audit> {
  @override
  final typeId = 6;

  @override
  Audit read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audit(
      questionnaire: (fields[4] as List)
          ?.map((dynamic e) => (e as Map)?.map((dynamic k, dynamic v) =>
              MapEntry(
                  k as String,
                  (v as List)
                      ?.map((dynamic e) => (e as Map)?.cast<String, dynamic>())
                      ?.toList())))
          ?.toList(),
      calendarResult: fields[5] as CalendarResult,
    )
      ..name = fields[0] as String
      ..sections = (fields[1] as List)?.cast<Section>()
      ..completed = fields[2] as bool
      ..metadata = (fields[3] as List)?.cast<MetaData>();
  }

  @override
  void write(BinaryWriter writer, Audit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sections)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.metadata)
      ..writeByte(4)
      ..write(obj.questionnaire)
      ..writeByte(5)
      ..write(obj.calendarResult);
  }
}
