import 'package:flutter/material.dart';
import 'package:receipts_bayanatz/core/utils/styles.dart';
import 'package:receipts_bayanatz/features/receipts/presentation/view_model/managers/cubit/receipt_cubit.dart';

Widget itemProductReceipts({required  product,context}) =>
    Stack(
      children:[
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Flexible(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            // '${units.conversationFactory}',
                            product['productName'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            // '${units.conversationFactory}',
                            product['productPrice'],
                            maxLines: 2,
                            style: Styles.textStyle16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            // '${units.conversationFactory}',
                            product['productCount'],
                            maxLines: 2,
                            style: Styles.textStyle16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            // '${units.conversationFactory}',
                            product['productTotal'],
                            maxLines: 2,
                            style: Styles.textStyle16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.003,
                ),
              ],
            ),
          ),
        ),
        IconButton(onPressed: (){
          ReceiptCubit.get(context).DeleteData(id1: product['id']);
        }, icon: const Icon(Icons.delete,color: Colors.red,)),

      ]
    );
