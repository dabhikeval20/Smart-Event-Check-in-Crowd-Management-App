import 'package:hive/hive.dart';

part 'participant_model.g.dart';

@HiveType(typeId: 3)
class ParticipantModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool checkedIn;
  @HiveField(3)
  final DateTime? checkInTime;
  @HiveField(4)
  final bool syncStatus;

  ParticipantModel({
    required this.id,
    required this.name,
    this.checkedIn = false,
    this.checkInTime,
    this.syncStatus = false,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => ParticipantModel(
        id: json['id'] as String,
        name: json['name'] as String,
        checkedIn: json['checkedIn'] as bool? ?? false,
        checkInTime: json['checkInTime'] != null ? DateTime.parse(json['checkInTime']) : null,
        syncStatus: json['syncStatus'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'checkedIn': checkedIn,
        'checkInTime': checkInTime?.toIso8601String(),
        'syncStatus': syncStatus,
      };
}
