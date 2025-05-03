import 'package:flutter/material.dart';

import '../../ihelper/shared_variables.dart';
import 'cust_label_normal.dart';
import 'cust_rich_text.dart';

class CustArchiveContent extends StatelessWidget {
  const CustArchiveContent({
    super.key,
    required this.shortCut,
    required this.gram,
    required this.price,
    required this.change,
    required this.date,
    required this.onTap,
  });

  final String shortCut;
  final String gram;
  final double price;
  final double change;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white30,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustLabelNormal(
                  text: shortCut,
                  size: 24,
                  color:
                      shortCut.toLowerCase() == 'gold'
                          ? myGoldenColor
                          : Colors.white,
                ),

                SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustRichText(
                      firstText: gram,
                      firstTextColor: Colors.white,
                      secondText: price.toStringAsFixed(2),
                      secondTextColor:
                          shortCut.toLowerCase() == 'XAU'
                              ? myGoldenColor
                              : Colors.white,
                      textSize: 14,
                    ),

                    SizedBox(width: 10),

                    CustLabelNormal(
                      text: date,
                      size: 14,
                      color: Colors.white30,
                    ),
                  ],
                ),
              ],
            ),

            Icon(
              change > 0 ? Icons.arrow_upward : Icons.arrow_downward,
              color: change > 0 ? Colors.green : Colors.red,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
