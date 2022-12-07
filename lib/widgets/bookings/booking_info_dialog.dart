import 'package:boatrack_mobile_app/widgets/bookings/booking_items_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/booking.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';

class DialogBookingInfo extends StatefulWidget {
  final Booking booking;
  const DialogBookingInfo({Key? key, required this.booking}) : super(key: key);

  @override
  State<DialogBookingInfo> createState() => _DialogBookingInfoState();
}

class _DialogBookingInfoState extends State<DialogBookingInfo> {


  @override
  Widget build(BuildContext context) {
    double width =  (MediaQuery.of(context).size.width);
    double height =  (MediaQuery.of(context).size.height);
    double containerWidth = width * 0.8;
    double containerHeight = height * 0.7;

    return Dialog(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        color: CustomColors().appBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: InkWell(onTap: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogBookingItems(
                            items: widget.booking.getPayableAtBaseBookingItems(),
                          );
                        });
                  }, child: Container(
                      width: width * 0.6,
                      height: height * 0.1,
                      decoration: CustomDecorations.buttonBoxDecoration(),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20,),
                              Text(
                                "BOOKING INFO",
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

                  }, child: Container(
                      width: width * 0.6,
                      height: height * 0.1,
                      decoration: CustomDecorations.buttonBoxDecoration(),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20,),
                              Text(
                                "GUESTS ARRIVED",
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

                  }, child: Container(
                      width: width * 0.6,
                      height: height * 0.1,
                      decoration: CustomDecorations.buttonBoxDecoration(),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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

                  }, child: Container(
                      width: width * 0.6,
                      height: height * 0.1,
                      decoration: CustomDecorations.buttonBoxDecoration(),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20,),
                              Text(
                                "CLEANING",
                                style: CustomTextStyles.buttonText(context),
                              ),
                            ],
                          )
                      )
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
