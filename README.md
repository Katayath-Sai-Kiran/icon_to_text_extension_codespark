<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/banners/banner.png" alt="Banner"/>

# icon_to_text_extension_codespark

Convert any Flutter `IconData` — Material, Cupertino, or any custom icon font — into inline `Text` or `TextSpan` widgets with correct font rendering. Includes a rich text builder, full accessibility support, and zero dependencies.

<p align="center">
  Built by <a href="https://ksaikiran.dev">Katayath Sai Kiran</a> · <a href="https://github.com/Katayath-Sai-Kiran">@Katayath-Sai-Kiran</a>
</p>

<p align="center">
  <a href="https://pub.dev/packages/icon_to_text_extension_codespark"><img src="https://img.shields.io/pub/v/icon_to_text_extension_codespark.svg" alt="pub version"/></a>
  <a href="https://pub.dev/packages/icon_to_text_extension_codespark/score"><img src="https://img.shields.io/pub/points/icon_to_text_extension_codespark" alt="pub points"/></a>
  <a href="https://pub.dev/packages/icon_to_text_extension_codespark"><img src="https://img.shields.io/pub/likes/icon_to_text_extension_codespark" alt="pub likes"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"/></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/platform-flutter-02569B?logo=flutter" alt="platform: flutter"/></a>
  <a href="https://pub.dev/packages/icon_to_text_extension_codespark"><img src="https://img.shields.io/badge/Icon--to--Text-1.0.0-orange" alt="Icon to Text"/></a>
</p>

---

## Features

- Supports Material, Cupertino, and any custom icon font
- Converts `IconData` to `TextSpan` or `Text` widgets
- Custom font icon support — render any code point with your own font family via `toCustomTextSpan()` and `toCustomText()`
- `IconRichTextBuilder` for composing inline text with mixed icons and strings in a single call
- `toWidgetSpan()` for embedding icons as `WidgetSpan` with widget-level alignment control
- Vertical centering: `iconHeight` and `strutStyle` to correct icon/text alignment across different font sizes
- Optional `onTap` callback for interactive icon text
- Preserves original icon `fontFamily` and `fontPackage` automatically
- Prefix and postfix text support — combine icon and surrounding text in one widget
- Per-segment style overrides: `prefixStyle`, `postfixStyle`, `iconStyle`
- Optional `iconSize` and `iconColor` overrides for the icon glyph only
- `iconHeight` — line-height multiplier to fix vertical misalignment with mixed font sizes
- `iconTextBaseline` — `TextBaseline` for the icon span for precise baseline alignment
- `strutStyle`, `textHeightBehavior`, `textScaler`, `softWrap` for complete layout control
- `fontFeatures` with clear guidance on icon font rendering behavior
- `IconPosition` enum — place the icon at the start, middle, or end of the text
- Optional `semanticsLabel` for screen readers
- Support for `TextAlign`, `TextDirection`, `TextBaseline`, `maxLines`, and `TextOverflow`
- `iconToString()` utility to get the raw Unicode character from any `IconData`
- `IconTextLabel` declarative widget for easy layout composition
- Null-safe, zero dependencies

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  icon_to_text_extension_codespark: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Usage

### Convert IconData to TextSpan

```dart
final span = CupertinoIcons.share.toTextSpan(
  style: TextStyle(fontSize: 24, color: Colors.blue),
);
```

### Convert IconData to Text widget

```dart
final widget = Icons.share.toText(
  style: TextStyle(fontSize: 30, color: Colors.green),
  textAlign: TextAlign.center,
);
```

### Add prefix and postfix

```dart
CupertinoIcons.share.toTextSpan(
  prefix: 'Tap ',
  postfix: ' to share',
  style: TextStyle(fontSize: 24, color: Colors.black),
)
```

### Use in RichText

```dart
RichText(
  text: TextSpan(
    children: [
      TextSpan(text: 'Click the '),
      CupertinoIcons.share.toTextSpan(style: TextStyle(color: Colors.black)),
      TextSpan(text: ' button to share.'),
    ],
  ),
)
```

### Inline rich content with IconRichTextBuilder

Build a `TextSpan` or `Text.rich` widget from a flat list of strings, icons, and custom spans:

```dart
IconRichTextBuilder.buildRichText(
  [
    'Tap ',
    CupertinoIcons.share,
    ' or ',
    Icons.send,
    ' to continue',
  ],
  defaultStyle: TextStyle(fontSize: 18),
  defaultIconColor: Colors.blue,
)
```

Mix in custom spans for full control:

```dart
Text.rich(
  IconRichTextBuilder.buildSpan(
    [
      'You have ',
      TextSpan(
        text: '3 unread',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ' — tap ',
      CupertinoIcons.bell_fill,
      ' to view.',
    ],
    defaultStyle: TextStyle(fontSize: 17),
    defaultIconColor: Colors.orange,
  ),
)
```

### Embed as WidgetSpan

Use `toWidgetSpan()` when you need widget-level alignment or padding around the icon in an inline context:

```dart
Text.rich(
  TextSpan(
    children: [
      TextSpan(text: 'Check your '),
      Icons.inbox.toWidgetSpan(iconSize: 20, iconColor: Colors.blue),
      TextSpan(text: ' for updates.'),
    ],
  ),
)
```

Use `alignment` and `baseline` together for typographic baseline alignment:

```dart
Icons.star.toWidgetSpan(
  iconSize: 20,
  iconColor: Colors.amber,
  alignment: PlaceholderAlignment.baseline,
  baseline: TextBaseline.alphabetic,
)
```

### Control text scaling

Pass `TextScaler.noScaling` to opt out of the system font size setting for a specific widget:

```dart
Icons.star.toText(
  iconSize: 24,
  textScaler: TextScaler.noScaling,
)
```

### Vertical centering

Icon fonts have different internal line metrics from body text fonts. If the icon appears too high or too low relative to adjacent text, two parameters solve this:

**Quick fix — `iconHeight`**: sets the line-height multiplier on the glyph span. `1.0` removes extra leading above and below the icon. Try values between `0.9` and `1.3`.

```dart
Icons.star.toText(
  prefix: 'Rating: ',
  style: TextStyle(fontSize: 14),
  iconSize: 20,
  iconHeight: 1.0,
)
```

**Robust fix — combine `iconHeight` with `strutStyle`**: `StrutStyle(forceStrutHeight: true)` locks every span in the widget to the same line box, which reliably centers the icon regardless of font metric differences:

```dart
Icons.star.toText(
  prefix: 'Rating: ',
  style: TextStyle(fontSize: 14),
  iconSize: 20,
  iconHeight: 1.0,
  strutStyle: StrutStyle(
    fontSize: 20,
    forceStrutHeight: true,
  ),
)
```

The same parameters are available on `IconTextLabel`, `IconRichTextBuilder.buildRichText()`, and `toTextSpan()`.

### Font features and icon fonts

Most `fontFeatures` (ligatures, kerning, contextual alternates) have **no effect** on icon fonts because they render glyphs by Unicode code point rather than typographic rules. Pass `fontFeatures` only when using a custom or variable font that explicitly supports OpenType features on its icon characters.

```dart
// Only useful for custom fonts that support OpenType features
Icons.star.toText(
  fontFeatures: [FontFeature.enable('ss01')],
)
```

### Custom font icons

Render any icon font by code point. The font must be registered in your app's `pubspec.yaml`:

```dart
// 0xf004 is the FontAwesome heart icon code point
0xf004.toCustomTextSpan(
  fontFamily: 'FontAwesome',
  iconSize: 24,
  iconColor: Colors.red,
)
```

```dart
0xf004.toCustomText(
  fontFamily: 'FontAwesome',
  iconSize: 32,
  iconColor: Colors.red,
  textAlign: TextAlign.center,
)
```

### Override icon size and color

```dart
Icons.star.toText(
  iconSize: 32,
  iconColor: Colors.amber,
);
```

### Add accessibility label

```dart
CupertinoIcons.share.toText(
  semanticsLabel: 'Share icon',
);
```

### Use IconTextLabel

```dart
IconTextLabel(
  icon: Icons.send,
  prefix: 'Send ',
  postfix: ' Now',
  iconSize: 20,
  textStyle: TextStyle(fontSize: 16),
)
```

### Control icon position

```dart
IconTextLabel(
  icon: Icons.arrow_forward,
  prefix: 'Continue',
  iconPosition: IconPosition.end,
  iconColor: Colors.blue,
  textStyle: TextStyle(fontSize: 18),
)
```

---

## Preview

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/screenshots/300X650-01.png" alt="Example" width="300"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/screenshots/300X650-02.png" alt="Example" width="300"/>

---

## Roadmap

**Completed**

- [x] `IconData` to `TextSpan` and `Text` widget conversion
- [x] Prefix and postfix text support
- [x] Custom font sizes and colors via `iconSize` and `iconColor`
- [x] Accessibility support with `semanticsLabel`
- [x] Layout controls: `TextAlign`, `TextDirection`, `maxLines`, `TextOverflow`, `strutStyle`, `textHeightBehavior`, `textScaler`, `softWrap`
- [x] Vertical centering: `iconHeight` and `strutStyle` to fix icon/text alignment across mixed font sizes
- [x] `iconTextBaseline` for precise baseline alignment on the icon span
- [x] `fontFeatures` support with icon font behavior documentation
- [x] `IconPosition` enum for icon placement control
- [x] `IconTextLabel` declarative widget
- [x] Inline rich content utilities (`IconRichTextBuilder`)
- [x] Custom icon font support via `CustomCodePointExtension` on `int`
- [x] `toWidgetSpan()` with `PlaceholderAlignment` and `baseline` for inline widget embedding
- [x] Dedicated interactive playground in the `example/` app

**Planned**

- [ ] Theme-aware icon styling: automatically inherit color and size from `ThemeData`
- [ ] Gradient and stroke effects for icon text characters
- [ ] Multi-icon span builder: compose several icons and text segments in a single fluent call
- [ ] Animated icon text: fade, scale, and pulse transitions for icon characters
- [ ] Web-based interactive playground hosted alongside the package documentation

---

## Example

Clone or open the `example/` folder and run:

```bash
flutter run
```

The example app includes a tabbed playground covering all features: basic icon text, rich text builder, custom font icons, and the `IconTextLabel` widget.

---

## Check Out My Other Packages

Explore more Flutter packages by [Katayath Sai Kiran](https://pub.dev/publishers/ksaikiran.tech/packages) to add unique UI effects and functionality to your apps.

---

## Maintainer

Developed by [Katayath Sai Kiran](https://github.com/Katayath-Sai-Kiran).
Contributions and suggestions are always welcome.
