import 'package:boatrack_mobile_app/models/employeeTask.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/services/api/api_account.dart';
import 'package:boatrack_mobile_app/widgets/bookings/boooking_item_widget.dart';
import 'package:flutter/material.dart';

class WidgetSettings extends StatefulWidget {
  const WidgetSettings({Key? key}) : super(key: key);

  @override
  State<WidgetSettings> createState() => _WidgetSettingsState();
}

class _WidgetSettingsState extends State<WidgetSettings> {
  late List<EmployeeTask> futureData;
  bool dataLoaded = false;

  Future getFutureData() async {
    if (!dataLoaded) {
      futureData = await getTaskList(context);
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
                return ListView.builder(
                  itemCount: futureData.length,
                  itemBuilder: (context, index) {
                    index--;

                    if (index == -1) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Center(child: Text("TASK LIST", style: CustomTextStyles.headerText(context),),),
                      );
                      index++;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          decoration: CustomDecorations.standardBoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                futureData[index].taskName.toString(),
                                style: CustomTextStyles.regularText(context),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}
