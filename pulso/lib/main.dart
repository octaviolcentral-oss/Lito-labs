import 'package:flutter/material.dart';
import 'screens/main_shell.dart';
import 'services/database_service.dart';
import 'services/foreground_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
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
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Color(0xFFA14D2F), fontSize: 12);
            }
            return const TextStyle(color: Color(0xFF8A8A8A), fontSize: 12);
          }),
        ),
      ),
      home: const MainShell(),
    );
  }
}
