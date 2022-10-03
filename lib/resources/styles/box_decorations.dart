import 'package:flutter/material.dart';

import '../colors.dart';

class CustomDecorations{

  static BoxShadow containerBoxShadow() {
    return BoxShadow(
        color: CustomColors().appShadowColor,
        spreadRadius: 0.5,
        blurRadius: 3);
  }
  
  static BoxDecoration buttonBoxDecoration() {
      return BoxDecoration(
        color: CustomColors().primaryColor,
        borderRadius: BorderRadius.circular(5)
      );
  }


  static BoxDecoration buttonDisabledBoxDecoration() {
    return BoxDecoration(
        color: CustomColors().inputBorderNotFocusedColor,
        borderRadius: BorderRadius.circular(5)
    );
  }

  static BoxDecoration buttonPassBoxDecoration() {
    return BoxDecoration(
        color: CustomColors().successBoxBackgroundColor,
        borderRadius: BorderRadius.circular(5)
    );
  }

  static BoxDecoration buttonFailBoxDecoration() {
    return BoxDecoration(
        color: CustomColors().failBoxBackgroundColor,
        borderRadius: BorderRadius.circular(5)
    );
  }

  static InputDecoration inputDecoration() {
    return InputDecoration(
      fillColor: CustomColors().appBackgroundColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: CustomColors().borderColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: CustomColors().primaryColor)),
      filled: true,
      contentPadding:
      EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
    );
  }

}