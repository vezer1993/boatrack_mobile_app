import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/widgets/bookings/booking_info_dialog.dart';
import 'package:boatrack_mobile_app/widgets/bookings/booking_preparation_widget.dart';
import 'package:flutter/material.dart';

import '../../helper/calendar.dart';
import '../../helper/conversion.dart';
import '../../models/booking.dart';
import '../../models/booking_item.dart';
import '../../models/yacht.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/api/api_yachts.dart';

class WidgetBookings extends StatefulWidget {
  const WidgetBookings({Key? key}) : super(key: key);

  @override
  State<WidgetBookings> createState() => _WidgetBookingsState();
}

class _WidgetBookingsState extends State<WidgetBookings> {
  String nextSaturday = CalendarCalculations()
      .getNextSaturdayForDate(DateTime.now())
      .toString()
      .substring(0, 10);
  late List<Yacht> futureData;
  bool dataLoaded = false;

  Future getFutureData() async {
    if (!dataLoaded) {
      futureData = await getYachtList(true, context);
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);

    double containerWidth = width * 0.9;

    return SizedBox(
      width: containerWidth,
      child: FutureBuilder(
          future: getFutureData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("NO CONNECTION");
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              /// GET ITEMS BOOKINGS
              List<Booking> bookings = [];
              for (Yacht y in futureData) {
                Booking? temp = y.getBookingForGivenDate(nextSaturday);
                if (temp != null) {
                  bookings.add(temp);
                }
              }

              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: ((context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      itemBuilder: (BuildContext context, int index) {
                        ///CALCULATE THIS BOOKING AND WIDGETS
                        Booking? b = bookings[index];

                        String bFrom = "";
                        String bTo = "";

                        if (b != null) {
                          bFrom = Conversion.convertUtcTimeToStandardFormat(
                              b.datefrom.toString());
                          bTo = Conversion.convertUtcTimeToStandardFormat(
                              b.dateto.toString());
                        }

                        List<BookingItem> items =
                            b.getPayableAtBaseBookingItems();

                        bool priority = false;
                        for (BookingItem item in items) {
                          if (item.name.toString().contains("Priority")) {
                            priority = true;
                          }
                        }

                        return InkWell(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogBookingInfo(
                                    booking: b,
                                  );
                                });
                          },
                          child: Container(
                            decoration:
                                CustomDecorations.standardBoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: containerWidth,
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                bookings[index]
                                                    .yacht!
                                                    .name
                                                    .toString(),
                                                style: CustomTextStyles
                                                        .headerText(context)
                                                    ?.copyWith(
                                                        color: CustomColors()
                                                            .navigationTextColor),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Visibility(
                                            visible: priority,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.priority_high,
                                                  color: CustomColors()
                                                      .failBoxCheckMarkColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 1,
                                                ),
                                                Container(
                                                    decoration: CustomDecorations
                                                        .buttonFailBoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              3, 1, 3, 1),
                                                      child: Text(
                                                        "PRIORITY CHECK IN",
                                                        style: CustomTextStyles
                                                            .yachtStatus(
                                                                context,
                                                                CustomColors()
                                                                    .navigationTextColor),
                                                      ),
                                                    ))
                                              ],
                                            ))
                                      ],
                                    )),
                                SizedBox(
                                  width: containerWidth,
                                  height: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          bFrom + "  --->  " + bTo,
                                          style: CustomTextStyles.regularText(
                                                  context)
                                              ?.copyWith(
                                                  color: CustomColors()
                                                      .primaryColor),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                BookingPreparationWidget(
                                    booking: b,
                                    widgetWidth: containerWidth,
                                    yacht: b.yacht!),
                                const SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }
          }),
    );
  }
}
