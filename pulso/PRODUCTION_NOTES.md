# Pulso — Production Notes

See `ARCHITECTURE.md` for full architecture.

## Quick Start
1. Clone repo
2. `cd pulso && flutter pub get`
3. `flutter run` (or build via GitHub Actions)

## CI
- Workflow: `.github/workflows/build-apk.yml`
- Runs: `dart analyze`, `flutter test --coverage`, `flutter build apk --debug`
- Artifact: `pulso-apk` (`app-debug.apk`)

## Signing
Uses debug keystore so the APK signature stays consistent across CI runs.
This allows the downloaded APK to update the installed app.

## Local Data
- SQLite: water, caffeine, junk, nap, dopamine records
- SharedPreferences: settings (dopamine lock, discrete mode, smart coach)

## Accessibility
- Semantics on Home, Dopamine, Reports, Settings
- Text scales with system size
- Contrast documented in `AppTheme`

## Testing
```bash
cd pulso
flutter test
```

## Edge Cases
- DB failure → returns empty summary, UI shows friendly error + retry
- Empty day → "Aún no hay registros hoy"
