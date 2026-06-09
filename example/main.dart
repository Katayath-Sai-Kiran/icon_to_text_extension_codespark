import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_to_text_extension_codespark/icon_to_text_extension_codespark.dart';

void main() {
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'icon_to_text_extension_codespark Playground',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlaygroundHome(),
    );
  }
}

class PlaygroundHome extends StatelessWidget {
  const PlaygroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('icon_to_text Playground'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Basic'),
              Tab(text: 'Rich Builder'),
              Tab(text: 'Custom Fonts'),
              Tab(text: 'IconTextLabel'),
              Tab(text: 'Layout'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BasicTab(),
            RichBuilderTab(),
            CustomFontsTab(),
            IconTextLabelTab(),
            LayoutTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — Basic: toText, toTextSpan, toWidgetSpan, iconToString
// ---------------------------------------------------------------------------

class BasicTab extends StatelessWidget {
  const BasicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('toText — standalone widget'),
        const SizedBox(height: 12),
        Icons.share.toText(
          prefix: 'Click ',
          postfix: ' to share',
          style: const TextStyle(fontSize: 20, color: Colors.black87),
          iconColor: Colors.blue,
          iconSize: 22,
        ),
        const SizedBox(height: 12),
        CupertinoIcons.heart_fill.toText(
          prefix: 'You ',
          postfix: ' this',
          style: const TextStyle(fontSize: 20),
          iconSize: 24,
          iconColor: Colors.red,
        ),
        const SizedBox(height: 12),
        Icons.star.toText(
          prefix: 'Rating: ',
          iconSize: 28,
          iconColor: Colors.amber,
          style: const TextStyle(fontSize: 20),
        ),
        const Divider(height: 40),
        _SectionHeader('toText — with overflow control'),
        const SizedBox(height: 12),
        Icons.home_outlined.toText(
          prefix: 'This is a very long label that will overflow ',
          postfix: ' and then show an ellipsis.',
          iconSize: 22,
          iconColor: Colors.deepPurple,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18),
        ),
        const Divider(height: 40),
        _SectionHeader('toWidgetSpan — icon embedded in Text.rich'),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            children: [
              const TextSpan(text: 'Check your '),
              Icons.inbox.toWidgetSpan(iconSize: 22, iconColor: Colors.blue),
              const TextSpan(text: ' for updates.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18),
            children: [
              const TextSpan(text: 'Press '),
              CupertinoIcons.location.toWidgetSpan(
                iconSize: 22,
                iconColor: Colors.green,
                alignment: PlaceholderAlignment.baseline,
              ),
              const TextSpan(text: ' to enable location.'),
            ],
          ),
        ),
        const Divider(height: 40),
        _SectionHeader('iconToString — raw Unicode character'),
        const SizedBox(height: 12),
        Text(
          'Raw glyph: ${Icons.favorite.iconToString()}  '
          'Code point: 0x${Icons.favorite.codePoint.toRadixString(16)}',
          style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
        ),
        const Divider(height: 40),
        _SectionHeader('onTap — interactive icon text'),
        const SizedBox(height: 12),
        CupertinoIcons.hand_point_right.toText(
          prefix: 'Tap ',
          postfix: ' to trigger an action',
          style: const TextStyle(fontSize: 18),
          iconColor: Colors.blue,
          iconSize: 22,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Icon tapped!')),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Rich Builder: IconRichTextBuilder.buildSpan / buildRichText
// ---------------------------------------------------------------------------

class RichBuilderTab extends StatelessWidget {
  const RichBuilderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('buildRichText — mixed icon and string list'),
        const SizedBox(height: 12),
        IconRichTextBuilder.buildRichText(
          [
            'Tap ',
            CupertinoIcons.share,
            ' or ',
            Icons.send,
            ' to continue',
          ],
          defaultStyle: const TextStyle(fontSize: 18),
          defaultIconColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        IconRichTextBuilder.buildRichText(
          [
            'Your ',
            Icons.inbox,
            ' is empty. Add items using ',
            Icons.add_circle_outline,
          ],
          defaultStyle: const TextStyle(fontSize: 18, color: Colors.black87),
          defaultIconColor: Colors.deepPurple,
          defaultIconSize: 22,
        ),
        const Divider(height: 40),
        _SectionHeader('buildSpan — used inside RichText'),
        const SizedBox(height: 12),
        Text.rich(
          IconRichTextBuilder.buildSpan(
            [
              'You have ',
              TextSpan(
                text: '3 unread messages',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ' — tap ',
              CupertinoIcons.bell_fill,
              ' to view them.',
            ],
            defaultStyle: const TextStyle(fontSize: 17, color: Colors.black87),
            defaultIconColor: Colors.orange,
            defaultIconSize: 20,
          ),
        ),
        const Divider(height: 40),
        _SectionHeader('buildRichText — overflow and alignment'),
        const SizedBox(height: 12),
        IconRichTextBuilder.buildRichText(
          [
            'This is a very long sentence with multiple icons ',
            Icons.star,
            ' and more text ',
            Icons.favorite,
            ' that will be truncated.',
          ],
          defaultStyle: const TextStyle(fontSize: 18),
          defaultIconColor: Colors.amber,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — Custom Fonts: CustomCodePointExtension on int
// ---------------------------------------------------------------------------

class CustomFontsTab extends StatelessWidget {
  const CustomFontsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // These demos use Material icon code points with 'MaterialIcons' as the
    // font family, which is always available in Flutter apps. In production
    // you would pass the code point and font family of your own icon font
    // (e.g. FontAwesome, Ionicons, Remix Icons) registered in pubspec.yaml.

    final starCodePoint = Icons.star.codePoint;
    final favoriteCodePoint = Icons.favorite.codePoint;
    final shareCodePoint = CupertinoIcons.share.codePoint;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('toCustomTextSpan — any font family by code point'),
        const SizedBox(height: 8),
        const Text(
          'Demos below use Material icon code points. Replace the fontFamily '
          'and code point with your own registered icon font.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18),
            children: [
              const TextSpan(text: 'Rating: '),
              starCodePoint.toCustomTextSpan(
                fontFamily: 'MaterialIcons',
                iconSize: 24,
                iconColor: Colors.amber,
              ),
              starCodePoint.toCustomTextSpan(
                fontFamily: 'MaterialIcons',
                iconSize: 24,
                iconColor: Colors.amber,
              ),
              starCodePoint.toCustomTextSpan(
                fontFamily: 'MaterialIcons',
                iconSize: 24,
                iconColor: Colors.grey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18),
            children: [
              const TextSpan(text: 'Liked '),
              favoriteCodePoint.toCustomTextSpan(
                fontFamily: 'MaterialIcons',
                iconSize: 22,
                iconColor: Colors.red,
                semanticsLabel: 'heart icon',
              ),
              const TextSpan(text: ' by 142 people'),
            ],
          ),
        ),
        const Divider(height: 40),
        _SectionHeader('toCustomText — standalone widget'),
        const SizedBox(height: 12),
        shareCodePoint.toCustomText(
          fontFamily: 'CupertinoIcons',
          fontPackage: 'cupertino_icons',
          iconSize: 32,
          iconColor: Colors.deepPurple,
          textAlign: TextAlign.center,
          semanticsLabel: 'Share icon',
        ),
        const Divider(height: 40),
        _SectionHeader('toCustomTextSpan — with onTap'),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18),
            children: [
              const TextSpan(text: 'Tap '),
              favoriteCodePoint.toCustomTextSpan(
                fontFamily: 'MaterialIcons',
                iconSize: 24,
                iconColor: Colors.pink,
                semanticsLabel: 'like button',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Liked!')),
                  );
                },
              ),
              const TextSpan(text: ' to like this post'),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — IconTextLabel declarative widget
// ---------------------------------------------------------------------------

class IconTextLabelTab extends StatelessWidget {
  const IconTextLabelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('IconTextLabel — basic usage'),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.send,
          prefix: 'Send ',
          postfix: ' Now',
          iconSize: 20,
          textStyle: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: CupertinoIcons.location,
          prefix: 'Location: ',
          postfix: ' enabled',
          iconSize: 22,
          iconColor: Colors.green,
          semanticsLabel: 'location icon',
          textStyle: TextStyle(fontSize: 18),
        ),
        const Divider(height: 40),
        _SectionHeader('IconTextLabel — per-segment styles'),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.star,
          prefix: 'Rating: ',
          postfix: ' / 5',
          iconSize: 28,
          iconColor: Colors.amber,
          textStyle: TextStyle(fontSize: 18, color: Colors.black54),
          prefixStyle: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          postfixStyle: TextStyle(fontSize: 14, color: Colors.black38),
        ),
        const Divider(height: 40),
        _SectionHeader('IconTextLabel — iconPosition variants'),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.arrow_forward,
          prefix: 'Start: ',
          postfix: ' text',
          iconPosition: IconPosition.start,
          iconColor: Colors.blue,
          textStyle: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.arrow_forward,
          prefix: 'Middle: ',
          postfix: ' text',
          iconPosition: IconPosition.middle,
          iconColor: Colors.deepPurple,
          textStyle: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.arrow_forward,
          prefix: 'End: ',
          postfix: ' text',
          iconPosition: IconPosition.end,
          iconColor: Colors.teal,
          textStyle: TextStyle(fontSize: 18),
        ),
        const Divider(height: 40),
        _SectionHeader('IconTextLabel — tappable'),
        const SizedBox(height: 12),
        IconTextLabel(
          icon: CupertinoIcons.share,
          prefix: 'Tap ',
          postfix: ' to share',
          iconColor: Colors.blue,
          iconSize: 22,
          textStyle: const TextStyle(fontSize: 18),
          semanticsLabel: 'Share button',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share tapped!')),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Layout: iconHeight, strutStyle, textScaler, baseline alignment
// ---------------------------------------------------------------------------

class LayoutTab extends StatelessWidget {
  const LayoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionHeader('Vertical centering — without iconHeight (default)'),
        const SizedBox(height: 8),
        const Text(
          'Icon at 28sp next to text at 14sp — the icon may sit too high '
          'due to the icon font\'s internal line metrics.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Icons.star.toText(
          prefix: 'Rating: ',
          postfix: ' out of 5',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          iconSize: 28,
          iconColor: Colors.amber,
        ),
        const Divider(height: 40),
        _SectionHeader('Vertical centering — iconHeight: 1.0'),
        const SizedBox(height: 8),
        const Text(
          'Setting iconHeight to 1.0 removes extra leading above and below '
          'the glyph, which is often enough to fix the alignment.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Icons.star.toText(
          prefix: 'Rating: ',
          postfix: ' out of 5',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          iconSize: 28,
          iconColor: Colors.amber,
          iconHeight: 1.0,
        ),
        const Divider(height: 40),
        _SectionHeader('Vertical centering — iconHeight + strutStyle'),
        const SizedBox(height: 8),
        const Text(
          'Adding strutStyle with forceStrutHeight: true locks every span '
          'to the same line box — the most reliable fix for mixed font sizes.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Icons.star.toText(
          prefix: 'Rating: ',
          postfix: ' out of 5',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          iconSize: 28,
          iconColor: Colors.amber,
          iconHeight: 1.0,
          strutStyle: const StrutStyle(
            fontSize: 28,
            forceStrutHeight: true,
          ),
        ),
        const Divider(height: 40),
        _SectionHeader('Vertical centering — IconTextLabel'),
        const SizedBox(height: 8),
        const Text(
          'The same iconHeight and strutStyle params are available on '
          'IconTextLabel for declarative usage.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        const IconTextLabel(
          icon: Icons.notifications,
          prefix: 'You have 3 ',
          postfix: ' alerts',
          textStyle: TextStyle(fontSize: 14, color: Colors.black87),
          iconSize: 26,
          iconColor: Colors.deepPurple,
          iconHeight: 1.0,
          strutStyle: StrutStyle(fontSize: 26, forceStrutHeight: true),
        ),
        const Divider(height: 40),
        _SectionHeader('toWidgetSpan — baseline alignment'),
        const SizedBox(height: 8),
        const Text(
          'PlaceholderAlignment.baseline aligns the widget baseline with '
          'the text baseline for typographic precision.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            children: [
              const TextSpan(text: 'Filed under '),
              Icons.folder.toWidgetSpan(
                iconSize: 22,
                iconColor: Colors.orange,
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
              ),
              const TextSpan(text: ' Documents'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            children: [
              const TextSpan(text: 'Synced via '),
              Icons.cloud_done.toWidgetSpan(
                iconSize: 22,
                iconColor: Colors.teal,
                alignment: PlaceholderAlignment.middle,
              ),
              const TextSpan(text: ' Cloud'),
            ],
          ),
        ),
        const Divider(height: 40),
        _SectionHeader('textScaler — opt out of system font scaling'),
        const SizedBox(height: 8),
        const Text(
          'Pass TextScaler.noScaling to keep the icon and text at their '
          'declared size regardless of the user\'s accessibility font setting.',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Icons.lock_outline.toText(
          prefix: 'Secure: ',
          postfix: ' connection',
          style: const TextStyle(fontSize: 16),
          iconSize: 20,
          iconColor: Colors.green,
          textScaler: TextScaler.noScaling,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 0.4,
      ),
    );
  }
}
