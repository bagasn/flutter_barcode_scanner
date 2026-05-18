import 'package:barcode_scanner/dialog/dialog_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      child: DialogBarcodeScanner(),
    );

    final result = await showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}
