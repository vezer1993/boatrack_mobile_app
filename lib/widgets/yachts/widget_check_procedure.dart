import 'package:boatrack_mobile_app/models/check_in_out.dart';
import 'package:boatrack_mobile_app/models/check_model.dart';
import 'package:boatrack_mobile_app/models/check_segment.dart';
import 'package:boatrack_mobile_app/models/issues.dart';
import 'package:boatrack_mobile_app/models/issues_images.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/widgets/helper/widget_report_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../services/api/api_check_in_out.dart';
import '../helper/widget_image_gallery.dart';

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

  List<CheckSegment> segmentsDeck = [];
  List<CheckSegment> segmentsSaloonCabin = [];
  List<CheckSegment> segmentsLocker = [];
  List<CheckSegment> segmentsKitchen = [];
  List<CheckSegment> segmentsEngine = [];
  List<CheckSegment> segmentsVarious = [];
  int _page = 0;

  double width = 0;
  double height = 0;

  bool isChecked = false;

  IssueItem? issue;

  bool procedureHasIssues = false;
  bool modelLoaded = false;

  Future getModel() async {
    if (!modelLoaded) {
      CheckModel model =
          await getCheckModel(widget.yacht.checkModelId.toString(), context);
      segments = model.getModel();
    }
    return segments;
  }

  bool answerSelected = false;
  bool fail = false;
  bool pass = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
          child: FutureBuilder(
              future: getModel(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("NO CONNECTION");
                } else if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<String> images = [];
                  if (segments[_page].images.isNotEmpty) {
                    images = segments[_page]
                        .images
                        .map((e) => e.toString())
                        .toList();
                  }

                  if(segmentsDeck.isEmpty){
                    createSegmentLists();
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 45, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "DECK",
                                    style: CustomTextStyles.headerText(context),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, right: 5),
                                  child: Text(
                                    "CHECK ALL",
                                    style: CustomTextStyles.titleText(context),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.6,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.all(
                                        CustomColors().primaryColor),
                                    value: isChecked,
                                    shape: CircleBorder(),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        for(CheckSegment seg in segmentsDeck){
                                          seg.pass = value!;
                                        }
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: CustomColors().primaryColor,
                          ),
                          getListview(segmentsDeck),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ));
  }

  Widget getListview(List<CheckSegment> segments) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: segments.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 11,),
              InkWell(
                onTap: () {
                  setState(() {
                    segments[index].expand = !segments[index].expand;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7, left: 10),
                      child: Text(segments[index].name.toString(), style: CustomTextStyles.titleText(context)!.copyWith(fontSize: 22),),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 1.6,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(
                            Colors.red),
                        value: segments[index].pass,
                        onChanged: (bool? value) {
                          setState(() {
                            segments[index].pass = value!;
                          });
                        },
                      ),
                    ),
                    Transform.scale(
                      scale: 1.6,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(
                            Colors.green),
                        value: segments[index].pass,
                        onChanged: (bool? value) {
                          setState(() {
                            segments[index].pass = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 11,),
              Visibility(
                visible: segments[index].expand,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text(segments[index].description.toString()),),
                    SizedBox(height: 5,),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: InkWell(onTap: () async {
                        IssueItem issue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WidgetIssueReport(
                                  yachtID: widget.yacht.id!)),
                        );
                        segments[index].issue = issue;
                      }, child: Container(
                          width: width * 0.55,
                          height: height * 0.07,
                          decoration: CustomDecorations.buttonBoxDecoration(),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error_outline),
                                  const SizedBox(width: 20,),
                                  Text(
                                    "REPORT ISSUE",
                                    style: CustomTextStyles.buttonText(context),
                                  ),
                                ],
                              )
                          )
                      )),
                    ),)
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: CustomColors().unSelectedItemColor,
              ),
            ],
          );
        });
  }

  createSegmentLists(){
    segmentsDeck = [];
    segmentsSaloonCabin = [];
    segmentsLocker = [];
    segmentsKitchen = [];
    segmentsEngine = [];
    segmentsVarious = [];

    for (CheckSegment tempSeg in segments) {
      if (tempSeg.parentGroup == "DECK") {
        segmentsDeck.add(tempSeg);
      } else if (tempSeg.parentGroup == "SALOON + CABINS") {
        segmentsSaloonCabin.add(tempSeg);
      } else if (tempSeg.parentGroup == "LOCKERS") {
        segmentsLocker.add(tempSeg);
      } else if (tempSeg.parentGroup == "KITCHEN") {
        segmentsKitchen.add(tempSeg);
      } else if (tempSeg.parentGroup == "ENGINE + EL. INSTAL.") {
        segmentsEngine.add(tempSeg);
      } else if (tempSeg.parentGroup == "VARIOUS") {
        segmentsVarious.add(tempSeg);
      }
    }
  }

  void sendData() async {
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
