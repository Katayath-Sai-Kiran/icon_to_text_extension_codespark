import 'package:flutter/widgets.dart';

import 'icon_text_extension.dart';

/// Utility class for composing inline rich text that mixes [IconData],
/// plain [String] values, and custom [InlineSpan] instances.
///
/// [IconRichTextBuilder] removes the need to manually assemble a list of
/// [TextSpan] children when your content alternates between text and icons.
/// Pass a flat list of parts and receive a fully composed [TextSpan] tree or
/// a ready-to-use [Text.rich] widget.
///
/// Supported part types in [buildSpan] and [buildRichText]:
/// - [String] — rendered as a plain [TextSpan] with [defaultStyle].
/// - [IconData] — converted via [IconToTextExtension.toTextSpan] with optional
///   [defaultIconSize], [defaultIconColor], and [defaultIconHeight] overrides.
/// - [InlineSpan] — inserted as-is, giving you full control over individual spans.
///
/// Any other type throws an [ArgumentError].
///
/// ---
///
/// ### Vertical centering
///
/// When icons and text have different sizes, use **[strutStyle]** on
/// [buildRichText] to force a consistent line box:
/// ```dart
/// IconRichTextBuilder.buildRichText(
///   ['Tap ', CupertinoIcons.share, ' to share'],
///   defaultStyle: TextStyle(fontSize: 14),
///   defaultIconSize: 20,
///   defaultIconHeight: 1.0,
///   strutStyle: StrutStyle(fontSize: 20, forceStrutHeight: true),
/// )
/// ```
///
/// ### Font features note
///
/// [defaultFontFeatures] applies to all [IconData] parts. Icon fonts render
/// glyphs by code point and typically ignore OpenType features; include only
/// when your custom font explicitly supports them.
///
/// ---
///
/// Example:
/// ```dart
/// IconRichTextBuilder.buildRichText(
///   [
///     'Tap ',
///     CupertinoIcons.share,
///     ' or ',
///     Icons.send,
///     ' to continue',
///   ],
///   defaultStyle: TextStyle(fontSize: 18),
///   defaultIconColor: Colors.blue,
/// )
/// ```
///
/// Example — with a custom span:
/// ```dart
/// IconRichTextBuilder.buildSpan(
///   [
///     'You have ',
///     TextSpan(
///       text: '3 messages',
///       style: TextStyle(fontWeight: FontWeight.bold),
///     ),
///     ' — check your ',
///     Icons.inbox,
///   ],
///   defaultStyle: TextStyle(fontSize: 16),
/// )
/// ```
class IconRichTextBuilder {
  IconRichTextBuilder._();

  /// Builds a [TextSpan] tree from a mixed list of content parts.
  ///
  /// Each element in [parts] is processed in order:
  /// - [String] parts become plain [TextSpan] nodes styled with [defaultStyle].
  /// - [IconData] parts are converted via [IconToTextExtension.toTextSpan],
  ///   inheriting [defaultStyle], [defaultIconSize], [defaultIconColor], and
  ///   [defaultIconHeight].
  /// - [InlineSpan] parts are inserted unchanged.
  ///
  /// Throws [ArgumentError] if any element is not one of the three supported types.
  ///
  /// Parameters:
  /// - [parts]: Ordered content list. Each element must be a [String],
  ///   [IconData], or [InlineSpan].
  /// - [defaultStyle]: [TextStyle] applied to [String] parts and used as the
  ///   base style when converting [IconData] parts.
  /// - [defaultIconSize]: Overrides the font size for all [IconData] parts.
  /// - [defaultIconColor]: Overrides the color for all [IconData] parts.
  /// - [defaultIconHeight]: Line-height multiplier applied to all [IconData]
  ///   parts. Use `1.0` to remove extra glyph leading and reduce vertical
  ///   misalignment with adjacent text.
  /// - [defaultFontFeatures]: OpenType font features applied to all [IconData]
  ///   parts. Most icon fonts ignore these; see class documentation.
  static TextSpan buildSpan(
    List<Object> parts, {
    TextStyle? defaultStyle,
    double? defaultIconSize,
    Color? defaultIconColor,
    double? defaultIconHeight,
    List<FontFeature>? defaultFontFeatures,
  }) {
    final spans = <InlineSpan>[];
    for (final part in parts) {
      if (part is String) {
        spans.add(TextSpan(text: part, style: defaultStyle));
      } else if (part is IconData) {
        spans.add(
          part.toTextSpan(
            style: defaultStyle,
            iconSize: defaultIconSize,
            iconColor: defaultIconColor,
            iconHeight: defaultIconHeight,
            fontFeatures: defaultFontFeatures,
          ),
        );
      } else if (part is InlineSpan) {
        spans.add(part);
      } else {
        throw ArgumentError(
          'Each part must be a String, IconData, or InlineSpan. '
          'Got: ${part.runtimeType}',
        );
      }
    }
    return TextSpan(children: spans);
  }

  /// Builds a [Text.rich] widget from a mixed list of content parts.
  ///
  /// A convenience wrapper around [buildSpan] that returns a fully
  /// composed [Text.rich] widget with layout controls.
  ///
  /// Parameters:
  /// - [parts]: Ordered content list of [String], [IconData], or [InlineSpan].
  /// - [defaultStyle]: [TextStyle] applied to string and icon parts.
  /// - [defaultIconSize]: Overrides font size for all [IconData] parts.
  /// - [defaultIconColor]: Overrides color for all [IconData] parts.
  /// - [defaultIconHeight]: Line-height multiplier for all [IconData] parts.
  ///   `1.0` removes extra leading and is the first thing to try when icons
  ///   appear vertically off-center. Combine with [strutStyle] for the most
  ///   reliable centering.
  /// - [defaultFontFeatures]: OpenType font features for all [IconData] parts.
  /// - [textAlign]: Horizontal alignment of the composed text.
  /// - [textDirection]: Directionality (LTR or RTL).
  /// - [maxLines]: Maximum number of visible lines before truncation.
  /// - [overflow]: How to handle text that exceeds [maxLines].
  /// - [strutStyle]: Minimum line metrics for the widget. Use
  ///   `StrutStyle(forceStrutHeight: true)` to force a consistent line box
  ///   across all spans, which reliably centers icons of a different size.
  /// - [textHeightBehavior]: Controls how [TextStyle.height] is applied to
  ///   the first and last lines.
  /// - [textScaler]: Controls text scaling relative to system settings. Pass
  ///   [TextScaler.noScaling] to opt out of system font scaling.
  /// - [softWrap]: Whether text may wrap across lines. Defaults to `true`.
  /// - [key]: Optional widget key for the returned [Text].
  static Widget buildRichText(
    List<Object> parts, {
    TextStyle? defaultStyle,
    double? defaultIconSize,
    Color? defaultIconColor,
    double? defaultIconHeight,
    List<FontFeature>? defaultFontFeatures,
    TextAlign? textAlign,
    TextDirection? textDirection,
    int? maxLines,
    TextOverflow? overflow,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
    TextScaler? textScaler,
    bool softWrap = true,
    Key? key,
  }) {
    return Text.rich(
      buildSpan(
        parts,
        defaultStyle: defaultStyle,
        defaultIconSize: defaultIconSize,
        defaultIconColor: defaultIconColor,
        defaultIconHeight: defaultIconHeight,
        defaultFontFeatures: defaultFontFeatures,
      ),
      key: key,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler,
      softWrap: softWrap,
    );
  }
}
