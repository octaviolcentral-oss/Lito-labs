import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'services/database_service.dart';
import 'services/foreground_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
  await ForegroundService.init();
  runApp(const ProviderScope(child: PulsoApp()));
}

class PulsoApp extends StatelessWidget {
  const PulsoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulso',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}
