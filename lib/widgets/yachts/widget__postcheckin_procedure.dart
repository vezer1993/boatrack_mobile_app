import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../models/pre_post_prep_segment.dart';
import '../../models/prep_object.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/api/api_check_in_out.dart';
import '../../services/services.dart';
import '../helper/global_snackbar.dart';

class YachtPostCheckInProcedure extends StatefulWidget {
  final Yacht yacht;

  const YachtPostCheckInProcedure({Key? key, required this.yacht}) : super(key: key);

  @override
  State<YachtPostCheckInProcedure> createState() => _YachtPostCheckInProcedureState();
}

class _YachtPostCheckInProcedureState extends State<YachtPostCheckInProcedure> {
  double width = 0;
  double height = 0;
  List<PrePostSegment> segments = getPostSegments();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;

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
          child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: segments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 11,
                            ),
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
                                    child: Text(
                                      segments[index].name.toString(),
                                      style: CustomTextStyles.titleText(context)!
                                          .copyWith(fontSize: 17),
                                    ),
                                  ),
                                  const Spacer(),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return const Icon(
                                            Icons.sentiment_very_dissatisfied,
                                            color: Colors.red,
                                          );
                                        case 1:
                                          return const Icon(
                                            Icons.sentiment_dissatisfied,
                                            color: Colors.redAccent,
                                          );
                                        case 2:
                                          return const Icon(
                                            Icons.sentiment_neutral,
                                            color: Colors.amber,
                                          );
                                        case 3:
                                          return const Icon(
                                            Icons.sentiment_satisfied,
                                            color: Colors.lightGreen,
                                          );
                                        case 4:
                                          return const Icon(
                                            Icons.sentiment_very_satisfied,
                                            color: Colors.green,
                                          );
                                        default:
                                          return const Icon(
                                            Icons.sentiment_very_satisfied,
                                            color: Colors.green,
                                          );
                                      }
                                    },
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        segments[index].rating = rating.toString();

                                        if (rating < 4) {
                                          segments[index].expand = true;
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Visibility(
                              visible: segments[index].expand,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Center(
                                      child: SizedBox(
                                        width: width * 0.7,
                                        child: TextFormField(
                                          controller:
                                          segments[index].descriptionController,
                                          autocorrect: false,
                                          minLines: 5,
                                          maxLines: 12,
                                          cursorColor: CustomColors().primaryColor,
                                          style:
                                          CustomTextStyles.regularText(context),
                                          decoration:
                                          CustomDecorations.inputDecoration(),
                                          onChanged: (value) {
                                            segments[index].description = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Container(width: double.infinity,
                              height: 1,
                              color: CustomColors().unSelectedItemColor,)
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: InkWell(onTap: notCompleted() ? null : () {
                      setState(() {
                        context.loaderOverlay.show();
                        sendData();
                      });
                    }, child: Container(
                        width: width * 0.6,
                        height: height * 0.08,
                        decoration: notCompleted() ? CustomDecorations
                            .buttonDisabledBoxDecoration() : CustomDecorations
                            .buttonBoxDecoration(),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "FINISH",
                                  style: CustomTextStyles.buttonText(context),
                                ),
                              ],
                            )
                        )
                    )),
                  ),
                ],
              )
          ),
        ));
  }

  void sendData() async {

    String? json = jsonEncode(segments);
    json = json?.replaceAll("\"", "¸");
    PrepObject prep = PrepObject();

    prep.document = json;
    prep.timestampData = DateTime.now().toIso8601String();
    prep.yachtId = widget.yacht.id;
    prep.postcheckin = true;
    prep.accountId = (await getAccount()).id;

    bool success = await postPrepModel(context, prep);

    if (success) {
      GlobalSnackBar.show(
          context, "Completed post checkin " + widget.yacht.name.toString());
    }
    Navigator.pop(context);
  }

  notCompleted() {
    for (PrePostSegment seg in segments) {
      if (seg.rating == null) {
        return true;
      }
    }
    return false;
  }
}
