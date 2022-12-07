import 'dart:convert';
import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

import '../models/account.dart';
import '../models/charter.dart';
import '../resources/strings/strings_api.dart';

Future getResponse(String path, BuildContext context) async {
  context.loaderOverlay.show();
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());

  var response = await client.get(url, headers: await createHeaders());
  context.loaderOverlay.hide();
  return response;
}

Future getResponseWithParam(String path, Map<String, dynamic> param, BuildContext context) async {
  context.loaderOverlay.show();
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString(), param);

  var response = await client.get(url, headers: await createHeaders());

  context.loaderOverlay.hide();
  return response;
}


Future putResponse(String path, var body, BuildContext context) async {
  context.loaderOverlay.show();
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());
  var response = await client.put(url, headers: await createHeaders(), body: jsonEncode(body));
  context.loaderOverlay.hide();
  return response;
}

Future putResponseNoBody(String path, BuildContext context) async {
  context.loaderOverlay.show();
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());
  var response = await client.put(url, headers: await createHeaders());
  context.loaderOverlay.hide();
  return response;
}

Future postResponse(String path, var body, BuildContext context) async {
  context.loaderOverlay.show();
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());
  var response = await client.post(url, headers: await createHeaders(), body: jsonEncode(body));
  context.loaderOverlay.hide();
  return response;
}

Future<Map<String, String>> createHeaders() async{
  return {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    "Content-Type": "application/json",
  };
}

Future<Charter> getCharter() async{
  String? jsonString = await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.charter);
  var jsonVar = json.decode(jsonString!);
  return Charter.fromJson(jsonVar);
}

Future<Accounts> getAccount() async{
  String? jsonString = await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.account);
  var jsonVar = json.decode(jsonString!);
  return Accounts.fromJson(jsonVar);
}