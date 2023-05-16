import 'package:flutter/material.dart';
import '../constants/constants.dart';

class OurTextField extends StatelessWidget {

  String? hintText;
  Icon? icon;
  TextEditingController? controller;
  TextStyle textStyle =  const TextStyle(
      color: kMainWhiteColor
  );
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  String? Function(String?)? onChanged;



  OurTextField({
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
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

        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }
}
