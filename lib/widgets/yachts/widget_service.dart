import 'package:boatrack_mobile_app/models/yacht.dart';
import 'package:boatrack_mobile_app/widgets/helper/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../resources/colors.dart';
import '../../resources/storage/prefferences.dart';
import '../../resources/strings/strings_prefferences.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';

class WidgetService extends StatefulWidget {

  final Yacht yacht;
  const WidgetService({Key? key, required this.yacht}) : super(key: key);

  @override
  State<WidgetService> createState() => _WidgetServiceState();
}

class _WidgetServiceState extends State<WidgetService> {

  String timeStarted = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
              child: Container(
                width: width,
                height: 0.13 * height,
                decoration: BoxDecoration(
                    color: CustomColors().altBackgroundColor,
                    boxShadow: [CustomDecorations.containerBoxShadow()]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${widget.yacht.name} SERVICE",
                      style: CustomTextStyles.headerText(context),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: hasServiceStarted(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.data == false){
                  return Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: InkWell(onTap: () async {
                      timeStarted = DateTime.now().toIso8601String();
                      await LOCAL_STORAGE.saveValue(STRINGS_PREFFERENCES.service, timeStarted);
                      setState(() {
                        print("HELLO");
                      });
                    }, child: Container(
                        width: width * 0.6,
                        height: height * 0.1,
                        decoration: CustomDecorations.buttonBoxDecoration(),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.start),
                                const SizedBox(width: 20,),
                                Text(
                                  "START SERVICE",
                                  style: CustomTextStyles.buttonText(context),
                                ),
                              ],
                            )
                        )
                    )),
                  );
                }else{
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: InkWell(onTap: () {
                          finishService();
                        }, child: Container(
                            width: width * 0.6,
                            height: height * 0.1,
                            decoration: CustomDecorations.buttonBoxDecoration(),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.stop_outlined),
                                    const SizedBox(width: 20,),
                                    Text(
                                      "FINISH SERVICE",
                                      style: CustomTextStyles.buttonText(context),
                                    ),
                                  ],
                                )
                            )
                        )),
                      ),
                    ],
                  );
                }

              },
            )
          ]),
        ));
  }

  Future hasServiceStarted() async {
    if(await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.service) != null){
      timeStarted =  (await LOCAL_STORAGE.getValue(STRINGS_PREFFERENCES.service))!;
      return true;
    }else{
      return false;
    }
  }

  void finishService() async {

    await LOCAL_STORAGE.removeValue(STRINGS_PREFFERENCES.service);

    //bool success = await postCleaning(c, c.yachtId!, context);

    if(true){
      Navigator.pop(context);
    }
  }
}
