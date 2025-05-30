

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/banners/banner.png" alt="Banner"/>

# 🔤 icondata\_to\_text\_extension

[![Pub Version](https://img.shields.io/pub/v/icon_to_text_extension_codespark)](https://pub.dev/packages/icon_to_text_extension_codespark)
[![GitHub](https://img.shields.io/badge/GitHub-Katayath--Sai--Kiran%2Ficon_to_text_extension_codespark-blue?logo=github)](https://github.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark)
[![License](https://img.shields.io/pub/l/icon_to_text_extension_codespark)](https://pub.dev/packages/icon_to_text_extension_codespark/license)

Convert any Flutter IconData (Material or Cupertino) into inline `Text` or `TextSpan` widgets with correct font rendering.
Ideal for rich text, custom layouts, or displaying icons as text in Flutter apps.

> ✨ Fully **null-safe**, simple, and customizable.

## 🚀 Features

- ✅ Supports both Material and Cupertino icons  
- ✅ Converts IconData to `TextSpan` or `Text` widgets  
- ✅ Preserves original icon font family and package  
- ✅ Accepts optional `TextStyle` with easy overrides  
- ✅ Prefix and postfix text support — combine icon and surrounding text in one widget, reducing extra `TextSpan`s or `Text` widgets  
- ✅ Perfect for inline icons in rich text or complex UI  
- ✅ Minimal, zero-dependency extension  


## 🔧 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  icondata_to_text_extension: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🧪 Usage

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

### Use prefix and postfix to reduce extra spans/widgets

```dart
final spanWithText = CupertinoIcons.share.toTextSpan(
  prefix: 'Tap ',
  postfix: ' to share',
  style: TextStyle(fontSize: 24, color: Colors.black),
);
```

```dart
final textWithIcon = Icons.share.toText(
  prefix: 'Click ',
  postfix: ' here',
  style: TextStyle(fontSize: 28, color: Colors.purple),
);
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

## 📷 Preview

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/screenshots/300X650-01.png" alt="Example" width="300"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark/main/assets/screenshots/300X650-02.png" alt="Example" width="300"/>

## 💡 Roadmap

* [x] IconData to TextSpan conversion
* [x] IconData to Text widget conversion
* [x] Prefix and postfix support in text conversion
* [ ] Support for custom font sizes & colors via style
* [ ] Additional utility methods for widget building
* [ ] Example app with live preview
* [ ] Add support for other icon fonts (custom font icons)

## 📁 Example

Clone or open the `example/` folder and run:

```bash
flutter run
```

## 🎉 Check Out My Other Packages!

Explore more Flutter packages by [Katayath Sai Kiran](https://github.com/Katayath-Sai-Kiran) to add unique UI effects and functionality to your apps.

## 👨‍💻 Maintainer

Developed with 💙 by [Katayath Sai Kiran](https://github.com/Katayath-Sai-Kiran)
📬 Contributions and suggestions are always welcome!


