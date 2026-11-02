abstract class SettingsRepository {
  Future<bool> getDopamineLock();
  Future<void> setDopamineLock(bool value);
  Future<bool> getDiscreteMode();
  Future<void> setDiscreteMode(bool value);
  Future<bool> getSmartCoach();
  Future<void> setSmartCoach(bool value);
}
