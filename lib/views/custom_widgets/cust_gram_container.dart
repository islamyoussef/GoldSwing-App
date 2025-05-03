import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';
import 'package:gold_swing/views/custom_widgets/cust_rich_text.dart';

import 'cust_label_normal.dart';

class CustGramContainer extends StatelessWidget {
  const CustGramContainer({super.key, required this.text, required this.price});

  final String text;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(250, 224, 78, 0.502),
            spreadRadius: 5,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustLabelNormal(text: text, size: 14, color: Colors.black87),
          CustRichText(
            textSize: 14,
            firstText: price.toStringAsFixed(2),
            firstTextColor: Colors.black54,
            secondText: ' EGP',
            secondTextColor: myGoldenColor,
          ),

          /*
          CustLabelNormal(
            text: price.toStringAsFixed(2),
            size: 14,
            color: Colors.black54,
          ),
*/
        ],
      ),
    );
  }
}
