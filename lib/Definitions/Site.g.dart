// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Site.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteAdapter extends TypeAdapter<Site> {
  @override
  final typeId = 3;

  @override
  Site read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Site(
      siteName: fields[0] as String,
    )
      ..addressStreet = fields[1] as String
      ..city = fields[2] as String
      ..state = fields[3] as String
      ..zip = fields[4] as String
      ..phone = fields[5] as String
      ..hoursOfOperation = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Site obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.siteName)
      ..writeByte(1)
      ..write(obj.addressStreet)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.zip)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.hoursOfOperation);
  }
}
