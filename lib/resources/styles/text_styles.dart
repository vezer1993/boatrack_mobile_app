import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextStyles {

  static TextStyle? headerText (BuildContext context){
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2.8;

    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: multiplier * unitHeightValue,
        color: CustomColors().primaryColor,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle? regularText (BuildContext context){
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2.1;

    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: multiplier * unitHeightValue,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle? buttonText (BuildContext context){
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2.5;

    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: multiplier * unitHeightValue,
        color: CustomColors().buttonTextColor,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle? yachtStatus (BuildContext context, Color textColor){
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 1.6;

    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: multiplier * unitHeightValue,
        color: textColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5
    );
  }

}