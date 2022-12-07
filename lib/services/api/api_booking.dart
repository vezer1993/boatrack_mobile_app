import 'dart:convert';
import 'package:boatrack_mobile_app/resources/strings/strings_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../helper/lottie/lottie_manager.dart';
import '../../models/booking_preparation.dart';
import '../../models/guest.dart';
import '../services.dart';

Future setGuestsArrived(BuildContext context, String bookingID) async {
  var response = await putResponseNoBody("${STRINGS_API.api_booking}/$bookingID", context) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    LottieManager.showSuccessMessage(context);
    return true;
  }else{
    return false;
  }
}

Future getGuest(String guestID, BuildContext context) async {
  var response = await getResponse("${STRINGS_API.api_booking_guest}/$guestID", context) as http.Response;
  var jsonVar = json.decode(response.body);
  Guest topG = Guest.fromJson(jsonVar);
  return(topG);
}

Future getBookingPreparationStatus(String bookingID, BuildContext context) async {
  var response = await getResponse("${STRINGS_API.api_booking_preparation}/$bookingID", context) as http.Response;
  var jsonVar = json.decode(response.body);
  BookingPreparation bp = BookingPreparation.fromJson(jsonVar);
  return(bp);
}