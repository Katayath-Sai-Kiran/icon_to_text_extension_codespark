import 'package:flutter/cupertino.dart';

extension IconToTextExtension on IconData {
  /// Converts the IconData's codePoint to a String representation of the icon.
  ///
  /// This returns the Unicode character corresponding to the icon's codePoint,
  /// which can be used in `Text` or `TextSpan` widgets to render the icon as text.
  String iconToString() {
    return String.fromCharCode(codePoint);
  }

  /// Returns a TextSpan combining optional prefix, icon, and postfix.
  /// The icon uses this IconData's fontFamily and fontPackage.
  TextSpan toTextSpan({TextStyle? style, String? prefix, String? postfix}) {
    final List<InlineSpan> children = [];

    if (prefix != null && prefix.isNotEmpty) {
      children.add(TextSpan(text: prefix, style: style));
    }

    children.add(
      TextSpan(
        text: String.fromCharCode(codePoint),
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: fontFamily,
          package: fontPackage,
        ),
      ),
    );

    if (postfix != null && postfix.isNotEmpty) {
      children.add(TextSpan(text: postfix, style: style));
    }

    return TextSpan(children: children);
  }

  /// Returns a Text widget combining optional prefix, icon, and postfix.
  /// Uses Text.rich internally for inline styling.
  Text toText({
    TextStyle? style,
    Key? key,
    TextAlign? textAlign,
    String? prefix,
    String? postfix,
  }) {
    return Text.rich(
      toTextSpan(style: style, prefix: prefix, postfix: postfix),
      key: key,
      textAlign: textAlign,
    );
  }
}
