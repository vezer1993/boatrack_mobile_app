import 'dart:convert';
import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';
import 'package:http/http.dart' as http;

import '../models/account.dart';
import '../models/charter.dart';
import '../resources/strings/strings_api.dart';

Future getResponse(String path) async {
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());

  return await client.get(url, headers: await createHeaders());
}

Future getResponseWithParam(String path, Map<String, dynamic> param) async {
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString(), param);

  return await client.get(url, headers: await createHeaders());
}


Future putResponse(String path, var body) async {
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());
  return await client.put(url, headers: await createHeaders(), body: jsonEncode(body));
}

Future postResponse(String path, var body) async {
  var client = http.Client();
  path = STRINGS_API.api_version.toString() + path.toString();
  print(path);
  var url = Uri.https(STRINGS_API.api_root.toString(), path.toString());
  return await client.post(url, headers: await createHeaders(), body: jsonEncode(body));
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