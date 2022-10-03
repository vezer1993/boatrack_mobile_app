import 'package:boatrack_mobile_app/models/yacht.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/widgets/helper/widget_report_issue.dart';
import 'package:boatrack_mobile_app/widgets/yachts/widget_check_procedure.dart';
import 'package:boatrack_mobile_app/widgets/yachts/widget_cleaning.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../helper/alert_dialog.dart';

class WidgetYacht extends StatefulWidget {
  final Yacht yacht;

  const WidgetYacht({Key? key, required this.yacht}) : super(key: key);

  @override
  State<WidgetYacht> createState() => _WidgetYachtState();
}

class _WidgetYachtState extends State<WidgetYacht> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors().appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: width,
              height: 0.13 * height,
              decoration: BoxDecoration(
                color: CustomColors().altBackgroundColor,
                boxShadow: [CustomDecorations.containerBoxShadow()]
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.2,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_backspace,
                          size: 40,
                          color: CustomColors().navigationIconColor,
                        )),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(right: width * 0.2, top: height * 0.01),
                      child: Center(
                        child: Text(
                          widget.yacht.name.toString(),
                          style: CustomTextStyles.headerText(context),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: InkWell(onTap: () {
              if(widget.yacht.checkModelId != null){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetCheckProcedure(yacht: widget.yacht, checkIn: true,)),
                );
              }else{
                ALERTS.showAlertDialog(context, "ERROR", "Please set check in/out model");
              }
            }, child: Container(
              width: width * 0.6,
              height: height * 0.1,
              decoration: CustomDecorations.buttonBoxDecoration(),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_available),
                    const SizedBox(width: 20,),
                    Text(
                      "CHECK IN",
                      style: CustomTextStyles.buttonText(context),
                    ),
                  ],
                )
              )
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WidgetCheckProcedure(yacht: widget.yacht, checkIn: false,)),
              );
            }, child: Container(
                width: width * 0.6,
                height: height * 0.1,
                decoration: CustomDecorations.buttonBoxDecoration(),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy),
                        const SizedBox(width: 20,),
                        Text(
                          "CHECK OUT",
                          style: CustomTextStyles.buttonText(context),
                        ),
                      ],
                    )
                )
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WidgetCleaning(yacht: widget.yacht)),
              );
            }, child: Container(
                width: width * 0.6,
                height: height * 0.1,
                decoration: CustomDecorations.buttonBoxDecoration(),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cleaning_services),
                        const SizedBox(width: 20,),
                        Text(
                          "CLEANING",
                          style: CustomTextStyles.buttonText(context),
                        ),
                      ],
                    )
                )
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WidgetIssueReport(
                        yachtID: widget.yacht.id!)),
              );
            }, child: Container(
                width: width * 0.6,
                height: height * 0.1,
                decoration: CustomDecorations.buttonBoxDecoration(),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline),
                        const SizedBox(width: 20,),
                        Text(
                          "REPORT ISSUE",
                          style: CustomTextStyles.buttonText(context),
                        ),
                      ],
                    )
                )
            )),
          )
        ],
      ),
    );
  }
}
