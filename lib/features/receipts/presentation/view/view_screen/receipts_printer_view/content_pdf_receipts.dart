import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLip;
import 'package:receipts_bayanatz/core/widgets/custom_button.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/pdf_viewer_view.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';

class ContentReceipts extends StatelessWidget {
  const ContentReceipts({Key? key}) : super(key: key);

  createPdf(List<Map<dynamic, dynamic>> company,
      List<Map<dynamic, dynamic>> product, BuildContext context, index) async {
    final pdfLip.Document pdf = pdfLip.Document(deflate: zlib.encode);

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);

    ///
//انا مش راضى عن الحته دى وان الداتا مينفعش تكون كدا وان لازم تكون داخل ليست فيو
    //وان شاء الله هعملها فى المستقبل
    num total = int.parse(product[index]['productTotal']) +
        int.parse(product[index + 1]['productTotal']);
    // int.parse(product[index + 2]['productTotal']) +
    // int.parse(product[index + 3]['productTotal']);
    num tax = 5;
    num totalAfterTax = int.parse(product[index]['productTotal']) +
        int.parse(product[index + 1]['productTotal']) -
        // int.parse(product[index + 2]['productTotal']) +
        // int.parse(product[index + 3]['productTotal']) -
        tax;

    ///
    final imagePath = ReceiptCubit.get(context).savePathImage;
    final file = File(imagePath!);

    final bytes = await file.readAsBytes();
    final image = pdfLip.MemoryImage(bytes);

    pdf.addPage(
      pdfLip.Page(
        build: (context) {
          return pdfLip.Column(
            mainAxisAlignment: pdfLip.MainAxisAlignment.center,
            crossAxisAlignment: pdfLip.CrossAxisAlignment.center,
            children: [
              pdfLip.Expanded(
                child: pdfLip.Container(
                    height: 150,
                    width: 150,
                    decoration: pdfLip.BoxDecoration(
                        borderRadius: pdfLip.BorderRadius.circular(30.0),
                        image: pdfLip.DecorationImage(image: image))),
              ),

              // pdfLip.Image(image, width: 300,height: 200), // Add image widget here
              pdfLip.SizedBox(height: 10),
              pdfLip.Text(
                '${company[index]['companyName']}',
                style: pdfLip.TextStyle(
                  fontSize: 30,
                  color: PdfColors.red,
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.SizedBox(height: 10),

              pdfLip.Text(
                '${company[index]['companyAddress']}',
                style: pdfLip.TextStyle(
                  fontSize: 25,
                  color: PdfColors.black,
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.SizedBox(height: 10),
              pdfLip.Text(
                '${company[index]['companyPhone']}',
                style: pdfLip.TextStyle(
                  fontSize: 25,
                  color: PdfColors.black,
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.SizedBox(height: 30),

              pdfLip.Expanded(
                child: pdfLip.ListView.separated(
                    itemBuilder: (context, index) {
                      return pdfLip.Container(
                        padding: const pdfLip.EdgeInsets.all(20.0),
                        decoration: pdfLip.BoxDecoration(
                          color: PdfColors.grey200,
                          borderRadius: pdfLip.BorderRadius.circular(12),
                        ),
                        child: pdfLip.Padding(
                          padding: const pdfLip.EdgeInsets.all(8.0),
                          child: pdfLip.Row(
                            mainAxisAlignment:
                                pdfLip.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.Flexible(
                                flex: 6,
                                child: pdfLip.Column(
                                  crossAxisAlignment:
                                      pdfLip.CrossAxisAlignment.start,
                                  children: [
                                    pdfLip.Text(
                                      "${product[index]['productName']}",
                                      maxLines: 2,
                                      style: pdfLip.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pdfLip.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.Flexible(
                                flex: 3,
                                child: pdfLip.Column(
                                  crossAxisAlignment:
                                      pdfLip.CrossAxisAlignment.start,
                                  children: [
                                    pdfLip.Text(
                                      "${product[index]['productPrice']}",
                                      maxLines: 2,
                                      style: pdfLip.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pdfLip.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.Flexible(
                                flex: 3,
                                child: pdfLip.Text(
                                  "${product[index]['productCount']}",
                                  maxLines: 2,
                                  style: pdfLip.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pdfLip.FontWeight.normal,
                                  ),
                                ),
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                              pdfLip.Flexible(
                                flex: 3,
                                child: pdfLip.Column(
                                  crossAxisAlignment:
                                      pdfLip.CrossAxisAlignment.start,
                                  children: [
                                    pdfLip.Text(
                                      "${product[index]['productTotal']}",
                                      maxLines: 2,
                                      style: pdfLip.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pdfLip.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pdfLip.SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: product.length,
                    separatorBuilder: (context, index) {
                      return pdfLip.Container(
                        child: pdfLip.Divider(),
                      );
                    }),
              ),

              // pdfLip.Table.fromTextArray(
              //   data: [
              //     ['Qty', 'Item', 'Price', 'Total'],
              //     [
              //       '${product[index]['productCount']}',
              //       '${product[index]['productName']}',
              //       '${product[index]['productPrice']}',
              //       '${product[index]['productTotal']}',
              //     ],
              //     [
              //       '${product[index + 1]['productCount']}',
              //       '${product[index + 1]['productName']}',
              //       '${product[index + 1]['productPrice']}',
              //       '${product[index + 1]['productTotal']}',
              //     ],
              //     [
              //       '${product[index + 2]['productCount']}',
              //       '${product[index + 2]['productName']}',
              //       '${product[index + 2]['productPrice']}',
              //       '${product[index + 2]['productTotal']}',
              //     ],
              //     [
              //       '${product[index + 3]['productCount']}',
              //       '${product[index + 3]['productName']}',
              //       '${product[index + 3]['productPrice']}',
              //       '${product[index + 3]['productTotal']}',
              //     ],
              //   ],
              //   rowDecoration: const pdfLip.BoxDecoration(
              //       gradient: pdfLip.LinearGradient(colors: [
              //     PdfColors.grey300,
              //     PdfColors.white,
              //     PdfColors.grey300,
              //   ])),
              // ),
              pdfLip.SizedBox(height: 10),
              pdfLip.Padding(
                padding: const pdfLip.EdgeInsets.symmetric(horizontal: 50),
                child: pdfLip.Row(
                    mainAxisAlignment: pdfLip.MainAxisAlignment.spaceBetween,
                    children: [
                      pdfLip.Column(children: [
                        pdfLip.Text(
                          'TOTAL',
                          style: pdfLip.TextStyle(
                            fontSize: 15,
                            color: PdfColors.black,
                            fontWeight: pdfLip.FontWeight.bold,
                          ),
                        ),
                        pdfLip.Text(
                          '\$$total',
                          style: pdfLip.TextStyle(
                            fontSize: 15,
                            color: PdfColors.black,
                            fontWeight: pdfLip.FontWeight.bold,
                          ),
                        ),
                      ]),
                      pdfLip.Column(children: [
                        pdfLip.Text(
                          'Tax',
                          style: pdfLip.TextStyle(
                            fontSize: 15,
                            color: PdfColors.black,
                            fontWeight: pdfLip.FontWeight.bold,
                          ),
                        ),
                        pdfLip.Text(
                          '\$$tax',
                          style: pdfLip.TextStyle(
                            fontSize: 15,
                            color: PdfColors.black,
                            fontWeight: pdfLip.FontWeight.bold,
                          ),
                        ),
                      ]),
                    ]),
              ),

              pdfLip.SizedBox(height: 10),

              pdfLip.Text(
                'Total After Tax',
                style: pdfLip.TextStyle(
                  fontSize: 30,
                  color: PdfColors.red,
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.Text(
                '\$$totalAfterTax',
                style: pdfLip.TextStyle(
                  fontSize: 30,
                  color: PdfColors.red,
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.SizedBox(height: 10),
              pdfLip.Text(
                'Thank you! ',
                style: pdfLip.TextStyle(
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.Text(
                timestamp,
                style: pdfLip.TextStyle(
                  fontWeight: pdfLip.FontWeight.bold,
                ),
              ),
              pdfLip.PdfLogo()
            ],
          );
        },
      ),
    );
    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/Receipt.pdf';

    final Uint8List pdfBytes = await pdf.save(); // Await the result

    final File filepdf = File(path);

    filepdf
        .writeAsBytesSync(pdfBytes.toList()); // Convert Uint8List to List<int>

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFScreen(path)));
    // return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: () async {
          createPdf(ReceiptCubit.get(context).company,
              ReceiptCubit.get(context).product, context, 0);
        },
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        text: 'PDF');
  }
}
