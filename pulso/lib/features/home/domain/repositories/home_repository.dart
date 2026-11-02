import '../entities/daily_summary.dart';

abstract class HomeRepository {
  Future<DailySummary> getTodaySummary();
  Future<void> addWater(int ml);
  Future<void> addCaffeine();
  Future<void> addNap(int minutes);
  Future<void> addJunk(String type);
}
