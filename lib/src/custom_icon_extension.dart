import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// Extension on [int] to render a raw Unicode code point as styled text
/// using any icon font family.
///
/// This is the entry point for custom font icon support. Use it when you have
/// a code point integer from a third-party or locally bundled icon font
/// (such as FontAwesome, Ionicons, or Material Symbols) and want to display
/// it inline as a [TextSpan] or [Text] widget.
///
/// The font must be registered in your app's pubspec.yaml under `flutter.fonts`
/// before the rendered glyph will appear correctly.
///
/// Example — FontAwesome heart icon with code point `0xf004`:
/// ```dart
/// 0xf004.toCustomTextSpan(
///   fontFamily: 'FontAwesome',
///   iconSize: 24,
///   iconColor: Colors.red,
/// )
/// ```
///
/// Example — inline in a RichText:
/// ```dart
/// RichText(
///   text: TextSpan(
///     children: [
///       TextSpan(text: 'Liked '),
///       0xf004.toCustomTextSpan(fontFamily: 'FontAwesome', iconColor: Colors.red),
///       TextSpan(text: ' by you'),
///     ],
///   ),
/// )
/// ```
extension CustomCodePointExtension on int {
  /// Converts this Unicode code point to a [TextSpan] rendered in [fontFamily].
  ///
  /// The resulting span displays the glyph at this code point using the
  /// specified [fontFamily]. The font must be declared in your app's assets
  /// for the glyph to render correctly.
  ///
  /// Parameters:
  /// - [fontFamily]: The font family name of the icon font. Required.
  /// - [fontPackage]: The package that provides the font when bundled inside
  ///   a Flutter library package rather than the host app. Omit for host-app fonts.
  /// - [style]: Base [TextStyle] applied to the character. [iconSize] and
  ///   [iconColor] override the corresponding fields in this style.
  /// - [iconSize]: Overrides the font size for this icon character only.
  /// - [iconColor]: Overrides the foreground color for this icon character only.
  /// - [semanticsLabel]: Accessibility description read by screen readers.
  /// - [onTap]: Optional tap callback. Attaches a [TapGestureRecognizer] when
  ///   provided; no recognizer is created when `null`.
  TextSpan toCustomTextSpan({
    required String fontFamily,
    String? fontPackage,
    TextStyle? style,
    double? iconSize,
    Color? iconColor,
    String? semanticsLabel,
    GestureTapCallback? onTap,
  }) {
    final resolvedStyle = (style ?? const TextStyle()).copyWith(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: iconSize,
      color: iconColor,
    );
    return TextSpan(
      text: String.fromCharCode(this),
      style: resolvedStyle,
      semanticsLabel: semanticsLabel,
      recognizer:
          onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
    );
  }

  /// Converts this Unicode code point to a [Text] widget rendered in [fontFamily].
  ///
  /// Wraps [toCustomTextSpan] in a [Text.rich] widget. Use this when you need
  /// a standalone widget rather than an inline span.
  ///
  /// Parameters:
  /// - [fontFamily]: The font family name of the icon font. Required.
  /// - [fontPackage]: The package that provides the font, if any.
  /// - [style]: Base [TextStyle] for the character.
  /// - [iconSize]: Overrides the font size for the icon character.
  /// - [iconColor]: Overrides the color for the icon character.
  /// - [semanticsLabel]: Accessibility label read by screen readers.
  /// - [onTap]: Optional tap callback.
  /// - [textAlign]: Horizontal alignment of the text within its container.
  /// - [textDirection]: Directionality of the text (LTR or RTL).
  /// - [maxLines]: Maximum number of lines before truncation applies.
  /// - [textOverflow]: Strategy for text that exceeds the available space.
  /// - [key]: Optional widget key for the returned [Text].
  Text toCustomText({
    required String fontFamily,
    String? fontPackage,
    TextStyle? style,
    double? iconSize,
    Color? iconColor,
    String? semanticsLabel,
    GestureTapCallback? onTap,
    TextAlign? textAlign,
    TextDirection? textDirection,
    int? maxLines,
    TextOverflow? textOverflow,
    Key? key,
  }) {
    return Text.rich(
      toCustomTextSpan(
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        style: style,
        iconSize: iconSize,
        iconColor: iconColor,
        semanticsLabel: semanticsLabel,
        onTap: onTap,
      ),
      key: key,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: textOverflow,
      semanticsLabel: semanticsLabel,
    );
  }
}
