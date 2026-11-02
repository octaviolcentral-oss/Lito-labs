abstract class DopamineRepository {
  Future<void> save(String timeOfDay, String feeling);
  Future<int> countToday();
}
