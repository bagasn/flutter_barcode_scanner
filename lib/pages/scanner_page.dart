import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MobileScanner());
  }
}
