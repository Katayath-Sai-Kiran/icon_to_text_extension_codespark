import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// Extension on [IconData] that converts icon glyphs into [Text] and
/// [TextSpan] widgets for inline use in rich text layouts.
///
/// All Flutter icon fonts (Material, Cupertino, and custom fonts) store
/// icons as Unicode characters. This extension reads [IconData.codePoint],
/// [IconData.fontFamily], and [IconData.fontPackage] to produce correctly
/// rendered text widgets without any additional assets or configuration.
///
/// Quick start:
/// ```dart
/// // Inline in RichText
/// RichText(
///   text: TextSpan(
///     children: [
///       TextSpan(text: 'Click '),
///       Icons.share.toTextSpan(style: TextStyle(fontSize: 20)),
///       TextSpan(text: ' to share'),
///     ],
///   ),
/// )
///
/// // Standalone Text widget
/// Icons.star.toText(iconSize: 32, iconColor: Colors.amber)
/// ```
///
/// ### Vertical centering
///
/// Icon fonts have different internal metrics from system text fonts. When
/// mixing an icon with adjacent text at a different size, the icon may appear
/// too high or too low. Two parameters solve this:
///
/// 1. **`iconHeight`** on [toTextSpan] / [toText] — adjusts the line-height
///    multiplier of the glyph span itself. Start with `1.0` and fine-tune.
/// 2. **`strutStyle`** on [toText] — forces every span in the widget to share
///    the same line box. Set `forceStrutHeight: true` to lock alignment across
///    mixed-size spans.
///
/// ```dart
/// Icons.star.toText(
///   prefix: 'Rating: ',
///   style: TextStyle(fontSize: 16),
///   iconSize: 24,
///   iconHeight: 1.0,          // removes extra glyph padding
///   strutStyle: StrutStyle(
///     fontSize: 24,
///     forceStrutHeight: true, // locks every span to the same line box
///   ),
/// )
/// ```
extension IconToTextExtension on IconData {
  /// Returns the Unicode character string for this icon's code point.
  ///
  /// The returned string is a single character whose Unicode value matches
  /// [codePoint]. Use it in [Text] or [TextSpan] together with the correct
  /// [fontFamily] and [fontPackage] to render the glyph.
  ///
  /// Example:
  /// ```dart
  /// final char = Icons.star.iconToString();
  /// ```
  String iconToString() {
    return String.fromCharCode(codePoint);
  }

  /// Returns a [TextSpan] that renders this icon as a text glyph.
  ///
  /// The icon is placed between optional [prefix] and [postfix] text according
  /// to [iconPosition]. All three segments share a common base [style]; each
  /// can be overridden independently via [prefixStyle], [postfixStyle], and
  /// [iconStyle].
  ///
  /// ---
  ///
  /// ### Vertical alignment
  ///
  /// Icon fonts have different internal metrics from body text fonts. If the
  /// icon appears too high or too low relative to adjacent text, use
  /// **[iconHeight]** to adjust the glyph's line-height multiplier:
  ///
  /// - `1.0` — line height equals the font size exactly (removes extra spacing)
  /// - `null` — uses the font's intrinsic metrics (default; can cause misalignment)
  ///
  /// For consistent alignment across a whole [Text.rich] widget, combine with
  /// `strutStyle` on [toText]:
  /// ```dart
  /// Icons.notifications.toText(
  ///   prefix: 'You have 3 ',
  ///   style: TextStyle(fontSize: 14),
  ///   iconSize: 20,
  ///   iconHeight: 1.0,
  ///   strutStyle: StrutStyle(fontSize: 20, forceStrutHeight: true),
  /// )
  /// ```
  ///
  /// ### Font features and icon fonts
  ///
  /// Icon fonts render glyphs by Unicode code point, not by typographic rules.
  /// Most [fontFeatures] (ligatures, kerning, contextual alternates) have no
  /// effect on icon fonts and can be safely omitted. Pass [fontFeatures] only
  /// when using a variable or hybrid font that explicitly supports OpenType
  /// features on its icon glyphs.
  ///
  /// ---
  ///
  /// Parameters:
  /// - [style]: Base [TextStyle] for prefix and postfix. Used as the style
  ///   base for the icon glyph unless [iconStyle] is provided.
  /// - [prefix]: Optional text before the icon (exact position set by
  ///   [iconPosition]).
  /// - [postfix]: Optional text after the icon.
  /// - [iconSize]: Overrides the font size for the icon glyph only. Ignored
  ///   when [iconStyle] is provided.
  /// - [iconColor]: Overrides the color for the icon glyph only. Ignored when
  ///   [iconStyle] is provided.
  /// - [iconHeight]: Line-height multiplier for the icon glyph's [TextStyle].
  ///   Controls the vertical space the glyph occupies within the text line.
  ///   `1.0` removes any extra leading; ignored when [iconStyle] is provided.
  /// - [iconTextBaseline]: [TextBaseline] for the icon span. Ignored when
  ///   [iconStyle] is provided.
  /// - [fontFeatures]: OpenType font features for the icon glyph. Most icon
  ///   fonts ignore these; see note above. Ignored when [iconStyle] is provided.
  /// - [iconSemanticsLabel]: Accessibility description for the icon glyph,
  ///   read by screen readers in place of the raw character.
  /// - [prefixStyle]: Style override for the prefix span. Falls back to
  ///   [style] when `null`.
  /// - [postfixStyle]: Style override for the postfix span. Falls back to
  ///   [style] when `null`.
  /// - [iconStyle]: Full [TextStyle] override for the icon glyph. When set,
  ///   [iconSize], [iconColor], [iconHeight], [iconTextBaseline], and
  ///   [fontFeatures] are ignored, but [fontFamily] and [fontPackage] from
  ///   this [IconData] are still applied automatically.
  /// - [iconPosition]: Order of icon, prefix, and postfix. Defaults to
  ///   [IconPosition.middle] (prefix — icon — postfix).
  /// - [onTap]: Optional tap callback. Attaches a [TapGestureRecognizer] to
  ///   the icon span; no recognizer is created when `null`.
  ///
  /// Example:
  /// ```dart
  /// CupertinoIcons.share.toTextSpan(
  ///   prefix: 'Tap ',
  ///   postfix: ' to share',
  ///   style: TextStyle(fontSize: 18, color: Colors.black87),
  ///   iconColor: Colors.blue,
  ///   iconHeight: 1.0,
  /// )
  /// ```
  TextSpan toTextSpan({
    TextStyle? style,
    String? prefix,
    String? postfix,
    double? iconSize,
    Color? iconColor,
    double? iconHeight,
    TextBaseline? iconTextBaseline,
    List<FontFeature>? fontFeatures,
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
            height: iconHeight,
            textBaseline: iconTextBaseline,
            fontFeatures: fontFeatures,
          ),
    );

    final prefixSpan = (prefix != null && prefix.isNotEmpty)
        ? TextSpan(text: prefix, style: prefixStyle ?? style)
        : null;

    final postfixSpan = (postfix != null && postfix.isNotEmpty)
        ? TextSpan(text: postfix, style: postfixStyle ?? style)
        : null;

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

  /// Returns a [Text.rich] widget that renders this icon as a text glyph.
  ///
  /// Internally calls [toTextSpan] and wraps the result in [Text.rich],
  /// adding widget-level layout controls such as [textAlign], [maxLines],
  /// [strutStyle], and [textHeightBehavior].
  ///
  /// ---
  ///
  /// ### Vertical centering — recommended approach
  ///
  /// When the icon is a different size from the surrounding text, use
  /// **[strutStyle]** with `forceStrutHeight: true`. This locks all spans in
  /// the widget to the same line box height, centering the icon reliably:
  ///
  /// ```dart
  /// Icons.star.toText(
  ///   prefix: 'Rating: ',
  ///   style: TextStyle(fontSize: 14),
  ///   iconSize: 22,
  ///   iconHeight: 1.0,
  ///   strutStyle: StrutStyle(
  ///     fontSize: 22,
  ///     forceStrutHeight: true,
  ///   ),
  /// )
  /// ```
  ///
  /// For subtle nudges, try adjusting [iconHeight] alone (values between
  /// `0.9` and `1.3` cover most cases) before reaching for [strutStyle].
  ///
  /// ---
  ///
  /// Parameters:
  /// - [style]: Base [TextStyle] for prefix, postfix, and icon fallback.
  /// - [key]: Optional key for the [Text] widget.
  /// - [textAlign]: Horizontal alignment within the widget's container.
  /// - [prefix]: Optional text before the icon.
  /// - [postfix]: Optional text after the icon.
  /// - [iconSize]: Overrides font size for the icon glyph only.
  /// - [iconColor]: Overrides color for the icon glyph only.
  /// - [iconHeight]: Line-height multiplier for the icon glyph. The most
  ///   direct way to fix vertical misalignment. `1.0` removes extra glyph
  ///   leading. Ignored when [iconStyle] is provided.
  /// - [iconTextBaseline]: Baseline alignment for the icon span. Ignored when
  ///   [iconStyle] is provided.
  /// - [fontFeatures]: OpenType features for the icon glyph. Icon fonts
  ///   typically render by code point and ignore these; include only when
  ///   your custom font explicitly supports them.
  /// - [textDirection]: Directionality of the text (LTR or RTL).
  /// - [semanticsLabel]: Accessibility label for the whole widget.
  /// - [maxLines]: Maximum number of lines before truncation.
  /// - [textOverflow]: How to handle text that exceeds [maxLines].
  /// - [strutStyle]: Defines the minimum line metrics for the widget. Use
  ///   `StrutStyle(forceStrutHeight: true)` to force every span — including
  ///   the icon — to use the same line box height, which is the recommended
  ///   fix for vertical centering across mixed font sizes.
  /// - [textHeightBehavior]: Controls how [TextStyle.height] is applied to the
  ///   first and last lines. Use in combination with [strutStyle] for precise
  ///   vertical spacing control.
  /// - [textScaler]: Controls how the text responds to the user's system font
  ///   size. Defaults to the ambient [TextScaler] from [MediaQuery]. Pass
  ///   [TextScaler.noScaling] to disable system font scaling for this widget.
  /// - [softWrap]: Whether the text may break across lines. Defaults to `true`.
  /// - [prefixStyle]: Style override for the prefix span.
  /// - [postfixStyle]: Style override for the postfix span.
  /// - [iconStyle]: Full style override for the icon glyph.
  /// - [iconPosition]: Order of icon relative to prefix and postfix.
  /// - [onTap]: Optional tap callback on the icon span.
  Text toText({
    TextStyle? style,
    Key? key,
    TextAlign? textAlign,
    String? prefix,
    String? postfix,
    double? iconSize,
    Color? iconColor,
    double? iconHeight,
    TextBaseline? iconTextBaseline,
    List<FontFeature>? fontFeatures,
    TextDirection? textDirection,
    String? semanticsLabel,
    int? maxLines,
    TextOverflow? textOverflow,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
    TextScaler? textScaler,
    bool softWrap = true,
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
        iconHeight: iconHeight,
        iconTextBaseline: iconTextBaseline,
        fontFeatures: fontFeatures,
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
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler,
      softWrap: softWrap,
    );
  }

  /// Returns a [WidgetSpan] that embeds this icon as an inline widget.
  ///
  /// Unlike [toTextSpan], which renders the icon as a text glyph within a
  /// [TextSpan], this wraps the glyph in a [Text] widget and embeds it via
  /// [WidgetSpan]. Use this when you need widget-level placement control —
  /// for example, to add padding around the icon, to achieve precise vertical
  /// [alignment] relative to adjacent text, or to wrap with gesture detectors.
  ///
  /// ---
  ///
  /// ### Vertical alignment with WidgetSpan
  ///
  /// [PlaceholderAlignment] gives full control over vertical positioning:
  ///
  /// - [PlaceholderAlignment.middle] — centers the widget in the text line
  ///   (default, works well in most cases)
  /// - [PlaceholderAlignment.baseline] — aligns the widget baseline with the
  ///   text baseline (use with [textBaseline] for typographic precision)
  /// - [PlaceholderAlignment.top] / [PlaceholderAlignment.bottom] — pins to
  ///   the top or bottom of the line box
  ///
  /// ```dart
  /// Text.rich(
  ///   TextSpan(
  ///     children: [
  ///       TextSpan(text: 'Check your '),
  ///       Icons.inbox.toWidgetSpan(
  ///         iconSize: 20,
  ///         iconColor: Colors.blue,
  ///         alignment: PlaceholderAlignment.middle,
  ///       ),
  ///       TextSpan(text: ' inbox.'),
  ///     ],
  ///   ),
  /// )
  /// ```
  ///
  /// ### Font feature note
  ///
  /// The icon character is rendered in a nested [Text] widget using the icon's
  /// [fontFamily]. Font features set on the outer [TextSpan] do not propagate
  /// into the [WidgetSpan]; apply [iconStyle] if you need specific features.
  ///
  /// ---
  ///
  /// Parameters:
  /// - [iconSize]: Font size for the icon character.
  /// - [iconColor]: Foreground color for the icon character.
  /// - [iconStyle]: Full [TextStyle] for the icon. Overrides [iconSize] and
  ///   [iconColor] when provided; [fontFamily] and [fontPackage] are applied
  ///   automatically when [iconStyle] is `null`.
  /// - [alignment]: Vertical alignment of the widget relative to surrounding
  ///   text. Defaults to [PlaceholderAlignment.middle].
  /// - [baseline]: The text baseline to align to when [alignment] is
  ///   [PlaceholderAlignment.baseline], [PlaceholderAlignment.aboveBaseline],
  ///   or [PlaceholderAlignment.belowBaseline].
  /// - [semanticsLabel]: Accessibility description for screen readers.
  WidgetSpan toWidgetSpan({
    double? iconSize,
    Color? iconColor,
    TextStyle? iconStyle,
    PlaceholderAlignment alignment = PlaceholderAlignment.middle,
    TextBaseline? baseline,
    String? semanticsLabel,
  }) {
    final style =
        iconStyle ??
        TextStyle(
          fontFamily: fontFamily,
          package: fontPackage,
          fontSize: iconSize,
          color: iconColor,
        );
    return WidgetSpan(
      alignment: alignment,
      baseline: baseline,
      child: Text(
        String.fromCharCode(codePoint),
        style: style,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}

/// Controls the position of the icon glyph relative to [prefix] and [postfix]
/// text in [IconToTextExtension.toTextSpan] and [IconToTextExtension.toText].
enum IconPosition {
  /// Icon is placed before the prefix text.
  ///
  /// Order: icon — prefix — postfix
  start,

  /// Icon is placed between the prefix and postfix text.
  ///
  /// Order: prefix — icon — postfix (default)
  middle,

  /// Icon is placed after the postfix text.
  ///
  /// Order: prefix — postfix — icon
  end,
}
