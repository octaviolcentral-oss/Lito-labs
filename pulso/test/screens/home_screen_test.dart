import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen shows greeting and water', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pulso'), findsOneWidget);
    expect(find.textContaining('ml'), findsWidgets);
  });
}
