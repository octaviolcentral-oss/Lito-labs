import '../../../services/database_service.dart';
import '../domain/entities/daily_summary.dart';
import '../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DatabaseService _db;

  HomeRepositoryImpl(this._db);

  @override
  Future<DailySummary> getTodaySummary() async {
    return DailySummary(
      waterMl: await _db.getWaterTotal(),
      caffeineCount: await _db.getCount('caffeine'),
      junkCount: await _db.getCount('junk'),
      napCount: await _db.getCount('nap'),
      dopamineCount: await _db.getCount('dopamine'),
    );
  }

  @override
  Future<void> addWater(int ml) => _db.insertRecord('water', value: ml.toString());

  @override
  Future<void> addCaffeine() => _db.insertRecord('caffeine');

  @override
  Future<void> addNap(int minutes) => _db.insertRecord('nap', value: minutes.toString());

  @override
  Future<void> addJunk(String type) => _db.insertRecord('junk', value: type);
}
