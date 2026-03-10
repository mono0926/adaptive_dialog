## 2.7.0 - 2026-03-10

- Support text selection for dialogs (#65)
  - Added `AdaptiveSelectionMode` to control text selection behavior.
  - Text is now selectable by default on Web and Desktop platforms.
  - Supported in all dialog functions.
- Support keyboard shortcuts (Enter and Escape) for dialogs (#61)
  - Enter: Trigger default action or submit text input
  - Escape: Cancel or close dialog

## 2.6.0

- fullyCapitalizedForMaterial is deprecated and change default to false
  - According to [Material Design Guidelines](https://m3.material.io/components/dialogs/overview), button texts should not be fully capitalized.
  - If you want to keep the old behavior, please set `fullyCapitalizedForMaterial: true` explicitly.

## 2.5.0

- Changed to Flutter 3.35.0 and Dart 3.9.0 or higher
