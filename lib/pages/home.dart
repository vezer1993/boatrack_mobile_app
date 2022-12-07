import 'package:boatrack_mobile_app/widgets/bookings/widget_bookings.dart';
import 'package:boatrack_mobile_app/widgets/settings/widget_settings.dart';
import 'package:boatrack_mobile_app/widgets/yachts/widget_yachts.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  List<Widget> widgets = [const WidgetYachts(), const WidgetBookings(), const WidgetSettings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().appBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_boat_rounded),
            label: 'Yachts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors().primaryColor,
        backgroundColor: CustomColors().altBackgroundColor,
        onTap: _onItemTapped,
      ),
      body: LoaderOverlay(
        child: Center(
          child: widgets[_selectedIndex],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
