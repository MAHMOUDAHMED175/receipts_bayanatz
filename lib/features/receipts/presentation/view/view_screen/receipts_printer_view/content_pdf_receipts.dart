import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:receipts_bayanatz/confg/app_route.dart';
import 'package:receipts_bayanatz/core/utils/colors.dart';
import 'package:receipts_bayanatz/core/utils/styles.dart';
import 'package:receipts_bayanatz/core/widgets/custom_button.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/pdf_viewer_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
import 'package:share_extend/share_extend.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLip;

class ContentReceipts extends StatelessWidget {
  const ContentReceipts({Key? key}) : super(key: key);

  createPdf(BuildContext context, String name, String lastName,
      String year) async {
    final pdfLip.Document pdf = pdfLip.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLip.MultiPage(
        build: (context) =>
        [
          pdfLip.Column(
              mainAxisAlignment: pdfLip.MainAxisAlignment.center,
              crossAxisAlignment: pdfLip.CrossAxisAlignment.center,
              children: [
                pdfLip.Center(child: pdfLip.Text(
                    'Dear Food', textAlign: pdfLip.TextAlign.center,
                    style: pdfLip.TextStyle(
                        fontSize: 60
                    )),),
                pdfLip.Center(child: pdfLip.Text(
                    'Dear Food', textAlign: pdfLip.TextAlign.center,
                    style: pdfLip.TextStyle(
                        fontSize: 0
                    )),),
                pdfLip.Center(child: pdfLip.Text(
                    'Dear Food', textAlign: pdfLip.TextAlign.center,
                    style: pdfLip.TextStyle(
                        fontSize: 60
                    )),),
                pdfLip.Center(child: pdfLip.Text(
                    'Dear Food', textAlign: pdfLip.TextAlign.center,
                    style: pdfLip.TextStyle(
                        fontSize: 60
                    )),)
              ]
          ),
          pdfLip.Table.fromTextArray(data: <List<String>>[
            <String>['name', 'subname', 'idade'],
            [name, lastName, year]
          ])
        ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/Receipt.pdf';

    final Uint8List pdfBytes = await pdf.save(); // Await the result

    final File file = File(path);

    file.writeAsBytesSync(pdfBytes.toList()); // Convert Uint8List to List<int>

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFScreen(path)));
  }

  @override
  Widget build(BuildContext context){
    return  CustomButton(
        onPressed: () {
          createPdf(
              context, 'dd', '${ReceiptCubit.get(context).product[0]['id']}', '2012');
        },
        backgroundColor:Colors.orange,
        textColor: Colors.white,
        text: 'PDF');
  }
}

