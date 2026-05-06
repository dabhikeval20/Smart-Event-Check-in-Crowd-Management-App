import 'package:hive/hive.dart';
import '../models/attendee.dart';

class HiveService {
  static const String attendeeBox = 'attendees';

  static Future<void> registerAdapters() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AttendeeAdapter());
    }
    await Hive.openBox<Attendee>(attendeeBox);
  }

  static Future<List<Attendee>> getAttendees() async {
    final box = Hive.box<Attendee>(attendeeBox);
    return box.values.toList();
  }

  static Future<void> addAttendee(Attendee attendee) async {
    final box = Hive.box<Attendee>(attendeeBox);
    await box.add(attendee);
  }
}
