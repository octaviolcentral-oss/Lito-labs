import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/features/home/domain/entities/daily_summary.dart';

void main() {
  group('HomeRepository contract', () {
    test('DailySummary.empty is zero', () {
      expect(DailySummary.empty.waterMl, 0);
      expect(DailySummary.empty.caffeineCount, 0);
    });
  });
}
