import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/services/api/api_yachts.dart';
import 'package:boatrack_mobile_app/services/services.dart';
import 'package:boatrack_mobile_app/widgets/yachts/widget_yacht.dart';
import 'package:flutter/material.dart';

import '../../helper/calendar.dart';
import '../../helper/conversion.dart';
import '../../models/account.dart';
import '../../models/booking.dart';
import '../../models/yacht.dart';
import '../../resources/styles/text_styles.dart';

class WidgetYachts extends StatefulWidget {
  const WidgetYachts({Key? key}) : super(key: key);

  @override
  State<WidgetYachts> createState() => _WidgetYachtsState();
}

class _WidgetYachtsState extends State<WidgetYachts> {
  List<Yacht> yachts = [];
  late Accounts acc;

  Future loadYachts() async {
    yachts = await getYachtList(false, context);
    acc = await getAccount();
    return yachts;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: loadYachts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: yachts.length,
                itemBuilder: (BuildContext context, int index) {
                  double containerWidth = width * 0.9;
                  double contianerHeight = height / 7;

                  String thisWeekAvailability = yachts[index]
                      .availabilityForWeek(CalendarCalculations()
                          .getWeekNumberForDate(DateTime.now()));

                  Text availableText =
                      createTextAccordingToAvailability(thisWeekAvailability);

                  String description = "";

                  if (thisWeekAvailability.toString() == "1") {
                    Booking? b = yachts[index].getBookingForDate();

                    description =
                        "Returns: ${Conversion.convertUtcTimeToStandardFormat(b!.dateto.toString())}";
                  }

                  return Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WidgetYacht(yacht: yachts[index], role: acc.role.toString(),)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                          width: containerWidth,
                          height: contianerHeight,
                          decoration: BoxDecoration(
                              color: CustomColors().altBackgroundColor,
                              boxShadow: [
                                CustomDecorations.containerBoxShadow()
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: contianerHeight,
                                  width: contianerHeight,
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 1,
                                    child: Image.network(
                                      yachts[index].image.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        yachts[index].name.toString(),
                                        style:
                                            CustomTextStyles.headerText(context),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      availableText,
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        description,
                                        style:
                                            CustomTextStyles.regularText(context),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }

  Text createTextAccordingToAvailability(String availability) {
    if (availability == "1") {
      return Text(
        "BOOKED",
        style: CustomTextStyles.yachtStatus(
            context, CustomColors().calendarOutColor),
      );
    } else if (availability == "0") {
      return Text(
        "HOME",
        style: CustomTextStyles.yachtStatus(
            context, CustomColors().calendarHomeColor),
      );
    } else {
      return Text(
        "OPTION",
        style: CustomTextStyles.yachtStatus(
            context, CustomColors().calendarOptionColor),
      );
    }
  }
}
