import 'package:boatrack_mobile_app/models/cleaning.dart';
import 'package:http/http.dart' as http;
import '../../resources/strings/strings_api.dart';
import '../services.dart';

Future postCleaning(Cleaning c, int yachtID) async {

  print("HELLO");
  var response = await postResponse(STRINGS_API.api_cleaning, c.toJson()) as http.Response;


  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}