import 'package:boatrack_mobile_app/pages/home.dart';
import 'package:boatrack_mobile_app/pages/login.dart';
import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/storage/prefferences.dart';
import 'package:boatrack_mobile_app/resources/strings/strings_prefferences.dart';
import 'package:boatrack_mobile_app/services/api/api_firebase.dart';
import 'package:boatrack_mobile_app/services/push_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Lato",
          backgroundColor: CustomColors().appBackgroundColor  ,
          brightness: Brightness.dark),
      home: const App(),
    );
  }
}

Future<bool> isLoggedIn() async{

  bool loggedIn = false;
  String? info = await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.charter);

  if(info != null){
    loggedIn = true;
  }

  return loggedIn;
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState(){
    super.initState();
    PushNotifications.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
    builder: (context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.data == true){
          return const HomePage();
        }else{
          return Loginpage();
        }
    }
    );
  }
}

