import 'package:flutter/material.dart';

class SmartCoach {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static void onCaffeine(BuildContext context, int hour) {
    if (hour >= 14) {
      show(context, '💡 La cafeína tarde en el día puede afectar tu sueño profundo. ¿Qué tal un vaso de agua?');
    }
  }

  static void onJunk(BuildContext context) {
    show(context, '💡 Registrado. Recuerda que el azúcar da un bajón. Toma agua y estira tus piernas.');
  }

  static void onDopamineBored(BuildContext context) {
    show(context, '💡 Es normal buscar estímulo, pero tu energía es mejor con acción. Intenta tomar agua o caminar 5 minutos.');
  }
}
