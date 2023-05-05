import 'dart:typed_data';
import 'dart:ui';

import 'package:boatrack_mobile_app/services/api/azure.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'check_segment.dart';
import 'issues.dart';
import 'yacht.dart';

class CheckInOut {
  int? id;
  String? name;
  bool? isSkipper;
  String? email;
  String? signature;
  bool? issues;
  String? document;
  int? yachtID;
  String? timestampData;
  List<String>? bookings;
  List<IssueItem>? issuesNavigation;

  List<CheckSegment>? segments;
  Yacht? yacht;


  CheckInOut(
      {this.id,
        this.name,
        this.isSkipper,
        this.email,
        this.signature,
        this.issues,
        this.document,
        this.bookings,
        this.issuesNavigation});

  CheckInOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSkipper = json['isSkipper'];
    email = json['email'];
    signature = json['signature'];
    issues = json['issues'];
    document = json['document'];
    bookings = json['bookings'].cast<String>();
    if (json['issuesNavigation'] != null) {
      issuesNavigation = <IssueItem>[];
      json['issuesNavigation'].forEach((v) {
        issuesNavigation!.add(IssueItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['yachtID'] = this.yachtID;
    data['timestampData'] = this.timestampData;
    data['issues'] = this.issues;
    data['document'] = this.document;
    data['isSkipper'] = this.isSkipper;
    data['email'] = this.email;
    data['signature'] = this.signature;

    return data;
  }

   Future generateDocument(BuildContext context, bool check_in) async{

    Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    String name = "CHECK IN";

    if(!check_in){
      name = "CHECK OUT";
    }

    sheet.name = name;

    //title style
    Style titleStyle = workbook.styles.add('style');
    titleStyle.fontSize = 15;
    titleStyle.bold = true;
    titleStyle.vAlign = VAlignType.center;
    titleStyle.hAlign = HAlignType.center;

    //title cells
    Range titleRange = sheet.getRangeByName('A1:H3');
    titleRange.merge();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.mm.yyyy').format(now);
    titleRange.setText("${yacht!.name} $name - $formattedDate");
    titleRange.cellStyle = titleStyle;


    //Correct
    Style correctStyle = workbook.styles.add('style1');
    correctStyle.fontSize = 13;
    correctStyle.bold = true;
    correctStyle.vAlign = VAlignType.center;
    correctStyle.hAlign = HAlignType.center;
    correctStyle.borders.bottom.lineStyle = LineStyle.thin;
    correctStyle.backColorRgb = const Color.fromARGB(255, 201, 218, 248);

    //Correct cells
    Range correctRange = sheet.getRangeByName('J1:K3');
    correctRange.merge();
    correctRange.setText("CORRECT");
    correctRange.cellStyle = correctStyle;

    //Incorrect
    Style incorrectStyle = workbook.styles.add('style2');
    incorrectStyle.fontSize = 13;
    incorrectStyle.bold = true;
    incorrectStyle.vAlign = VAlignType.center;
    incorrectStyle.hAlign = HAlignType.center;
    incorrectStyle.borders.bottom.lineStyle = LineStyle.thin;
    incorrectStyle.backColorRgb = const Color.fromARGB(255, 252, 229, 205);

    //Correct cells
    Range incorrectRange = sheet.getRangeByName('L1:M3');
    incorrectRange.merge();
    incorrectRange.setText("INCORRECT");
    incorrectRange.cellStyle = incorrectStyle;

    //check list
    //first row style
    Style firstRowStyle = workbook.styles.add('style3');
    firstRowStyle.fontSize = 13;
    firstRowStyle.bold = true;
    firstRowStyle.vAlign = VAlignType.center;
    firstRowStyle.hAlign = HAlignType.left;
    firstRowStyle.backColorRgb = const Color.fromARGB(255, 255, 242, 204);
    firstRowStyle.borders.all.lineStyle = LineStyle.thin;

    //second row style
    Style secondRowStyle = workbook.styles.add('style4');
    secondRowStyle.fontSize = 13;
    secondRowStyle.bold = true;
    secondRowStyle.vAlign = VAlignType.center;
    secondRowStyle.hAlign = HAlignType.left;
    secondRowStyle.borders.all.lineStyle = LineStyle.thin;

    int row = 5;

    int lastSheet = 0;


    for (int i = 0; i < segments!.length; i++,row++){
      Range rowRange = sheet.getRangeByName('A$row:I$row');
      rowRange.merge();
      if(row % 2 != 0){
        rowRange.cellStyle = firstRowStyle;
      }else{
        rowRange.cellStyle = secondRowStyle;
      }

      rowRange.text = segments![i].name;

      Range correctCells = sheet.getRangeByName('J$row:K$row');
      correctCells.merge();
      correctCells.cellStyle = correctStyle;

      Range incorrectCells = sheet.getRangeByName('L$row:M$row');
      incorrectCells.merge();
      incorrectCells.cellStyle = incorrectStyle;

      if(segments![i].pass){
        correctCells.text = "X";
      }else{
        lastSheet++;
        incorrectCells.text = "X - issue$lastSheet";

        if(segments![i].issue != null){
          Worksheet issueSheet = workbook.worksheets.addWithName("issue$lastSheet");

          Range issueRange = issueSheet.getRangeByName("A1:M6");
          issueRange.merge();
          issueRange.text = segments![i].issue!.description.toString();
        }

      }
    }


    row = row + 2;
    Range rowRange = sheet.getRangeByName('A$row:I$row');
    rowRange.merge();
    if(check_in){
      rowRange.text = signature;
    }

    row = row + 2;
    rowRange = sheet.getRangeByName('A$row:I$row');
    rowRange.merge();
    rowRange.text = "SAILOR: $email";

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    Uint8List document = Uint8List.fromList(bytes);
    this.document = await uploadDocumentToAzure(context, "Check_in_out.xlsx", document);
  }
}