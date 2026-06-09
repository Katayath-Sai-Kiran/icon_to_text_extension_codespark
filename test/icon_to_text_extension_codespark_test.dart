import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_to_text_extension_codespark/icon_to_text_extension_codespark.dart';

void main() {
  group('IconToTextExtension.iconToString', () {
    test('returns the Unicode character for the icon code point', () {
      const icon = CupertinoIcons.share;
      expect(icon.iconToString(), String.fromCharCode(icon.codePoint));
    });
  });

  group('IconToTextExtension.toTextSpan', () {
    const icon = CupertinoIcons.share;

    // toTextSpan() returns TextSpan(children: [...]) — the icon glyph is
    // in children[0], not in span.text directly.
    TextSpan iconSpanFrom(TextSpan span) => span.children!.first as TextSpan;

    test('icon span contains correct Unicode character', () {
      final span = icon.toTextSpan();
      expect(iconSpanFrom(span).text, String.fromCharCode(icon.codePoint));
    });

    test('icon span uses correct font family', () {
      final span = icon.toTextSpan();
      expect(iconSpanFrom(span).style?.fontFamily, contains('CupertinoIcons'));
    });

    test('iconSize is applied to the icon span', () {
      final span = icon.toTextSpan(iconSize: 32);
      expect(iconSpanFrom(span).style?.fontSize, 32);
    });

    test('iconColor is applied to the icon span', () {
      final span = icon.toTextSpan(iconColor: Colors.red);
      expect(iconSpanFrom(span).style?.color, Colors.red);
    });

    test('iconHeight is applied to the icon span', () {
      final span = icon.toTextSpan(iconHeight: 1.0);
      expect(iconSpanFrom(span).style?.height, 1.0);
    });

    test('prefix and postfix produce three children in middle position', () {
      final span = icon.toTextSpan(prefix: 'Before ', postfix: ' After');
      expect(span.children!.length, 3);
      expect((span.children![0] as TextSpan).text, 'Before ');
      expect((span.children![1] as TextSpan).text, String.fromCharCode(icon.codePoint));
      expect((span.children![2] as TextSpan).text, ' After');
    });

    test('IconPosition.start places icon before prefix', () {
      final span = icon.toTextSpan(prefix: 'text', iconPosition: IconPosition.start);
      expect((span.children!.first as TextSpan).text, String.fromCharCode(icon.codePoint));
    });

    test('IconPosition.end places icon after postfix', () {
      final span = icon.toTextSpan(postfix: 'text', iconPosition: IconPosition.end);
      expect((span.children!.last as TextSpan).text, String.fromCharCode(icon.codePoint));
    });

    test('iconSemanticsLabel is applied to the icon span', () {
      final span = icon.toTextSpan(iconSemanticsLabel: 'Share icon');
      expect(iconSpanFrom(span).semanticsLabel, 'Share icon');
    });

    test('iconStyle overrides font family and size', () {
      const customStyle = TextStyle(fontFamily: 'Roboto', fontSize: 40);
      final span = icon.toTextSpan(iconStyle: customStyle);
      expect(iconSpanFrom(span).style?.fontFamily, 'Roboto');
      expect(iconSpanFrom(span).style?.fontSize, 40);
    });

    test('fontFeatures are applied to the icon span', () {
      final features = [const FontFeature.enable('liga')];
      final span = icon.toTextSpan(fontFeatures: features);
      expect(iconSpanFrom(span).style?.fontFeatures, features);
    });
  });

  group('IconToTextExtension.toText', () {
    const icon = Icons.star;

    // toText() wraps toTextSpan() in Text.rich — access spans via textSpan.
    TextSpan iconSpanFrom(Text text) {
      final outer = text.textSpan as TextSpan;
      return outer.children!.first as TextSpan;
    }

    test('returns a Text widget', () {
      expect(icon.toText(), isA<Text>());
    });

    test('inner span contains correct Unicode character', () {
      expect(iconSpanFrom(icon.toText()).text, String.fromCharCode(icon.codePoint));
    });

    test('inner span uses correct font family', () {
      expect(iconSpanFrom(icon.toText()).style?.fontFamily, contains('MaterialIcons'));
    });

    test('iconSize is forwarded to inner span', () {
      expect(iconSpanFrom(icon.toText(iconSize: 28)).style?.fontSize, 28);
    });

    test('iconHeight is forwarded to inner span', () {
      expect(iconSpanFrom(icon.toText(iconHeight: 1.0)).style?.height, 1.0);
    });

    test('textAlign is forwarded', () {
      expect(icon.toText(textAlign: TextAlign.center).textAlign, TextAlign.center);
    });

    test('maxLines is forwarded', () {
      expect(icon.toText(maxLines: 2).maxLines, 2);
    });

    test('strutStyle is forwarded', () {
      final strut = StrutStyle(fontSize: 24, forceStrutHeight: true);
      expect(icon.toText(strutStyle: strut).strutStyle, strut);
    });

    test('textScaler is forwarded', () {
      expect(icon.toText(textScaler: TextScaler.noScaling).textScaler, TextScaler.noScaling);
    });

    test('softWrap defaults to true', () {
      expect(icon.toText().softWrap, isTrue);
    });
  });

  group('IconToTextExtension.toWidgetSpan', () {
    const icon = Icons.inbox;

    test('returns a WidgetSpan', () {
      expect(icon.toWidgetSpan(), isA<WidgetSpan>());
    });

    test('default alignment is PlaceholderAlignment.middle', () {
      expect(icon.toWidgetSpan().alignment, PlaceholderAlignment.middle);
    });

    test('custom alignment is applied', () {
      final span = icon.toWidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
      );
      expect(span.alignment, PlaceholderAlignment.baseline);
    });
  });

  group('IconRichTextBuilder', () {
    test('buildSpan processes String parts', () {
      final span = IconRichTextBuilder.buildSpan(['Hello ', 'World']);
      expect(span.children!.length, 2);
      expect((span.children![0] as TextSpan).text, 'Hello ');
    });

    test('buildSpan processes IconData parts', () {
      final span = IconRichTextBuilder.buildSpan([Icons.star]);
      final outer = span.children!.first as TextSpan;
      final iconSpan = outer.children!.first as TextSpan;
      expect(iconSpan.text, String.fromCharCode(Icons.star.codePoint));
    });

    test('buildSpan passes through InlineSpan parts unchanged', () {
      const custom = TextSpan(text: 'custom', style: TextStyle(fontSize: 42));
      final span = IconRichTextBuilder.buildSpan([custom]);
      expect((span.children!.first as TextSpan).style?.fontSize, 42);
    });

    test('buildSpan applies defaultIconHeight to IconData parts', () {
      final span = IconRichTextBuilder.buildSpan(
        [Icons.star],
        defaultIconHeight: 1.0,
      );
      final outer = span.children!.first as TextSpan;
      final iconSpan = outer.children!.first as TextSpan;
      expect(iconSpan.style?.height, 1.0);
    });

    test('buildRichText returns a Text widget', () {
      expect(IconRichTextBuilder.buildRichText(['Hello']), isA<Text>());
    });

    test('buildSpan throws ArgumentError for unsupported types', () {
      expect(() => IconRichTextBuilder.buildSpan([42]), throwsArgumentError);
    });
  });

  group('CustomCodePointExtension', () {
    const codePoint = 0xE000;
    const fontFamily = 'TestFont';

    test('toCustomTextSpan uses correct font family', () {
      final span = codePoint.toCustomTextSpan(fontFamily: fontFamily);
      expect(span.style?.fontFamily, fontFamily);
    });

    test('toCustomTextSpan renders the correct character', () {
      final span = codePoint.toCustomTextSpan(fontFamily: fontFamily);
      expect(span.text, String.fromCharCode(codePoint));
    });

    test('toCustomTextSpan applies iconSize and iconColor', () {
      final span = codePoint.toCustomTextSpan(
        fontFamily: fontFamily,
        iconSize: 28,
        iconColor: Colors.blue,
      );
      expect(span.style?.fontSize, 28);
      expect(span.style?.color, Colors.blue);
    });

    test('toCustomText returns a Text widget', () {
      expect(codePoint.toCustomText(fontFamily: fontFamily), isA<Text>());
    });
  });
}
