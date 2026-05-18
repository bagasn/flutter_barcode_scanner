import 'package:barcode_scanner/utilities/audio_player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final logger = Logger(printer: PrettyPrinter());

  final _scannerController = MobileScannerController(
    detectionTimeoutMs: 500,
    autoStart: false,
    torchEnabled: false,
    facing: CameraFacing.back,
    cameraResolution: Size(720, 1080),
  );

  final audioServices = AudioPlayerService();

  bool _isCameraContinued = false;

  List<Barcode> _values = [];

  @override
  void initState() {
    _isCameraContinued = true;
    _scannerController.start();
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          icon: Icon(Icons.close),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: MobileScanner(
                controller: _scannerController,
                onDetect: (barcodes) async {
                  if (barcodes.barcodes.isNotEmpty) {
                    final lastBar = barcodes.barcodes.last;
                    final isContain = _values.where(
                      (test) => test.rawValue == lastBar.rawValue,
                    );

                    if (isContain.isEmpty) {
                      audioServices.play('assets/beep.mp3');
                      _scannerController.stop();

                      setState(() {
                        _values.add(lastBar);
                        _isCameraContinued = false;
                      });
                    }
                  }

                  final buffer = StringBuffer();
                  for (final bar in barcodes.barcodes) {
                    buffer.write('${bar.rawValue}\n');
                  }
                  logger.d(buffer.toString());
                },
                overlayBuilder: (context, constraints) {
                  return Container(
                    height: 160,
                    width: constraints.maxWidth - (24 * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow.shade700,
                        width: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lightbulb,
                        color: Colors.yellowAccent.shade700,
                      ),
                    ),

                    //* Middle
                    IconButton(
                      onPressed: () async {
                        _actionPlay();
                      },
                      style: IconButton.styleFrom(
                        iconSize: 52,
                        padding: EdgeInsets.all(12),
                      ),
                      icon: Icon(
                        _isCameraContinued ? Icons.pause : Icons.play_arrow,
                        color: Colors.redAccent,
                      ),
                    ),

                    //* End
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lightbulb,
                        color: Colors.yellowAccent.shade700,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text('Content'),
                      for (final barcode in _values)
                        Text(
                          'Type: ${barcode.format.name},\n BarcodeRaw: ${barcode.rawValue}',
                          style: TextStyle(
                            decoration: TextDecoration.combine([
                              TextDecoration.underline,
                            ]),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _actionPlay() async {
    if (!_isCameraContinued) {
      await _scannerController.start();

      setState(() {
        _isCameraContinued = true;
      });
    }
  }
}
