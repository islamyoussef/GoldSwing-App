import 'package:flutter/material.dart';

class CustLabelNormal extends StatelessWidget {
  const CustLabelNormal({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.size = 17,
  });

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
