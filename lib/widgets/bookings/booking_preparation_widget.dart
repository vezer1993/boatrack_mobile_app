import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/booking.dart';
import '../../models/booking_preparation.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/api/api_booking.dart';

class BookingPreparationWidget extends StatefulWidget {
  final Booking booking;
  final double widgetWidth;
  final Yacht yacht;
  const BookingPreparationWidget({Key? key, required this.booking, required this.widgetWidth, required this.yacht}) : super(key: key);

  @override
  State<BookingPreparationWidget> createState() => _BookingPreparationWidgetState();
}

class _BookingPreparationWidgetState extends State<BookingPreparationWidget> {

  late BookingPreparation futureData;
  bool dataLoaded = false;

  Future getBookingPrep() async {
    if (!dataLoaded) {
      futureData = await getBookingPreparationStatus(widget.booking.id.toString(), context);
    }
    return futureData;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBookingPrep(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {

            Widget checkIn = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget checkOut = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget cleaning = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget guestsArrived = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget prep = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );

            if(futureData.checkIn != null){
              checkIn = FaIcon(
                FontAwesomeIcons.checkDouble,
                size: 15,
                color: CustomColors().successBoxCheckMarkColor,
              );
            }

            if(futureData.checkOut != null){
              checkOut = FaIcon(
                FontAwesomeIcons.checkDouble,
                size: 15,
                color: CustomColors().successBoxCheckMarkColor,
              );
            }

            if(futureData.cleaning != null){
              cleaning = FaIcon(
                FontAwesomeIcons.checkDouble,
                size: 15,
                color: CustomColors().successBoxCheckMarkColor,
              );
            }

            if(futureData.guestsArrived != null){
              if(futureData.guestsArrived!){
                guestsArrived = FaIcon(
                  FontAwesomeIcons.checkDouble,
                  size: 13,
                  color: CustomColors().successBoxCheckMarkColor,
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK OUT: ", style: CustomTextStyles.regularText(context),), checkOut],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CLEANING: ", style: CustomTextStyles.regularText(context),), cleaning],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("PREP: ", style: CustomTextStyles.regularText(context),), prep],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("GUESTS ARRIVED: ", style: CustomTextStyles.regularText(context),), guestsArrived],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK IN: ", style: CustomTextStyles.regularText(context),), checkIn],),),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CREW COUNT: ${widget.booking.crewcount}", style: CustomTextStyles.regularText(context),),],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("NOTE:     ${widget.booking.note}", style: CustomTextStyles.regularText(context),),],))
                ],
              ),
            );
          }
        });
  }
}