import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFFF9F8F6);
  static const Color textMain = Color(0xFF2C3E35);
  static const Color textSecondary = Color(0xFF6B7A73);
  static const Color accent = Color(0xFFD27D5E);
  static const Color accentText = Color(0xFFA14D2F);
  static const Color cardBg = Colors.white;
  static const Color btnBg = Color(0xFFF4F2EF);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.light),
    scaffoldBackgroundColor: bg,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textMain),
      bodyMedium: TextStyle(color: textMain),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: btnBg,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(color: selected ? accentText : const Color(0xFF8A8A8A), fontSize: 12);
      }),
    ),
  );
}
