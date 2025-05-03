import 'package:flutter/material.dart';

class CustLabelWithIcon extends StatelessWidget {
  const CustLabelWithIcon({
    super.key,
    required this.change,
    this.textSize = 16,
  });

  final double change;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          change.toStringAsFixed(2),
          style: TextStyle(fontSize: textSize, color: Colors.white),
        ),

        SizedBox(width: 4),

        arrowIcon(),
      ],
    );
  }

  Icon arrowIcon() {
    double iconSize = 40;
    if (change > 0) {
      return Icon(Icons.arrow_upward, weight: iconSize, color: Colors.green);
    } else if (change < 0) {
      return Icon(Icons.arrow_downward, weight: iconSize, color: Colors.red);
    } else {
      return Icon(
        Icons.horizontal_rule,
        weight: iconSize,
        color: Colors.white70,
      );
    }
  }
}
