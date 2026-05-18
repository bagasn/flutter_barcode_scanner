import 'package:barcode_scanner/pages/scanner_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(
            onPressed: () {
              _redirectToScanner(context);
            },
            child: Text('To Scanner'),
          ),
        ],
      ),
    );
  }

  void _redirectToScanner(BuildContext context) async {
    final dialog = Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: ScannerPage(),
    );

    final result = await showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}
