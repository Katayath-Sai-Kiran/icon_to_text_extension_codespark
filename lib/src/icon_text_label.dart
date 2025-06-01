import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// Import the extension that converts IconData to rich Text/TextSpan
import 'package:icon_to_text_extension_codespark/icon_to_text_extension_codespark.dart';

/// A stateless widget that renders an icon as part of a rich text label,
/// with optional prefix, postfix, styling, accessibility, and tap handling.
class IconTextLabel extends StatelessWidget {
  /// The [IconData] to render as a Unicode character in text.
  final IconData icon;

  /// Optional text displayed before the icon.
  final String? prefix;

  /// Optional text displayed after the icon.
  final String? postfix;

  /// Overrides the font size of the icon only.
  final double? iconSize;

  /// Overrides the color of the icon only.
  final Color? iconColor;

  /// Base text style used for prefix, postfix, and fallback for icon.
  final TextStyle? textStyle;

  /// Optional style override specifically for the prefix text.
  final TextStyle? prefixStyle;

  /// Optional style override specifically for the postfix text.
  final TextStyle? postfixStyle;

  /// Optional style override specifically for the icon.
  final TextStyle? iconStyle;

  /// Controls where the icon is placed: at the start, middle, or end.
  final IconPosition iconPosition;

  /// Optional callback for handling tap interactions on the text.
  final GestureTapCallback? onTap;

  /// Aligns the text within its container.
  final TextAlign? textAlign;

  /// Specifies the directionality of the text (LTR or RTL).
  final TextDirection? textDirection;

  /// Limits the number of visible lines for the text.
  final int? maxLines;

  /// Controls how text overflow is handled (e.g., ellipsis).
  final TextOverflow? textOverflow;

  /// Accessibility label for screen readers.
  final String? semanticsLabel;

  /// Optional key to assign specifically to the [Text] widget.
  final Key? textKey;

  /// Creates an [IconTextLabel] widget.
  ///
  /// Wraps the icon with optional prefix/postfix text using the
  /// [IconToTextExtension] and renders it as a [Text.rich] widget.
  const IconTextLabel({
    super.key,
    required this.icon,
    this.prefix,
    this.postfix,
    this.iconSize,
    this.iconColor,
    this.textStyle,
    this.prefixStyle,
    this.postfixStyle,
    this.iconStyle,
    this.iconPosition = IconPosition.middle,
    this.onTap,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.textOverflow,
    this.semanticsLabel,
    this.textKey,
  });

  @override
  Widget build(BuildContext context) {
    return icon.toText(
      key: textKey,
      style: textStyle,
      prefix: prefix,
      postfix: postfix,
      iconSize: iconSize,
      iconColor: iconColor,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      textOverflow: textOverflow,
      semanticsLabel: semanticsLabel,
      prefixStyle: prefixStyle,
      postfixStyle: postfixStyle,
      iconStyle: iconStyle,
      iconPosition: iconPosition,
      onTap: onTap,
    );
  }
}
