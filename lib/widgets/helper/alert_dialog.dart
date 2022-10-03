import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ALERTS {
  static showAlertDialog(BuildContext context, String title, String description) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: CustomTextStyles.regularText(context),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title, style: CustomTextStyles.headerText(context),),
      content: Text(description, style: CustomTextStyles.regularText(context),),
      backgroundColor: CustomColors().altBackgroundColor,
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
