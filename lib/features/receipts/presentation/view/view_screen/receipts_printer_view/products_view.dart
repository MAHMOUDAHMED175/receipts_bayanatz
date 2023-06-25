import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipts_bayanatz/core/widgets/custom_app_par.dart';
import 'package:receipts_bayanatz/core/widgets/divider.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/add_item_product_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/header_receipts.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view/view_screen_widget/item_product-receipts_widget.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_state.dart';

class ProductsReceipts extends StatelessWidget {
  ProductsReceipts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptCubit, ReceiptState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
              textAppBar: 'المنتجات',
              elevationAppBar: 0,
              showenCenterText: true,
              actionsAppBar: [])),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          ConditionalBuilder(
            condition: ReceiptCubit.get(context).product.isNotEmpty,
            builder: (context) => Expanded(
              child: Column(
                children: [
                  headerSell(),
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => itemProductReceipts(
                            product: ReceiptCubit.get(context).product[index],
                            context: context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ReceiptCubit.get(context).product.length),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
                child: Column(
              children: const [
                Text(
                  'لايوجد منتجات',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            )),
          ),
          AddItemProduct(),
        ],
      ),
    );
  },
);
  }
}
