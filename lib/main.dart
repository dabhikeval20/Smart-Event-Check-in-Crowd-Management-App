import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/attendee_provider.dart';
import 'services/hive_service.dart';
import 'widgets/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveService.registerAdapters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendeeProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Event Check-in',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BottomNav(),
      ),
    );
  }
}