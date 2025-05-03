import 'package:flutter/material.dart';
import '../../ihelper/shared_variables.dart';

class CustRichText extends StatelessWidget {
  const CustRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.textSize = 16,
    this.secondTextColor = myGoldenColor,
    this.firstTextColor = Colors.black,
  });

  final String firstText;
  final String secondText;
  final double textSize;
  final Color firstTextColor;
  final Color secondTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$firstText: ',
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            color: firstTextColor,
          ),
          children: [
            TextSpan(
              text: secondText,
              style: TextStyle(color: secondTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
