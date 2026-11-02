import '../../../services/database_service.dart';
import '../domain/repositories/dopamine_repository.dart';

class DopamineRepositoryImpl implements DopamineRepository {
  final DatabaseService _db;
  DopamineRepositoryImpl(this._db);

  @override
  Future<void> save(String timeOfDay, String feeling) =>
      _db.insertRecord('dopamine', value: '$timeOfDay|$feeling');

  @override
  Future<int> countToday() => _db.getCount('dopamine');
}
