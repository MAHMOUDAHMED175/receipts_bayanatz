




import 'package:flutter/material.dart';
import 'package:receipts_bayanatz/core/widgets/custom_button.dart';
import 'package:receipts_bayanatz/core/widgets/text_from_field_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen/receipts_printer_view/content_pdf_receipts.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';

class AddItemProduct extends StatelessWidget {
   AddItemProduct({Key? key}) : super(key: key);
  var nameProductController = TextEditingController();
  var countProductController = TextEditingController();
  var priceProductController = TextEditingController();
  var totalPriceProductController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultFormField(
                        controller: nameProductController,
                        type: TextInputType.text,
                        hintText: "الاسم",
                        fillsColor: Colors.grey[300],
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '  الاسم';
                          }
                        }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultFormField(
                        controller: countProductController,
                        type: TextInputType.phone,
                        hintText: "الكميه",
                        fillsColor: Colors.grey[300],
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '  الكميه';
                          }
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultFormField(
                        controller: priceProductController,
                        type: TextInputType.phone,
                        hintText: "السعر",
                        fillsColor: Colors.grey[300],
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '  السعر';
                          }
                        }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultFormField(
                        controller: totalPriceProductController,
                        type: TextInputType.phone,
                        hintText: "السعر الكلى",
                        fillsColor: Colors.grey[300],
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "السعر الكلى";
                          }
                        }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ReceiptCubit.get(context).InsertDatabase(
                            productName: nameProductController.text,
                            productPrice: priceProductController.text,
                            productCount: countProductController.text,
                            productTotal:
                            totalPriceProductController.text
                        );


                        nameProductController.text='';
                        priceProductController.text='';
                        countProductController.text='';
                        totalPriceProductController.text='';
                      }
                    },
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    text: 'اضافة المنتج'),
                SizedBox(
                  width: 50,
                ),
                SizedBox(
                    height:60,
                    width: 60,
                    child: ContentReceipts()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



