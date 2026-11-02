# Pulso — Pixel Perfect Notes

## Current State
- Cream background (#F9F8F6)
- White cards with 24px radius
- Soft shadows
- Terracotta accent (#D27D5E)
- 2x2 grid of action buttons
- Bottom nav with squircle indicator
- PNG launcher icons

## Comparison Steps (on real device)
1. Open web prototype and Flutter app side by side
2. Compare spacing, font sizes, colors
3. Note differences in:
   - Card padding
   - Button sizes
   - Typography weights
   - Shadow blur

## Known Differences
- Flutter uses Material icons (web uses custom SVGs)
- Bottom nav uses NavigationBar (web uses custom CSS)
- Logo is text "P" (web uses SVG curve)

## Recommendations
- Generate custom SVG icons for action buttons
- Match exact spacing from web prototype
- Use custom font if needed
