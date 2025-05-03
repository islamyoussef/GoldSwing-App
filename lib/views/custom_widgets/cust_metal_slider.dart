import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';

class CustMetalSlider extends StatelessWidget {
  const CustMetalSlider({
    super.key,
    required this.metal,
    required this.selectedMetal,
    required this.image,
    required this.onTap,
  });

  final String metal;
  final String selectedMetal;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.43,
        height: 125,
        decoration: BoxDecoration(
          // Border
          border: Border.all(
            color: metal == selectedMetal ? myGoldenColor : Colors.white70,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          // Image
          image: DecorationImage(
            image: ExactAssetImage(image),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(
              65,
              64,
              63,
              metal == selectedMetal ? 0.10 : 0.40,
            ), // Specifies the background color and the opacity [const Color.fromRGBO(90, 89, 89, 0.5)]
          ),
          child: Text(
            metal,
            style: TextStyle(
              color:
                  metal == selectedMetal
                      ? myGoldenColor
                      : Colors.white, //myGoldenColor
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
