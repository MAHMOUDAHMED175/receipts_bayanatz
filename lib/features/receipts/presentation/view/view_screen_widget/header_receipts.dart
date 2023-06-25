import 'package:flutter/material.dart';

Widget headerSell() => Padding(
  padding: const EdgeInsets.all(4.0),
  child:   Container(

        color: Colors.grey[300],

        height: 60,

        child: Padding(

          padding: const EdgeInsets.all(4.0),

          child: Row(

            children: [

              Expanded(

                  child: Text(

                'الاسم',

              )),

              Expanded(

                  child: Text(

                'السعر ',

              )),

              Expanded(child: Text('الكميه', )),

              Expanded(child: Text(' الكلى', )),

            ],

          ),

        ),

      ),
);
