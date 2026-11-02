import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DatabaseService integration', () {
    late DatabaseService db;

    setUp(() async {
      db = DatabaseService.instance;
      await db.init();
    });

    test('insert and count water', () async {
      await db.insertRecord('water', value: '250');
      final count = await db.getCount('water');
      expect(count, greaterThanOrEqualTo(1));
    });

    test('getWaterTotal sums values', () async {
      await db.insertRecord('water', value: '100');
      await db.insertRecord('water', value: '150');
      final total = await db.getWaterTotal();
      expect(total, greaterThanOrEqualTo(250));
    });

    test('insert caffeine and count', () async {
      await db.insertRecord('caffeine');
      final count = await db.getCount('caffeine');
      expect(count, greaterThanOrEqualTo(1));
    });
  });
}
