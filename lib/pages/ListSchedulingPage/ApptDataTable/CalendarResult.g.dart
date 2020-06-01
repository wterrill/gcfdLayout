// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalendarResult.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarResultAdapter extends TypeAdapter<CalendarResult> {
  @override
  final typeId = 1;

  @override
  CalendarResult read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarResult(
      startTime: fields[0] as String,
      agency: fields[1] as String,
      auditType: fields[2] as String,
      programNum: fields[3] as String,
      programType: fields[4] as String,
      auditor: fields[5] as String,
      status: fields[6] as String,
      message: fields[7] as String,
      programTypeColor: fields[8] as Color,
    )
      ..startDateTime = fields[9] as DateTime
      ..siteInfo = fields[10] as Site;
  }

  @override
  void write(BinaryWriter writer, CalendarResult obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.agency)
      ..writeByte(2)
      ..write(obj.auditType)
      ..writeByte(3)
      ..write(obj.programNum)
      ..writeByte(4)
      ..write(obj.programType)
      ..writeByte(5)
      ..write(obj.auditor)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.message)
      ..writeByte(8)
      ..write(obj.programTypeColor)
      ..writeByte(9)
      ..write(obj.startDateTime)
      ..writeByte(10)
      ..write(obj.siteInfo);
  }
}
