import 'package:flutter/cupertino.dart';

/// Extension on IconData to convert it into styled text widgets.
extension IconToTextExtension on IconData {
  /// Converts the IconData's codePoint to a String representation of the icon.
  ///
  /// This returns the Unicode character corresponding to the icon's codePoint,
  /// which can be used in `Text` or `TextSpan` widgets to render the icon as text.
  String iconToString() {
    return String.fromCharCode(codePoint);
  }

  /// Returns a TextSpan combining optional prefix, icon, and postfix.
  ///
  /// - [style]: Optional base text style for prefix and postfix.
  /// - [prefix]: Optional text before the icon.
  /// - [postfix]: Optional text after the icon.
  /// - [iconSize]: Optional override for font size of the icon only.
  /// - [iconColor]: Optional override for font color of the icon only.
  /// - [iconSemanticsLabel]: Optional semantics label for accessibility readers.
  TextSpan toTextSpan({
    TextStyle? style,
    String? prefix,
    String? postfix,
    double? iconSize,
    Color? iconColor,
    String? iconSemanticsLabel,
  }) {
    final List<InlineSpan> children = [];

    // Add prefix if provided
    if (prefix != null && prefix.isNotEmpty) {
      children.add(TextSpan(text: prefix, style: style));
    }

    // Add the icon character with correct font settings and optional size/color
    children.add(
      TextSpan(
        semanticsLabel: iconSemanticsLabel,
        text: String.fromCharCode(codePoint),
        style: (style ?? const TextStyle()).copyWith(
          fontSize: iconSize,
          fontFamily: fontFamily,
          color: iconColor,

          package: fontPackage,
        ),
      ),
    );

    // Add postfix if provided
    if (postfix != null && postfix.isNotEmpty) {
      children.add(TextSpan(text: postfix, style: style));
    }

    return TextSpan(children: children);
  }

  /// Returns a Text widget combining optional prefix, icon, and postfix.
  ///
  /// Uses Text.rich with internal TextSpan from [toTextSpan].
  /// Supports additional controls like [maxLines], [textOverflow], and [textDirection].
  Text toText({
    TextStyle? style,
    Key? key,
    TextAlign? textAlign,
    String? prefix,
    String? postfix,
    double? iconSize,
    Color? iconColor,
    TextDirection? textDirection,
    String? semanticsLabel,
    int? maxLines,
    TextOverflow? textOverflow,
  }) {
    return Text.rich(
      toTextSpan(
        style: style,
        prefix: prefix,
        postfix: postfix,
        iconSize: iconSize,
        iconColor: iconColor,
        iconSemanticsLabel: semanticsLabel,
      ),
      key: key,
      textAlign: textAlign,
      semanticsLabel: semanticsLabel,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
