import '../../../core/errors/app_logger.dart';
import '../../../services/database_service.dart';
import '../domain/repositories/dopamine_repository.dart';

class DopamineRepositoryImpl implements DopamineRepository {
  final DatabaseService _db;
  DopamineRepositoryImpl(this._db);

  @override
  Future<void> save(String timeOfDay, String feeling) async {
    try {
      await _db.insertRecord('dopamine', value: '$timeOfDay|$feeling');
      AppLogger.info('Saved dopamine: $timeOfDay / $feeling', tag: 'DopamineRepo');
    } catch (e, st) {
      AppLogger.error('Failed to save dopamine', error: e, stack: st, tag: 'DopamineRepo');
      rethrow;
    }
  }

  @override
  Future<int> countToday() async {
    try {
      final count = await _db.getCount('dopamine');
      AppLogger.info('Dopamine count: $count', tag: 'DopamineRepo');
      return count;
    } catch (e, st) {
      AppLogger.error('Failed to count dopamine', error: e, stack: st, tag: 'DopamineRepo');
      rethrow;
    }
  }
}
