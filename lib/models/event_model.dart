import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: 2)
class EventModel {
  @HiveField(0)
  final String eventName;
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final int maxCapacity;

  EventModel({
    required this.eventName,
    required this.dateTime,
    required this.maxCapacity,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        eventName: json['eventName'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        maxCapacity: json['maxCapacity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'dateTime': dateTime.toIso8601String(),
        'maxCapacity': maxCapacity,
      };
}
