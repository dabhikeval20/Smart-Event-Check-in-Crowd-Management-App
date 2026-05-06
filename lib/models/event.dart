import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final int maxCapacity;

  Event({required this.name, required this.date, required this.time, required this.maxCapacity});
}
