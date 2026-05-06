import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/hive_service.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> loadEvents() async {
    _events = await HiveService.getEvents();
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    await HiveService.addEvent(event);
    _events.add(event);
    notifyListeners();
  }
}
