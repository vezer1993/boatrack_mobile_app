import 'package:boatrack_mobile_app/models/cleaning.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../resources/strings/strings_api.dart';
import '../services.dart';

Future postCleaning(Cleaning c, int yachtID, BuildContext context) async {
  var response = await postResponse(STRINGS_API.api_cleaning, c.toJson(), context) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}