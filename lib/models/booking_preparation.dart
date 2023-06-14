import 'package:boatrack_mobile_app/models/prep_object.dart';

import 'check_in_out.dart';
import 'cleaning.dart';

class BookingPreparation {

  CheckInOut? checkIn;
  CheckInOut? checkOut;
  PrepObject? preCheckinPrep;
  PrepObject? postCheckoutPrep;
  Cleaning? cleaning;
  bool? guestsArrived;


  BookingPreparation.fromJson(Map<String, dynamic> json) {
    checkIn =
    json['checkin'] != null ? CheckInOut.fromJson(json['checkin']) : null;
    checkOut = json['checkout'] != null ? CheckInOut.fromJson(json['checkout']) : null;
    preCheckinPrep = json['preCheckinPrep'] != null ? PrepObject.fromJson(json['preCheckinPrep']) : null;
    postCheckoutPrep = json['postCheckoutPrep'] != null ? PrepObject.fromJson(json['postCheckoutPrep']) : null;
    cleaning = json['cleaning'] != null ? Cleaning.fromJson(json['cleaning']) : null;
    if(json['guestsArrived'] != null){
      guestsArrived = json['guestsArrived'];
    }
  }


}