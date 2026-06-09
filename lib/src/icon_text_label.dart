import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:icon_to_text_extension_codespark/icon_to_text_extension_codespark.dart';

/// A stateless widget that renders an [IconData] as part of a rich text label,
/// with optional prefix, postfix, per-segment styling, full layout control,
/// accessibility support, and tap handling.
///
/// [IconTextLabel] is the declarative counterpart to calling
/// [IconToTextExtension.toText] directly. It accepts the same parameters as
/// named constructor arguments, which makes it more ergonomic inside widget
/// trees where you prefer widget composition over extension method calls.
///
/// ---
///
/// ### Vertical centering
///
/// When the icon size differs from the surrounding text size, the glyph may
/// appear misaligned. Use **[iconHeight]** and **[strutStyle]** together:
///
/// ```dart
/// IconTextLabel(
///   icon: Icons.star,
///   prefix: 'Rating: ',
///   textStyle: TextStyle(fontSize: 14),
///   iconSize: 22,
///   iconHeight: 1.0,         // removes extra glyph leading
///   strutStyle: StrutStyle(
///     fontSize: 22,
///     forceStrutHeight: true, // locks all spans to one line box
///   ),
/// )
/// ```
///
/// ### Font features note
///
/// Icon fonts render glyphs by Unicode code point rather than typographic
/// rules. Most [FontFeature] values have no effect on icon glyphs and can be
/// omitted. Pass [fontFeatures] only when using a custom or variable font that
/// explicitly supports OpenType features on its icon characters.
///
/// ---
///
/// Example — basic icon with surrounding text:
/// ```dart
/// IconTextLabel(
///   icon: Icons.send,
///   prefix: 'Send ',
///   postfix: ' Now',
///   iconSize: 20,
///   textStyle: TextStyle(fontSize: 16),
/// )
/// ```
///
/// Example — tappable label with accessibility:
/// ```dart
/// IconTextLabel(
///   icon: CupertinoIcons.share,
///   prefix: 'Tap ',
///   postfix: ' to share',
///   iconColor: Colors.blue,
///   semanticsLabel: 'Share button',
///   onTap: () => share(),
///   textStyle: TextStyle(fontSize: 18),
/// )
/// ```
class IconTextLabel extends StatelessWidget {
  /// The [IconData] to render as a Unicode glyph within the text.
  ///
  /// Supports any [IconData] source — Material, Cupertino, or custom fonts.
  final IconData icon;

  /// Optional text displayed before the icon (position depends on [iconPosition]).
  final String? prefix;

  /// Optional text displayed after the icon (position depends on [iconPosition]).
  final String? postfix;

  /// Overrides the font size for the icon glyph only.
  ///
  /// Has no effect when [iconStyle] is provided.
  final double? iconSize;

  /// Overrides the foreground color for the icon glyph only.
  ///
  /// Has no effect when [iconStyle] is provided.
  final Color? iconColor;

  /// Line-height multiplier for the icon glyph's [TextStyle.height].
  ///
  /// This is the most direct fix when the icon appears too high or too low
  /// relative to adjacent text. `1.0` removes all extra leading above and
  /// below the glyph. Experiment with values between `0.9` and `1.3` to
  /// match your surrounding text, and combine with [strutStyle] for the
  /// most reliable result. Has no effect when [iconStyle] is provided.
  final double? iconHeight;

  /// [TextBaseline] used for the icon glyph span.
  ///
  /// Relevant when `textBaseline` affects how spans align within a row.
  /// Has no effect when [iconStyle] is provided.
  final TextBaseline? iconTextBaseline;

  /// OpenType font features for the icon glyph.
  ///
  /// Icon fonts render glyphs by code point and typically ignore font
  /// features. Pass values here only when using a custom or variable font
  /// that explicitly supports OpenType features on its icon characters.
  /// Has no effect when [iconStyle] is provided.
  final List<FontFeature>? fontFeatures;

  /// Base [TextStyle] applied to prefix and postfix text, and used as the
  /// style fallback for the icon glyph.
  final TextStyle? textStyle;

  /// Style override for the prefix text segment only.
  ///
  /// Falls back to [textStyle] when `null`.
  final TextStyle? prefixStyle;

  /// Style override for the postfix text segment only.
  ///
  /// Falls back to [textStyle] when `null`.
  final TextStyle? postfixStyle;

  /// Full [TextStyle] override for the icon glyph.
  ///
  /// When provided, [iconSize], [iconColor], [iconHeight], [iconTextBaseline],
  /// and [fontFeatures] are all ignored. The correct [fontFamily] and
  /// [fontPackage] are still applied automatically from [icon].
  final TextStyle? iconStyle;

  /// Controls the order of the icon glyph relative to [prefix] and [postfix].
  ///
  /// - [IconPosition.start]: icon — prefix — postfix
  /// - [IconPosition.middle]: prefix — icon — postfix (default)
  /// - [IconPosition.end]: prefix — postfix — icon
  final IconPosition iconPosition;

  /// Optional tap callback. When set, attaches a [TapGestureRecognizer] to
  /// the icon span.
  final GestureTapCallback? onTap;

  /// Horizontal alignment of the composed text within its container.
  final TextAlign? textAlign;

  /// Directionality of the text (LTR or RTL).
  final TextDirection? textDirection;

  /// Maximum number of lines to display before truncation.
  final int? maxLines;

  /// How to handle text that exceeds the available space or [maxLines].
  final TextOverflow? textOverflow;

  /// Defines minimum line metrics for the widget.
  ///
  /// Use `StrutStyle(forceStrutHeight: true)` to force every span —
  /// including the icon — to share the same line box height. This is the
  /// recommended approach for vertically centering an icon alongside text
  /// of a different size:
  /// ```dart
  /// strutStyle: StrutStyle(fontSize: 22, forceStrutHeight: true)
  /// ```
  final StrutStyle? strutStyle;

  /// Controls how [TextStyle.height] is applied to the first and last lines.
  ///
  /// Use in combination with [strutStyle] for precise vertical spacing
  /// at the boundaries of the text widget.
  final TextHeightBehavior? textHeightBehavior;

  /// Controls how the text responds to the system font size setting.
  ///
  /// Defaults to the ambient [TextScaler] from [MediaQuery]. Pass
  /// [TextScaler.noScaling] to opt out of system font scaling for this widget.
  final TextScaler? textScaler;

  /// Whether text may wrap across lines. Defaults to `true`.
  final bool softWrap;

  /// Accessibility label for the entire widget, read by screen readers in
  /// place of the composed glyph and text characters.
  final String? semanticsLabel;

  /// Optional key assigned to the internal [Text] widget rather than to the
  /// [IconTextLabel] widget itself.
  final Key? textKey;

  /// Creates an [IconTextLabel] widget.
  ///
  /// Only [icon] is required. All other parameters are optional and mirror
  /// those accepted by [IconToTextExtension.toText].
  const IconTextLabel({
    super.key,
    required this.icon,
    this.prefix,
    this.postfix,
    this.iconSize,
    this.iconColor,
    this.iconHeight,
    this.iconTextBaseline,
    this.fontFeatures,
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
    this.strutStyle,
    this.textHeightBehavior,
    this.textScaler,
    this.softWrap = true,
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
      iconHeight: iconHeight,
      iconTextBaseline: iconTextBaseline,
      fontFeatures: fontFeatures,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      textOverflow: textOverflow,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
      prefixStyle: prefixStyle,
      postfixStyle: postfixStyle,
      iconStyle: iconStyle,
      iconPosition: iconPosition,
      onTap: onTap,
    );
  }
}
