import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_to_text_extension_codespark/src/icon_text_extension.dart';

// Import your extension file here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(title: const Text('IconToTextExtension Demo')),
      body: Center(
        child: CupertinoIcons.share.toText(
          prefix: 'Tap ',
          postfix: ' to share',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
