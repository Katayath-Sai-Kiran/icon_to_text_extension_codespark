import 'package:icon_to_text_extension_codespark/src/icon_text_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CupertinoIconTextExtension', () {
    const icon = CupertinoIcons.share;

    test('toTextSpan() returns correct Unicode character', () {
      final span = icon.toTextSpan();

      expect(span.text, String.fromCharCode(icon.codePoint));
      expect(span.style?.fontFamily?.contains('CupertinoIcons'), isTrue);
    });

    test('toText() returns Text widget with correct content', () {
      final textWidget = icon.toText();

      expect(textWidget.data, String.fromCharCode(icon.codePoint));
      expect(textWidget.style?.fontFamily?.contains('CupertinoIcons'), isTrue);
      expect(textWidget.data, String.fromCharCode(icon.codePoint));
      expect(textWidget.style?.fontFamily?.contains('CupertinoIcons'), isTrue);
    });

    test('toTextSpan() returns correct Unicode character', () {
      final span = icon.toTextSpan();

      expect(span.text, String.fromCharCode(icon.codePoint));
      expect(span.style?.fontFamily?.contains('CupertinoIcons'), isTrue);
    });

    test('toText() applies custom style while preserving font', () {
      final style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
      final textWidget = icon.toText(style: style);

      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.data, String.fromCharCode(icon.codePoint));
      expect(textWidget.style?.fontFamily?.contains('CupertinoIcons'), isTrue);
    });
  });
}
