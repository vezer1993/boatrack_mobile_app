import 'package:boatrack_mobile_app/helper/lottie/success.dart';
import 'package:flutter/material.dart';

class LottieManager{

  static showSuccessMessage(BuildContext context){
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return const DialogSuccess();
        });
  }

}