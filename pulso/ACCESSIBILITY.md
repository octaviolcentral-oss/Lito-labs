# Pulso — Accessibility Notes

## Implemented
- Semantics on Home, Dopamine, Reports, Settings
- Text scales with system size (`AppTheme.scaled`)
- Contrast notes in theme
- Buttons have semantic labels

## Audit Steps (on real device)
1. Enable TalkBack (Android) or VoiceOver (iOS)
2. Navigate through all screens
3. Verify all interactive elements are announced
4. Check focus order
5. Test with large text size

## Recommendations
- Add more semantic labels to dynamic content
- Test with high contrast mode
- Verify touch target sizes (>=48dp)
