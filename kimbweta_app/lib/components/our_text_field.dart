import 'package:flutter/material.dart';
import '../constants/constants.dart';

class OurTextField extends StatelessWidget {

  String? hintText;
  Icon? icon;
  TextStyle textStyle =  const TextStyle(
      color: kMainWhiteColor
  );

  OurTextField({required this.hintText, required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(

        decoration: InputDecoration(
            border: OutlineInputBorder(


                borderRadius: BorderRadius.circular(20.0),
                borderSide:  const BorderSide(
                  color: Colors.red,
                  width: 5.0,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignInside
                ),



            ),
            prefixIcon: icon,
            hintText: hintText,
            hintStyle: textStyle
        ),

      ),
    );
  }
}
