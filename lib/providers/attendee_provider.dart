import 'package:flutter/material.dart';
import '../models/attendee.dart';
import '../services/hive_service.dart';

class AttendeeProvider extends ChangeNotifier {
  List<Attendee> _attendees = [];

  List<Attendee> get attendees => _attendees;

  Future<void> loadAttendees() async {
    _attendees = await HiveService.getAttendees();
    notifyListeners();
  }

  void addAttendee(Attendee attendee) {
    HiveService.addAttendee(attendee);
    _attendees.add(attendee);
    notifyListeners();
  }
}
