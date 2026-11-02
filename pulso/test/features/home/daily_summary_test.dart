import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/features/home/domain/entities/daily_summary.dart';

void main() {
  group('DailySummary', () {
    test('empty has zero values', () {
      expect(DailySummary.empty.waterMl, 0);
      expect(DailySummary.empty.caffeineCount, 0);
      expect(DailySummary.empty.junkCount, 0);
      expect(DailySummary.empty.napCount, 0);
      expect(DailySummary.empty.dopamineCount, 0);
    });

    test('can create with values', () {
      const s = DailySummary(waterMl: 500, caffeineCount: 2, junkCount: 1, napCount: 0, dopamineCount: 1);
      expect(s.waterMl, 500);
      expect(s.caffeineCount, 2);
    });
  });
}
