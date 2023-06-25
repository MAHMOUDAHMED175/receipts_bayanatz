import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
class PrintPdfContent extends StatelessWidget {
  const PrintPdfContent({Key? key}) : super(key: key);
  static Future<void> printDemoReceipt(NetworkPrinter printer,context,index) async {

    var cubit=ReceiptCubit.get(context);

    // Print image
    final ByteData data = await rootBundle.load('${cubit.savePathImage}');
    final Uint8List bytes = data.buffer.asUint8List();
    final image = decodeImage(bytes);
    printer.image(image!);
    printer.text('${cubit.company[index]['companyName']}',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    printer.text('${cubit.company[index]['companyAddress']}',
        styles: const PosStyles(align: PosAlign.center));
    printer.text('${cubit.company[index]['companyPhone']}',
        styles: const PosStyles(align: PosAlign.center));

    printer.hr();
    printer.row([
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Item', width: 7),
      PosColumn(
          text: 'Price',
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    printer.row([
      PosColumn(text: '${cubit.product[index]['productCount']}', width: 1),
      PosColumn(text: '${cubit.product[index]['productName']}', width: 7),
      PosColumn(
          text: '${cubit.product[index]['productPrice']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '${cubit.product[index]['productTotal']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    printer.row([
      PosColumn(text: '${cubit.product[index+1]['productCount']}', width: 1),
      PosColumn(text: '${cubit.product[index+1]['productName']}', width: 7),
      PosColumn(
          text: '${cubit.product[index+1]['productPrice']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '${cubit.product[index+1]['productTotal']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    printer.row([
      PosColumn(text: '${cubit.product[index+2]['productCount']}', width: 1),
      PosColumn(text: '${cubit.product[index+2]['productName']}', width: 7),
      PosColumn(
          text: '${cubit.product[index+2]['productPrice']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '${cubit.product[index+2]['productTotal']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    printer.row([
      PosColumn(text: '${cubit.product[index+3]['productCount']}', width: 1),
      PosColumn(text: '${cubit.product[index+3]['productName']}', width: 7),
      PosColumn(
          text: '${cubit.product[index+3]['productPrice']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '${cubit.product[index+3]['productTotal']}', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);

    printer.hr();

    printer.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: '\$10.97',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    printer.hr(ch: '=', linesAfter: 1);

    printer.row([
      PosColumn(
          text: 'Cash',
          width: 8,
          styles:
          const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$15.00',
          width: 4,
          styles:
          const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);
    printer.row([
      PosColumn(
          text: 'Change',
          width: 8,
          styles:
          const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$4.03',
          width: 4,
          styles:
          const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);

    printer.feed(2);
    printer.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    printer.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);

    printer.feed(1);
    printer.cut();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

