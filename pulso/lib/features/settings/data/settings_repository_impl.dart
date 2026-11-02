import 'package:shared_preferences/shared_preferences.dart';
import '../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  SettingsRepositoryImpl(this._prefs);

  @override
  Future<bool> getDopamineLock() async => _prefs.getBool('dopamine_lock') ?? false;
  @override
  Future<void> setDopamineLock(bool v) => _prefs.setBool('dopamine_lock', v);

  @override
  Future<bool> getDiscreteMode() async => _prefs.getBool('discrete_mode') ?? false;
  @override
  Future<void> setDiscreteMode(bool v) => _prefs.setBool('discrete_mode', v);

  @override
  Future<bool> getSmartCoach() async => _prefs.getBool('smart_coach') ?? true;
  @override
  Future<void> setSmartCoach(bool v) => _prefs.setBool('smart_coach', v);
}
