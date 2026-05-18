import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DialogBarcodeScanner extends StatefulWidget {
  const DialogBarcodeScanner({super.key});

  @override
  State<DialogBarcodeScanner> createState() => _DialogBarcodeScannerState();
}

class _DialogBarcodeScannerState extends State<DialogBarcodeScanner> {
  final _scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: MobileScanner(
              controller: _scannerController,
              onDetect: (barcodes) {
                print(barcodes.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
