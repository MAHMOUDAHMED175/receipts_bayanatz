import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts_bayanatz/core/utils/cacheHelper.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/on_bording/on_bording.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/devices_printer_lisiten_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/content_pdf_receipts.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/products_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/recepts_companyInfo_view.dart';

import '../main.dart';

abstract class AppRoute {
  static const String homePage = '/HomePage';

  static const String receiptsPrinterView = '/ReceiptsPrinterView';
  static const String devicesPrinter = '/DevicesPrinter';
  static const String contentReceipts = '/ContentReceipts';
  static const String productsReceipts = '/ProductsReceipts';

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
      ), GoRoute(
        path: contentReceipts,
        builder: (BuildContext context, GoRouterState state) {
          return ContentReceipts();
        },
      ), GoRoute(
        path: productsReceipts,
        builder: (BuildContext context, GoRouterState state) {
          return ProductsReceipts();
        },
      ),
    ],
  );
}
