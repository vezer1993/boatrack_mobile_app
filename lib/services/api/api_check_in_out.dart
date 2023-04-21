import 'dart:convert';
import 'package:boatrack_mobile_app/models/check_in_out.dart';
import 'package:boatrack_mobile_app/models/check_model.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../services.dart';


Future getCheckModel(String id, BuildContext context) async {
  var response = await getResponse("${STRINGS_API.api_check_in_out_model}/${id}", context) as http.Response;
  var jsonObject = json.decode(response.body);
  return CheckModel.fromJson(jsonObject[0]);
}

Future postCheckModel(BuildContext context, CheckInOut model, bool isCheckIn) async{
  await model.generateDocument(context, isCheckIn);

  String path = STRINGS_API.api_check_in;
  if(!isCheckIn){
    path = STRINGS_API.api_check_out;
  }
  var response = await postResponse(path, model.toJson(), context) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }

}