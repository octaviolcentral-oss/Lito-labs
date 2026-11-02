# Pulso — Architecture

## Overview
Local-first Flutter app for tracking hydration, caffeine, naps, junk food, and dopamine.
Data stays on device. No cloud sync.

## Layers

### Domain
- `features/home/domain/` — `DailySummary`, `HomeRepository`
- `features/dopamine/domain/` — `DopamineEntry`, `DopamineRepository`
- `features/settings/domain/` — `SettingsRepository`

Pure Dart. No Flutter dependencies.

### Data
- `features/home/data/home_repository_impl.dart` — implements `HomeRepository` using `DatabaseService`
- `features/dopamine/data/dopamine_repository_impl.dart`
- `features/settings/data/settings_repository_impl.dart` — uses `SharedPreferences`

### Presentation
- `screens/` — UI widgets (Home, Dopamine, Reports, Settings, Splash)
- Uses Riverpod providers from `providers/home_provider.dart`

### Core
- `core/theme/app_theme.dart` — colors, text scaling
- `core/errors/` — `AppLogger`, `Result<T>`

## State Management
Riverpod:
- `databaseProvider` — singleton `DatabaseService`
- `homeRepositoryProvider` — `HomeRepository`
- `dopamineRepositoryProvider` — `DopamineRepository`
- `settingsRepositoryProvider` — `SettingsRepository` (async)
- `todaySummaryProvider` — `FutureProvider<DailySummary>`

## Local Storage
- SQLite via `sqflite` (`DatabaseService`)
- SharedPreferences for settings

## Accessibility
- Semantics on all main screens
- Text scales with system size (`AppTheme.scaled`)
- Contrast notes in theme

## Testing
- Unit: domain entities, logger, result
- Widget: HomeScreen, SplashScreen
- Run: `flutter test`

## Build
- GitHub Actions: `.github/workflows/build-apk.yml`
- Output: `app-debug.apk` (debug signing for consistent updates)
- Artifact: `pulso-apk`
