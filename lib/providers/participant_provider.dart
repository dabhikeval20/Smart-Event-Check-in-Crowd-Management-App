import 'package:flutter/material.dart';
import '../models/participant_model.dart';
import '../services/hive_service.dart';

class ParticipantProvider extends ChangeNotifier {
  // Private participant list
  List<ParticipantModel> _participants = [];

  // Public getter
  List<ParticipantModel> get participants => _participants;

  // Load participants from Hive database
  Future<void> loadParticipants() async {
    try {
      _participants = await HiveService.getParticipants();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading participants: $e");
    }
  }

  // Add new participant
  Future<bool> addParticipant(
    ParticipantModel participant,
    int eventCapacity,
  ) async {
    try {
      // Prevent duplicate participant ID
      bool alreadyExists =
          _participants.any((p) => p.id == participant.id);

      if (alreadyExists) {
        return false;
      }

      // Check event capacity using checked-in participants only
      int checkedInCount =
          _participants.where((p) => p.checkedIn).length;

      if (checkedInCount >= eventCapacity) {
        return false;
      }

      // Save participant to Hive
      await HiveService.addParticipant(participant);

      // Add locally
      _participants.add(participant);

      // Update UI
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("Error adding participant: $e");
      return false;
    }
  }

  // Check-in participant
  Future<bool> checkInParticipant(String id) async {
    try {
      // Find participant index
      final index =
          _participants.indexWhere((p) => p.id == id);

      // Invalid ID
      if (index == -1) {
        return false;
      }

      // Prevent duplicate check-in
      if (_participants[index].checkedIn) {
        return false;
      }

      // Create updated participant object
      final updatedParticipant = ParticipantModel(
        id: _participants[index].id,
        name: _participants[index].name,
        checkedIn: true,
        checkInTime: DateTime.now().toString(),
        syncStatus: false,
      );

      // Update Hive database
      await HiveService.updateParticipant(
        updatedParticipant,
        index,
      );

      // Update local list
      _participants[index] = updatedParticipant;

      // Refresh UI
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("Error checking in participant: $e");
      return false;
    }
  }

  // Search participant by ID or name
  List<ParticipantModel> searchParticipants(String query) {
    return _participants.where((participant) {
      return participant.id
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          participant.name
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  // Get checked-in participant count
  int get checkedInCount {
    return _participants
        .where((p) => p.checkedIn)
        .length;
  }

  // Get remaining capacity
  int remainingCapacity(int maxCapacity) {
    return maxCapacity - checkedInCount;
  }
}