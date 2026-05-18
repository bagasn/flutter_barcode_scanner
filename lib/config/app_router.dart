import 'package:barcode_scanner/pages/home_page.dart';
import 'package:barcode_scanner/pages/scanner_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get getRouter => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(path: '/scanner', builder: (context, state) => ScannerPage()),
    ],
  );
}
