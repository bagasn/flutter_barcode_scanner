import 'package:barcode_scanner/config/app_router.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Scanner',
      routerConfig: AppRouter.getRouter,
    );
  }
}
