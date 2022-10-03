import 'package:boatrack_mobile_app/models/check_in_out.dart';
import 'package:boatrack_mobile_app/models/check_model.dart';
import 'package:boatrack_mobile_app/models/check_segment.dart';
import 'package:boatrack_mobile_app/models/issues.dart';
import 'package:boatrack_mobile_app/models/issues_images.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/widgets/helper/widget_report_issue.dart';
import 'package:flutter/material.dart';

import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../services/api/api_check_in_out.dart';

class WidgetCheckProcedure extends StatefulWidget {
  final bool checkIn;
  final Yacht yacht;

  const WidgetCheckProcedure(
      {Key? key, required this.checkIn, required this.yacht})
      : super(key: key);

  @override
  State<WidgetCheckProcedure> createState() => _WidgetCheckProcedureState();
}

class _WidgetCheckProcedureState extends State<WidgetCheckProcedure> {
  List<CheckSegment> segments = [];
  int _page = 0;

  IssuesNavigation? issue;

  bool procedureHasIssues = false;
  bool modelLoaded = false;

  Future getModel() async {
    if (!modelLoaded) {
      CheckModel model =
          await getCheckModel(widget.yacht.checkModelId.toString());
      segments = model.getModel();
    }
    return segments;
  }

  bool answerSelected = false;
  bool fail = false;
  bool pass = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors().appBackgroundColor,
      body: FutureBuilder(
          future: getModel(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("NO CONNECTION");
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: height * 0.65,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                segments[_page].name.toString(),
                                style: CustomTextStyles.headerText(context),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              segments[_page].description.toString(),
                              style: CustomTextStyles.regularText(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: fail,
                            child: InkWell(
                              onTap: () {
                                setState(() async {
                                  issue = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WidgetIssueReport(
                                            yachtID: widget.yacht.id!)),
                                  );

                                  if(issue != null){
                                    procedureHasIssues = true;
                                    segments[_page].issue = issue;
                                  }
                                });
                              },
                              child: Container(
                                  width: width * 0.5,
                                  height: height * 0.08,
                                  decoration: CustomDecorations
                                      .buttonFailBoxDecoration(),
                                  child: Center(
                                    child: Text(
                                      "REPORT ISSUE",
                                      style:
                                          CustomTextStyles.buttonText(context),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    fail = true;
                                    pass = false;
                                    answerSelected = true;
                                  });
                                },
                                child: Container(
                                    width: width * 0.35,
                                    height: height * 0.08,
                                    decoration: fail
                                        ? CustomDecorations
                                            .buttonFailBoxDecoration()
                                        : CustomDecorations
                                            .buttonDisabledBoxDecoration(),
                                    child: Center(
                                      child: Text(
                                        "FAIL",
                                        style: CustomTextStyles.buttonText(
                                            context),
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    fail = false;
                                    pass = true;
                                    answerSelected = true;
                                  });
                                },
                                child: Container(
                                    width: width * 0.35,
                                    height: height * 0.08,
                                    decoration: pass
                                        ? CustomDecorations
                                            .buttonPassBoxDecoration()
                                        : CustomDecorations
                                            .buttonDisabledBoxDecoration(),
                                    child: Center(
                                      child: Text(
                                        "PASS",
                                        style: CustomTextStyles.buttonText(
                                            context),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (answerSelected) {
                                  if (fail) {
                                    segments[_page].pass = false;
                                  } else {
                                    segments[_page].pass = true;
                                  }

                                  fail = false;
                                  pass = false;
                                  answerSelected = false;
                                  issue = null;


                                  if (_page < (segments.length - 1)) {
                                    setState(() {
                                      _page++;
                                    });
                                  }else{
                                    sendData();
                                  }
                                }
                              });
                            },
                            child: Container(
                                width: width * 0.6,
                                height: height * 0.08,
                                decoration: answerSelected
                                    ? CustomDecorations.buttonBoxDecoration()
                                    : CustomDecorations
                                        .buttonDisabledBoxDecoration(),
                                child: Center(
                                  child: Text(
                                    segments.length == (_page + 1) ? "FINISH" : "CONTINUE",
                                    style: CustomTextStyles.buttonText(context),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  void sendData() async{
    CheckInOut check = CheckInOut();
    check.segments = segments;
    check.timestampData = DateTime.now().toIso8601String();
    check.yacht = widget.yacht;
    check.yachtID = widget.yacht.id;
    check.issues = procedureHasIssues;
    check.name = "CHECK IN";

    await postCheckModel(context, check, widget.checkIn);
    Navigator.pop(context);
  }
}
