import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts_bayanatz/confg/app_route.dart';
import 'package:receipts_bayanatz/confg/local_notification/notification_services.dart';
import 'package:receipts_bayanatz/core/widgets/custom_app_par.dart';
import 'package:receipts_bayanatz/core/widgets/flutter_toast.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/body_receipts_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/pdf_receipts.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class ReceiptsPrinterView extends StatefulWidget {
  ReceiptsPrinterView({Key? key}) : super(key: key);

  @override
  State<ReceiptsPrinterView> createState() => _ReceiptsPrinterViewState();
}

class _ReceiptsPrinterViewState extends State<ReceiptsPrinterView> {
  @override
  void initState() {
    NotificationsServices().initializationNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
              textAppBar: 'Template Receipts',
              elevationAppBar: 10,
              showenCenterText: true,
              actionsAppBar: [])),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: CreatePdfReceipts()),
            contentReceiptsWidget(),
            MaterialButton(
              onPressed: () {
                // await FlutterLocalNotificationsPlugin.;
                NotificationsServices().BigNotification('Receipts',
                    'We thank you for your trust,Downloading.................');
              },
              child: Text( ' pdfتنزيل الايصال  ك '),
              color: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                height: 60,
                minWidth: double.infinity,
                onPressed: () {
                  GoRouter.of(context).push(AppRoute.devicesPrinter);
                  showToast(
                      text: 'جارى البحث عن اجهزه يرجى فتح البلوتوث',
                      state: ToastStates.WARNING);
                },
                child: Text('هل تريد طباعه الايصال !!'),
                color: Colors.orange[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
