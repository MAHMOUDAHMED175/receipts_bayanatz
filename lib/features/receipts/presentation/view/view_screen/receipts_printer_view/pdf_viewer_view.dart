
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:receipts_bayanatz/confg/app_route.dart';
import 'package:receipts_bayanatz/core/utils/colors.dart';
import 'package:receipts_bayanatz/core/utils/styles.dart';
import 'package:share_extend/share_extend.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen(this.path, {Key? key}) : super(key: key);

  final String path;


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                ShareExtend.share(path, 'file', sharePanelTitle: 'Receipt');
              }, icon: Icon(Icons.download)),
              TextButton(onPressed: () {
                GoRouter.of(context).push(AppRoute.devicesPrinter);
              }, child: Text('طباعه',style: Styles.textStyle20.copyWith(color: ColorsApp.whiteText))),
            ],
            title: Text('PDF',style: Styles.textStyle20,),
            // centerTitle: true,
          ),
          body: PdfView(path: path));
  }
}
