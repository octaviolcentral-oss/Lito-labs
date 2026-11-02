import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso/screens/splash_screen.dart';

void main() {
  testWidgets('SplashScreen renders logo', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SplashScreen())),
    );
    expect(find.text('Pulso'), findsOneWidget);
    expect(find.text('P'), findsOneWidget);
  });
}
