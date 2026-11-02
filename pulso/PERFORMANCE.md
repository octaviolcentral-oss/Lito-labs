# Pulso — Performance Notes

## Applied Optimizations
- Lazy screen loading in MainShell (screens created on first visit)
- IndexedStack for state preservation
- Theme constants to reduce Color() allocations
- AppTheme.scaled() for dynamic text without rebuilds

## Recommended Profiling
1. Run with DevTools:
   ```bash
   flutter run --profile
   ```
2. Open DevTools → Performance tab
3. Record a session while navigating between tabs
4. Check for jank (>16ms frames)

## Known Areas
- Database queries are synchronous on main isolate (sqflite handles this)
- No image assets (vector icons only)
- Splash screen is 1.2s fixed delay

## Next Steps for Excellence
- Move heavy DB work to compute() if needed
- Add const constructors where possible
- Profile with real data volume
