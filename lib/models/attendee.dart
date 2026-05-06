import 'package:hive/hive.dart';

part 'attendee.g.dart';

@HiveType(typeId: 0)
class Attendee {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool checkedIn;

  Attendee({required this.id, required this.name, this.checkedIn = false});
}
