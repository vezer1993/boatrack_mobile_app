import 'dart:convert';
import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_api.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/charter.dart';
import '../../models/yacht.dart';
import '../services.dart';

Future getYachtList(bool refresh, BuildContext context) async {

  ///TODO: FOR PRODUCTION REFRESH DATA EVERY X MINUTES
  /// CHECK IF LIST IN SESSION

  String? jsonList = await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.yachts);

  if(jsonList == null || refresh == true){
    Charter c = await getCharter();
    var response = await getResponse("${STRINGS_API.api_yachts_list}/${c.id}", context) as http.Response;
    jsonList = response.body;

    await LOCAL_STORAGE.saveValue(STRINGS_PREFFERENCES.yachts, jsonList);
  }

  var jsonMap = json.decode(jsonList);
  List<Yacht> list = [];
  for(var json in jsonMap){
    Yacht y = Yacht.fromJson(json);
    list.add(y);
  }

  return list;
}