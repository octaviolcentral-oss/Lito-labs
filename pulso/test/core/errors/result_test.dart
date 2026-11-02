import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/core/errors/result.dart';

void main() {
  group('Result', () {
    test('success has data and no error', () {
      const r = Result.success(42);
      expect(r.isSuccess, true);
      expect(r.data, 42);
      expect(r.error, isNull);
    });

    test('failure has error and no data', () {
      const r = Result.failure('oops');
      expect(r.isFailure, true);
      expect(r.error, 'oops');
      expect(r.data, isNull);
    });
  });
}
