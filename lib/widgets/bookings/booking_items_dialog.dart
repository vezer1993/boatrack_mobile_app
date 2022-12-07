import 'package:boatrack_mobile_app/widgets/bookings/boooking_item_widget.dart';
import 'package:flutter/material.dart';
import '../../models/booking_item.dart';
import '../../resources/colors.dart';

class DialogBookingItems extends StatefulWidget {
  final List<BookingItem> items;
  const DialogBookingItems({Key? key, required this.items}) : super(key: key);

  @override
  State<DialogBookingItems> createState() => _DialogBookingItemsState();
}

class _DialogBookingItemsState extends State<DialogBookingItems> {
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
                for(int i = 0; i < widget.items.length; i++)
                  BookingItemWidget(item: widget.items[i], row: i)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
