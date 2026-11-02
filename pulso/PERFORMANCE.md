# Pulso — Performance Notes

## Applied Optimizations
- Lazy screen loading in MainShell
- IndexedStack for state preservation
- Theme constants to reduce Color() allocations
- AppTheme.scaled() for dynamic text

## Profiling Steps (on real device)
1. Connect device
2. Run: `flutter run --profile`
3. Open DevTools: `flutter pub global run devtools`
4. Record a session while navigating between tabs
5. Check for jank (>16ms frames)

## Known Areas
- Database queries run on main isolate (sqflite handles threading)
- No image assets (vector/PNG icons only)
- Splash screen is 1.2s fixed delay

## Recommendations
- Profile with real data volume
- Move heavy DB work to compute() if jank appears
- Add const constructors where possible
