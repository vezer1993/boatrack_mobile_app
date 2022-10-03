

import 'dart:convert';

import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';

import '../../models/account.dart';
import '../../models/charter.dart';
import '../../resources/strings/strings_api.dart';
import '../services.dart';
import 'package:http/http.dart' as http;

Future loginToMobile(String username, String password) async{

  String path = "${STRINGS_API.api_accounts_mobile_login}/$username/$password";
  var response = await getResponse(path) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    await LOCAL_STORAGE.saveValue(STRINGS_PREFFERENCES.charter, response.body);

    Charter c = Charter.fromJson(json.decode(response.body));
    for(Accounts a in c.accounts!){
      if(a.username == username){
        await LOCAL_STORAGE.saveValue(STRINGS_PREFFERENCES.account, json.encode(a.toJson()));
      }
    }
    return true;
  }else{
    return false;
  }

}