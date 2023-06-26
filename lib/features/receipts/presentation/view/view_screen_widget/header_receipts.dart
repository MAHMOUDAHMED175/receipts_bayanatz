import 'package:flutter/material.dart';
import 'package:receipts_bayanatz/core/utils/styles.dart';

Widget headerSell(context) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.grey[300],
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children:  [
              SizedBox(
                width: MediaQuery.of(context).size.height*0.03,
              ),
              const Expanded(
                  child: Text(
                'الاسم',
                style: Styles.textStyle20,
              )),
              const Expanded(
                  child: Text(
                'السعر ',
                style: Styles.textStyle20,
              )),
              const Expanded(
                  child: Text(
                'الكميه',
                style: Styles.textStyle20,
              )),
              const Expanded(
                  child: Text(
                ' الكلى',
                style: Styles.textStyle20,
              )),
            ],
          ),
        ),
      ),
    );
