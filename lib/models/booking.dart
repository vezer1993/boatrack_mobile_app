
import 'charter.dart';
import 'check_in_out.dart';
import 'cleaning.dart';

class Booking {
  int? id;
  int? charterId;
  int? yachtId;
  String? datefrom;
  String? dateto;
  String? agent;
  int? guestId;
  String? note;
  int? crewcount;
  String? items;
  String? priceBase;
  String? discount;
  String? commission;
  String? priceFinal;
  String? priceClient;
  String? updateId;
  int? checkInId;
  int? checkOutId;
  int? cleaningId;
  CheckInOut? checkIn;
  CheckInOut? checkOut;
  Cleaning? cleaning;
  List<Cleaning>? cleanings;
  Charter? charter;

  Booking(
      {this.id,
        this.charterId,
        this.yachtId,
        this.datefrom,
        this.dateto,
        this.agent,
        this.guestId,
        this.note,
        this.crewcount,
        this.items,
        this.priceBase,
        this.discount,
        this.commission,
        this.priceFinal,
        this.priceClient,
        this.updateId,
        this.charter});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    charterId = json['charterId'];
    yachtId = json['yachtId'];
    datefrom = json['datefrom'];
    dateto = json['dateto'];
    agent = json['agent'];
    guestId = json['guestId'];
    note = json['note'];
    crewcount = json['crewcount'];
    items = json['items'];
    priceBase = json['priceBase'];
    discount = json['discount'];
    commission = json['commission'];
    priceFinal = json['priceFinal'];
    priceClient = json['priceClient'];
    updateId = json['updateId'];
    charter = json['charter'];
    checkInId = json['checkInId'];
    checkOutId = json['checkOutId'];
    cleaningId = json['cleaningId'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    cleaning = json['cleaning'];
    if (json['cleanings'] != null) {
      cleanings = <Cleaning>[];
      json['cleanings'].forEach((v) {
        cleanings!.add(Cleaning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['charterId'] = this.charterId;
    data['yachtId'] = this.yachtId;
    data['datefrom'] = this.datefrom;
    data['dateto'] = this.dateto;
    data['agent'] = this.agent;
    data['guestId'] = this.guestId;
    data['note'] = this.note;
    data['crewcount'] = this.crewcount;
    data['items'] = this.items;
    data['priceBase'] = this.priceBase;
    data['discount'] = this.discount;
    data['commission'] = this.commission;
    data['priceFinal'] = this.priceFinal;
    data['priceClient'] = this.priceClient;
    data['updateId'] = this.updateId;
    data['checkInId'] = this.checkInId;
    data['checkOutId'] = this.checkOutId;
    data['cleaningId'] = this.cleaningId;
    data['charter'] = this.charter;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['cleaning'] = this.cleaning;
    if (this.cleanings != null) {
      data['cleanings'] = this.cleanings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}