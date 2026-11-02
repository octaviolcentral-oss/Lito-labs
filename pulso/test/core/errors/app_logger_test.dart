import 'package:flutter_test/flutter_test.dart';
import 'package:pulso/core/errors/app_logger.dart';

void main() {
  group('AppLogger', () {
    test('info does not throw', () {
      expect(() => AppLogger.info('test'), returnsNormally);
    });

    test('error does not throw', () {
      expect(() => AppLogger.error('test error', error: Exception('x')), returnsNormally);
    });
  });
}
