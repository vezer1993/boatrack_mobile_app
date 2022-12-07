import 'issues_images.dart';

class IssueItem {
  int? id;
  String? name;
  String? description;
  int? checkinId;
  int? checkoutId;
  bool? hasPictures;
  int? cleaningId;
  String? timestamp;
  String? resolutionNote;
  bool? resolved;
  String? document;
  String? checkin;
  String? checkout;
  String? cleaning;
  int? accountID;
  int? yachtId;
  List<IssueImages>? issueImages;

  IssueItem(
      {this.id,
        this.name,
        this.description,
        this.checkinId,
        this.checkoutId,
        this.hasPictures,
        this.cleaningId,
        this.checkin,
        this.checkout,
        this.cleaning,
        this.accountID,
        this.issueImages});

  IssueItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    checkinId = json['checkinId'];
    checkoutId = json['checkoutId'];
    hasPictures = json['hasPictures'];
    cleaningId = json['cleaningId'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    cleaning = json['cleaning'];
    if (json['issueImages'] != null) {
      issueImages = <IssueImages>[];
      json['issueImages'].forEach((v) {
        issueImages!.add(new IssueImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['yachtID'] = this.yachtId;
    data['hasPictures'] = this.hasPictures;
    data['accountId'] = this.accountID;
    return data;
  }
}
