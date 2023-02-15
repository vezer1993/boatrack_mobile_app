import 'package:boatrack_mobile_app/helper/conversion.dart';
import 'package:boatrack_mobile_app/models/employeeTask.dart';
import 'package:boatrack_mobile_app/models/notification_type.dart';
import 'package:boatrack_mobile_app/models/yacht.dart';
import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/services/api/api_yachts.dart';
import 'package:flutter/material.dart';
import '../../resources/styles/box_decorations.dart';
import '../helper/alert_dialog.dart';
import '../yachts/widget_check_procedure.dart';
import '../yachts/widget_cleaning.dart';

class TaskWidget extends StatefulWidget {
  final EmployeeTask task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double containerWidth = width * 0.9;

    return FutureBuilder(
        future: getYachtList(false, context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Yacht yacht = Yacht();

            for (Yacht y in snapshot.data) {
              if (y.id == widget.task.typeId) {
                yacht = y;
              }
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if(widget.task.taskType == NotificationEnum.checkin){
                    if(yacht.checkModelId != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WidgetCheckProcedure(yacht: yacht, checkIn: true,)),
                      );
                    }else{
                      ALERTS.showAlertDialog(context, "ERROR", "Please set check in/out model");
                    }
                  }else if(widget.task.taskType == NotificationEnum.checkout){
                    if(yacht.checkModelId != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WidgetCheckProcedure(yacht: yacht, checkIn: false,)),
                      );
                    }else{
                      ALERTS.showAlertDialog(context, "ERROR", "Please set check in/out model");
                    }
                  } else if (widget.task.taskType == NotificationEnum.cleaning){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WidgetCleaning(yacht: yacht)),
                    );
                  }
                },
                child: Container(
                  decoration: CustomDecorations.standardBoxDecoration(),
                  width: containerWidth,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Row(
                        children: [
                          Icon(Icons.directions_boat,
                              color: CustomColors().navigationTextColor),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                yacht.name.toString(),
                                style: CustomTextStyles.titleText(context),
                              ),
                              Text(Conversion.convertISOTimeToStandardFormatWithTime(widget.task.timeCreated.toString()), style: CustomTextStyles.descriptionText(context),)
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios, color: CustomColors().primaryColor,)
                        ],
                      )),
                ),
              ),
            );
          }
        });
  }
}
