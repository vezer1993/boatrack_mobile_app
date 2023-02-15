import 'package:boatrack_mobile_app/models/issues.dart';
import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/services/api/api_cleaning.dart';
import 'package:boatrack_mobile_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../models/cleaning.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../helper/global_snackbar.dart';
import '../helper/widget_report_issue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetCleaning extends StatefulWidget {
  const WidgetCleaning({Key? key, required this.yacht}) : super(key: key);

  final Yacht yacht;

  @override
  State<WidgetCleaning> createState() => _WidgetCleaningState();
}

class _WidgetCleaningState extends State<WidgetCleaning> {

  String timeStarted = "";
  bool hasIssues = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: CustomColors().appBackgroundColor,
        body: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitWave(
              color: CustomColors().primaryColor,
              size: 50.0,
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
              child: Container(
                width: width,
                height: 0.13 * height,
                decoration: BoxDecoration(
                    color: CustomColors().altBackgroundColor,
                    boxShadow: [CustomDecorations.containerBoxShadow()]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${widget.yacht.name} CLEANING",
                      style: CustomTextStyles.headerText(context),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: hasCleaningStarted(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.data == false){
                  return Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: InkWell(onTap: () async {
                      timeStarted = DateTime.now().toIso8601String();
                      await LOCAL_STORAGE.saveValue(STRINGS_PREFFERENCES.cleaning, timeStarted);
                      setState(() {

                      });
                    }, child: Container(
                        width: width * 0.6,
                        height: height * 0.1,
                        decoration: CustomDecorations.buttonBoxDecoration(),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.start),
                                const SizedBox(width: 20,),
                                Text(
                                  "START CLEANING",
                                  style: CustomTextStyles.buttonText(context),
                                ),
                              ],
                            )
                        )
                    )),
                  );
                }else{
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: InkWell(onTap: () {
                          finishCleaning();
                        }, child: Container(
                            width: width * 0.6,
                            height: height * 0.1,
                            decoration: CustomDecorations.buttonBoxDecoration(),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.stop_outlined),
                                    const SizedBox(width: 20,),
                                    Text(
                                      "FINISH CLEANING",
                                      style: CustomTextStyles.buttonText(context),
                                    ),
                                  ],
                                )
                            )
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: InkWell(onTap: () async {
                          IssueItem issue = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetIssueReport(
                                    yachtID: widget.yacht.id!)),
                          );

                          if(issue != null){
                            hasIssues = true;
                          }
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
                  );
                }

              },
            )
          ]),
        ));
  }

  Future hasCleaningStarted() async {
    if(await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.cleaning) != null){
      timeStarted =  (await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.cleaning))!;
      return true;
    }else{
      return false;
    }
  }

  void finishCleaning() async {
    Cleaning c = Cleaning();
    c.timeStarted = timeStarted;
    c.timeFinished = DateTime.now().toIso8601String();
    c.accountId = (await getAccount()).id;
    c.yachtId = widget.yacht.id;
    c.hasIssues = hasIssues;

    await LOCAL_STORAGE.removeValue(STRINGS_PREFFERENCES.cleaning);

    bool success = await postCleaning(c, c.yachtId!, context);

    if(success){
      GlobalSnackBar.show(context, "Completed cleaning for " + widget.yacht.name.toString());
      Navigator.pop(context);
    }
  }
}
