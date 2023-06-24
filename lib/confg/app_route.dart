import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts_bayanatz/core/utils/cacheHelper.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/on_bording/on_bording.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/devices_printer_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/recepts_printer_view.dart';

import '../main.dart';

abstract class AppRoute {
  static const String homePage = '/HomePage';

  static const String receiptsPrinterView = '/BeceiptsPrinterView';
  static const String devicesPrinter = '/DevicesPrinter';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          var onBoarding = CacheHelper.getData(key: "onBoarding");
          if (onBoarding != null) {
            return ReceiptsPrinterView();
          } else {
            return const OnBoardingScreen();
          }
        },
      ),
      GoRoute(
        path: homePage,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: receiptsPrinterView,
        builder: (BuildContext context, GoRouterState state) {
          return ReceiptsPrinterView();
        },
      ),
      GoRoute(
        path: devicesPrinter,
        builder: (BuildContext context, GoRouterState state) {
          return DevicesPrinter();
        },
      ),
    ],
  );
}
