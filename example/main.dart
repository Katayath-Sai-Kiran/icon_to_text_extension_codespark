import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_to_text_extension_codespark/icon_to_text_extension_codespark.dart';
import 'package:icon_to_text_extension_codespark/src/icon_text_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IconToTextExtension Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IconTextDemoPage(),
    );
  }
}

class IconTextDemoPage extends StatelessWidget {
  const IconTextDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IconToTextExtension Demo'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic usage with prefix and postfix
            CupertinoIcons.share.toText(
              prefix: 'Tap ',
              postfix: ' to share',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            IconTextLabel(
              icon: Icons.send,
              prefix: 'Send ',
              postfix: ' Now',
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("sdas")));
              },
              iconSize: 20,
              textStyle: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            CupertinoIcons.hand_point_right.toText(
              prefix: 'Click ',
              postfix: ' to proceed',
              style: const TextStyle(fontSize: 24),
              iconColor: Colors.blue,
              iconSize: 24,
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Icon tapped!')));
              },
            ),
            const SizedBox(height: 24),

            // Override icon size and color only
            CupertinoIcons.heart_fill.toText(
              prefix: 'You ',
              postfix: ' this!',
              style: const TextStyle(fontSize: 24),
              iconSize: 28,
              iconColor: Colors.amber,
            ),
            const SizedBox(height: 24),

            // With semantics label
            CupertinoIcons.location.toText(
              prefix: 'Location: ',
              postfix: ' enabled',
              iconSize: 22,
              iconColor: Colors.green,
              semanticsLabel: 'location icon',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),

            // With maxLines and overflow
            Icons.home_outlined.toText(
              prefix: 'This is a very long prefix text that may overflow ',
              postfix: ' and icon in between.',
              iconSize: 24,
              iconColor: Colors.amber,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
