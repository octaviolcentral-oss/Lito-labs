import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('User flow', () {
    late DatabaseService db;

    setUp(() async {
      db = DatabaseService.instance;
      await db.init();
    });

    test('register water then see in total', () async {
      final before = await db.getWaterTotal();
      await db.insertRecord('water', value: '250');
      final after = await db.getWaterTotal();
      expect(after, greaterThanOrEqualTo(before + 250));
    });

    test('register caffeine then count increases', () async {
      final before = await db.getCount('caffeine');
      await db.insertRecord('caffeine');
      final after = await db.getCount('caffeine');
      expect(after, greaterThan(before));
    });

    test('register dopamine then count increases', () async {
      final before = await db.getCount('dopamine');
      await db.insertRecord('dopamine', value: 'Mañana|Aburrido');
      final after = await db.getCount('dopamine');
      expect(after, greaterThan(before));
    });
  });
}
