

import 'package:flutter/material.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';

class AlertDialogeTakeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  ReceiptCubit.get(context).takeImageCamera(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.2),
                    color: Colors.orange,

                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                         "استخدام الكاميرا",
                          textDirection: TextDirection.rtl,
                          // style: Styles.textStyle20.copyWith(
                          //     fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  ReceiptCubit.get(context).takeImageGellary(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.2),
                    color: Colors.orange,

                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "فتح معرض الصور",
                          textDirection: TextDirection.rtl,
                          // style: Styles.textStyle20.copyWith(
                          //     fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
