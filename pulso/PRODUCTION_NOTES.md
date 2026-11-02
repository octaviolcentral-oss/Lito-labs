# Pulso — Production Notes

## Architecture
- Clean Architecture (domain / data / presentation)
- Riverpod for dependency injection
- Local-first (SQLite via sqflite)

## Features
- Home: water, caffeine, nap, junk tracking
- Dopamine: private mood/time logging
- Reports: daily summary
- Settings: privacy toggles, Smart Coach
- Smart Coach: contextual toasts
- Foreground service for background mode

## Accessibility
- Semantics on all main screens
- TalkBack/VoiceOver labels

## Testing
- Unit tests for domain entities
- Widget test for HomeScreen
- Run: `flutter test`

## Performance
- Lazy screen loading in MainShell
- IndexedStack for state preservation

## Build
- GitHub Actions: `.github/workflows/build-apk.yml`
- Output: `pulso-apk` artifact
