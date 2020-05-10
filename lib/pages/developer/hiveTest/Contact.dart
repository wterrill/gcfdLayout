import 'package:hive/hive.dart';
part 'Contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;

  Contact(this.name, this.age);
}
