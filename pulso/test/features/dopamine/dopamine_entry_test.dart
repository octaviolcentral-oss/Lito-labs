import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/features/dopamine/domain/entities/dopamine_entry.dart';

void main() {
  group('DopamineEntry', () {
    test('can create entry', () {
      final e = DopamineEntry(timeOfDay: 'Mañana', feeling: 'Aburrido', createdAt: DateTime.now());
      expect(e.timeOfDay, 'Mañana');
      expect(e.feeling, 'Aburrido');
    });
  });
}
