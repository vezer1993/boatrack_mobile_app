import 'dart:convert';
import 'package:boatrack_mobile_app/models/employeeTask.dart';
import 'package:flutter/material.dart';
import '../../models/account.dart';
import '../../models/charter.dart';
import '../../resources/strings/strings_api.dart';
import '../services.dart';
import 'package:http/http.dart' as http;

Future getTaskList(BuildContext context) async {

  Accounts acc = await getAccount();
  Charter ch = await getCharter();
  var response = await getResponse("${STRINGS_API.api_task_list}/${ch.id}/${acc.id}", context) as http.Response;
  var jsonMap = json.decode(response.body);
  List<EmployeeTask> list = [];
  for(var json in jsonMap){
    EmployeeTask t = EmployeeTask.fromJson(json);
    list.add(t);
  }

  return list;
}