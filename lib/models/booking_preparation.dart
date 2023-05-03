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
    preCheckinPrep = json['precheckin'] != null ? PrepObject.fromJson(json['precheckin']) : null;
    postCheckoutPrep = json['postcheckout'] != null ? PrepObject.fromJson(json['postcheckout']) : null;
    cleaning = json['cleaning'] != null ? Cleaning.fromJson(json['cleaning']) : null;
    if(json['guestsArrived'] != null){
      guestsArrived = json['guestsArrived'];
    }
  }


}