import '../../../core/errors/app_logger.dart';
import '../../../services/database_service.dart';
import '../domain/entities/daily_summary.dart';
import '../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DatabaseService _db;

  HomeRepositoryImpl(this._db);

  @override
  Future<DailySummary> getTodaySummary() async {
    try {
      final s = DailySummary(
        waterMl: await _db.getWaterTotal(),
        caffeineCount: await _db.getCount('caffeine'),
        junkCount: await _db.getCount('junk'),
        napCount: await _db.getCount('nap'),
        dopamineCount: await _db.getCount('dopamine'),
      );
      AppLogger.info('Loaded summary: ${s.waterMl}ml water', tag: 'HomeRepo');
      return s;
    } catch (e, st) {
      AppLogger.error('Failed to load summary', error: e, stack: st, tag: 'HomeRepo');
      // Return empty on failure so UI can still render
      return DailySummary.empty;
    }
  }

  @override
  Future<void> addWater(int ml) async {
    try {
      await _db.insertRecord('water', value: ml.toString());
      AppLogger.info('Added water: $ml ml', tag: 'HomeRepo');
    } catch (e, st) {
      AppLogger.error('Failed to add water', error: e, stack: st, tag: 'HomeRepo');
      rethrow;
    }
  }

  @override
  Future<void> addCaffeine() async {
    try {
      await _db.insertRecord('caffeine');
      AppLogger.info('Added caffeine', tag: 'HomeRepo');
    } catch (e, st) {
      AppLogger.error('Failed to add caffeine', error: e, stack: st, tag: 'HomeRepo');
      rethrow;
    }
  }

  @override
  Future<void> addNap(int minutes) async {
    try {
      await _db.insertRecord('nap', value: minutes.toString());
      AppLogger.info('Added nap: $minutes min', tag: 'HomeRepo');
    } catch (e, st) {
      AppLogger.error('Failed to add nap', error: e, stack: st, tag: 'HomeRepo');
      rethrow;
    }
  }

  @override
  Future<void> addJunk(String type) async {
    try {
      await _db.insertRecord('junk', value: type);
      AppLogger.info('Added junk: $type', tag: 'HomeRepo');
    } catch (e, st) {
      AppLogger.error('Failed to add junk', error: e, stack: st, tag: 'HomeRepo');
      rethrow;
    }
  }
}
