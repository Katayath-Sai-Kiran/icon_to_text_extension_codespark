import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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
  /// - [prefixStyle]: Optional style for prefix text.
  /// - [postfixStyle]: Optional style for postfix text.
  /// - [iconStyle]: Optional complete style override for the icon.
  /// - [iconPosition]: Position of icon in the span (start, middle, end).
  /// - [onTap]: Optional tap callback for interactive text.
  TextSpan toTextSpan({
    TextStyle? style,
    String? prefix,
    String? postfix,
    double? iconSize,
    Color? iconColor,
    String? iconSemanticsLabel,
    TextStyle? prefixStyle,
    TextStyle? postfixStyle,
    TextStyle? iconStyle,
    IconPosition iconPosition = IconPosition.middle,
    GestureTapCallback? onTap,
  }) {
    final List<InlineSpan> children = [];

    final iconTextSpan = TextSpan(
      recognizer: TapGestureRecognizer()..onTap = onTap,
      semanticsLabel: iconSemanticsLabel,

      text: String.fromCharCode(codePoint),
      style:
          iconStyle ??
          (style ?? const TextStyle()).copyWith(
            fontSize: iconSize,
            fontFamily: fontFamily,
            color: iconColor,

            package: fontPackage,
          ),
    );

    final prefixSpan = (prefix != null && prefix.isNotEmpty)
        ? TextSpan(text: prefix, style: prefixStyle ?? style)
        : null;

    final postfixSpan = (postfix != null && postfix.isNotEmpty)
        ? TextSpan(text: postfix, style: postfixStyle ?? style)
        : null;

    // Icon position logic
    switch (iconPosition) {
      case IconPosition.start:
        children.add(iconTextSpan);
        if (prefixSpan != null) children.add(prefixSpan);
        if (postfixSpan != null) children.add(postfixSpan);
        break;
      case IconPosition.middle:
        if (prefixSpan != null) children.add(prefixSpan);
        children.add(iconTextSpan);
        if (postfixSpan != null) children.add(postfixSpan);
        break;
      case IconPosition.end:
        if (prefixSpan != null) children.add(prefixSpan);
        if (postfixSpan != null) children.add(postfixSpan);
        children.add(iconTextSpan);
        break;
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
    TextStyle? prefixStyle,
    TextStyle? postfixStyle,
    TextStyle? iconStyle,
    IconPosition iconPosition = IconPosition.middle,
    GestureTapCallback? onTap,
  }) {
    return Text.rich(
      toTextSpan(
        style: style,
        prefix: prefix,
        postfix: postfix,
        iconSize: iconSize,
        iconColor: iconColor,
        iconSemanticsLabel: semanticsLabel,
        prefixStyle: prefixStyle,
        postfixStyle: postfixStyle,
        iconStyle: iconStyle,
        iconPosition: iconPosition,
        onTap: onTap,
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

/// Enum to define icon position in text span.
enum IconPosition {
  /// Icon is placed at the start (before prefix).
  start,

  /// Icon is placed in the middle (between prefix and postfix).
  middle,

  /// Icon is placed at the end (after postfix).
  end,
}
