import '../models/participant_model.dart';

class ParticipantValidator {
  static String? validateId(String id) {
    if (id.isEmpty) return 'Participant ID cannot be empty.';
    // Add more format checks if needed
    return null;
  }

  static bool isDuplicate(String id, List<ParticipantModel> participants) {
    return participants.any((p) => p.id == id);
  }

  static bool isCapacityFull(int currentCount, int maxCapacity) {
    return currentCount >= maxCapacity;
  }

  static DateTime recordCheckInTime() {
    return DateTime.now();
  }

  static String getSuccessMessage() => 'Check-in successful!';
  static String getDuplicateMessage() => 'Participant already checked in.';
  static String getInvalidIdMessage() => 'Invalid participant ID.';
  static String getCapacityFullMessage() => 'Event capacity full!';
}
