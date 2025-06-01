# Changelog

All notable changes to this project will be documented in this file.

## [0.0.3] - 2025-06-01

### Added
- Support for `onTap` callback in `toTextSpan`, enabling interactive text behavior.
- Allows tapping on the combined icon+text span for actions like navigation, popups, etc.
- Internally wraps the span with a `TapGestureRecognizer` when `onTap` is provided.
- Added IconTextLabel widget for a declarative and convenient way to render icons as styled text with prefix, postfix, and full layout/accessibility control


## [0.0.2] - 2025-06-01

### Added
- Support for overriding `iconColor` specifically for the icon character in both `toText` and `toTextSpan`.
- Support for setting a `semanticsLabel` for screen readers via `iconSemanticsLabel` in `toTextSpan` and `semanticsLabel` in `toText`.
- Support for `textAlign`, `textDirection`, `maxLines`, and `textOverflow` in `toText`.
- Full parameter forwarding to improve flexibility and integration into different layouts and accessibility contexts.

## [0.0.1] - 2025-05-30

### Added
- Initial release with `IconData` to `Text` / `TextSpan` extension methods.
- Support for both **Material** and **Cupertino** icons.
- Preserves original icon `fontFamily` and `fontPackage`.
- `iconToString()` extension method to convert `IconData` to a raw string character.
- `toTextSpan(...)` method with:
  - Optional `TextStyle` for base styling.
  - Optional `prefix` and `postfix` support.
- `toText(...)` method that wraps `toTextSpan` into a `Text.rich(...)` widget.
- Example app showcasing usage of `toText`, `toTextSpan`, and `iconToString()` method.
- README file with:
  - Package banner.
  - Pub.dev and GitHub badges.
  - Full usage instructions.
  - API documentation.
  - Screenshot preview of example app.
