import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLip;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class CreatePdfReceipts extends StatelessWidget {
  const CreatePdfReceipts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          createPdf(context, 'mahmoud', 'ahmed', '2012');
        },
        child: Text('data'));
  }

  createPdf(
      BuildContext context, String name, String lastName, String year) async {
    print('nnnnnnnnnnnnnnnnnnn');
    final pdfLip.Document pdf = pdfLip.Document(deflate: zlib.encode);
    print('2222222222222222222');

    pdf.addPage(
      pdfLip.MultiPage(
        build: (context) => [
          pdfLip.Column(
            mainAxisAlignment: pdfLip.MainAxisAlignment.center,
            crossAxisAlignment: pdfLip.CrossAxisAlignment.center,
            children: [
              pdfLip.Center(child:pdfLip.Text('Dear Food',textAlign: pdfLip.TextAlign.center,style: pdfLip.TextStyle(
                  fontSize: 60
              )),), pdfLip.Center(child:pdfLip.Text('Dear Food',textAlign: pdfLip.TextAlign.center,style: pdfLip.TextStyle(
                  fontSize: 0
              )),), pdfLip.Center(child:pdfLip.Text('Dear Food',textAlign: pdfLip.TextAlign.center,style: pdfLip.TextStyle(
                  fontSize: 60
              )),), pdfLip.Center(child:pdfLip.Text('Dear Food',textAlign: pdfLip.TextAlign.center,style: pdfLip.TextStyle(
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
    print('33333333333333333333');

    final String dir = (await getApplicationDocumentsDirectory()).path;
    print('4444444444444444444');

    final String path = '$dir/pdfExample.pdf';
    print('35555555555555');

    final Uint8List pdfBytes = await pdf.save(); // Await the result
    print('3666666666666');

    final File file = File(path);
    print('37777777777777777');

    file.writeAsBytesSync(pdfBytes.toList()); // Convert Uint8List to List<int>
    print('88888888888888888');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFScreen(path)));
  }
}

class PDFScreen extends StatelessWidget {
  const PDFScreen(this.path, {Key? key}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return
        // ShareExtend.share(path, 'file',sharePanelTitle: 'Enkdddddd');
        Scaffold(
            appBar:AppBar(),
            body:PdfView(path: path));
  }
}
