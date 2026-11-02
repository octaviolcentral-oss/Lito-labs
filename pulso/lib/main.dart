import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'services/database_service.dart';
import 'services/notification_service.dart';
import 'services/foreground_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
  await NotificationService.instance.init();
  await ForegroundService.init();
  runApp(const PulsoApp());
}

class PulsoApp extends StatelessWidget {
  const PulsoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulso',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD27D5E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F8F6),
        fontFamily: 'Inter',
      ),
      home: const HomeScreen(),
    );
  }
}
