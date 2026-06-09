# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-06-10

### Added
- `IconRichTextBuilder` utility class with `buildSpan()` and `buildRichText()` static
  methods for composing inline rich text from a flat list of `String`, `IconData`, and
  `InlineSpan` parts.
- `CustomCodePointExtension` on `int` — adds `toCustomTextSpan()` and `toCustomText()`
  for rendering any Unicode code point using a custom icon font family (e.g. FontAwesome,
  Ionicons, Remix Icons). The font must be registered in the host app's pubspec.yaml.
- `toWidgetSpan()` on `IconData` — embeds the icon as a `WidgetSpan` within an inline
  widget tree. Accepts `iconSize`, `iconColor`, `iconStyle`, `alignment`, and
  `semanticsLabel`.
- Interactive tabbed playground in the `example/` app covering all features: basic icon
  text, rich text builder, custom font icons, and `IconTextLabel`.
- Detailed `///` documentation comments on all public APIs for IDE hover support in
  VS Code, Android Studio, and other Dart-aware editors.

### Changed
- Bumped to stable `1.0.0`.
- Updated `README` with full API documentation, inline rich content examples, custom
  font icon examples, attribution, badges, and a clean roadmap.
- Updated `pubspec.yaml` description for better pub.dev SEO; replaced `inline-icons`
  topic with `custom-fonts`.


## [0.0.3] - 2025-06-01

### Added
- Support for `onTap` callback in `toTextSpan`, enabling interactive text behavior.
- Allows tapping on the combined icon+text span for actions like navigation, popups, etc.
- Internally wraps the span with a `TapGestureRecognizer` when `onTap` is provided.
- Added `IconTextLabel` widget for a declarative and convenient way to render icons as
  styled text with prefix, postfix, and full layout/accessibility control.


## [0.0.2] - 2025-06-01

### Added
- Support for overriding `iconColor` specifically for the icon character in both `toText`
  and `toTextSpan`.
- Support for setting a `semanticsLabel` for screen readers via `iconSemanticsLabel` in
  `toTextSpan` and `semanticsLabel` in `toText`.
- Support for `textAlign`, `textDirection`, `maxLines`, and `textOverflow` in `toText`.
- Full parameter forwarding to improve flexibility and integration into different layouts
  and accessibility contexts.

## [0.0.1] - 2025-05-30

### Added
- Initial release with `IconData` to `Text` / `TextSpan` extension methods.
- Support for both Material and Cupertino icons.
- Preserves original icon `fontFamily` and `fontPackage`.
- `iconToString()` extension method to convert `IconData` to a raw string character.
- `toTextSpan(...)` method with optional `TextStyle`, prefix, and postfix support.
- `toText(...)` method that wraps `toTextSpan` into a `Text.rich(...)` widget.
- Example app showcasing usage of `toText`, `toTextSpan`, and `iconToString()`.
- README with package banner, badges, usage instructions, and screenshot preview.
