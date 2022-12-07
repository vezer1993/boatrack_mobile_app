import 'dart:typed_data';
import 'package:boatrack_mobile_app/helper/lottie/lottie_manager.dart';
import 'package:boatrack_mobile_app/models/helper/custom_image.dart';
import 'package:boatrack_mobile_app/models/issues.dart';
import 'package:boatrack_mobile_app/models/issues_images.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_api.dart';
import 'package:boatrack_mobile_app/services/api/azure.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services.dart';

Future postIssue(IssueItem issue, BuildContext context, List<CustomImage> pictures) async {

  var response = await postResponse(STRINGS_API.api_issues, issue.toJson(), context) as http.Response;
  var jsonObject = json.decode(response.body);
  IssueItem createdIssue = IssueItem.fromJson(jsonObject);

  if(pictures.isNotEmpty){
    for(CustomImage pic in pictures){
      String path = await uploadImageToAzure(context, pic.name.toString(), pic.imageByte);

      IssueImages issueImage = IssueImages(imagePath: path, issueId: createdIssue.id);

      await postResponse(STRINGS_API.api_issue_images, issueImage.toJson(), context) as http.Response;
    }
  }

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}