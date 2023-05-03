import 'package:boatrack_mobile_app/models/employeeTask.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/services/api/api_account.dart';
import 'package:boatrack_mobile_app/widgets/settings/widget_task_group.dart';
import 'package:flutter/material.dart';

import '../../models/notification_type.dart';

class WidgetSettings extends StatefulWidget {
  const WidgetSettings({Key? key}) : super(key: key);

  @override
  State<WidgetSettings> createState() => _WidgetSettingsState();
}

class _WidgetSettingsState extends State<WidgetSettings> {
  late List<EmployeeTask> futureData;
  bool dataLoaded = false;

  List<EmployeeTask> cleaningTasks = [];
  List<EmployeeTask> checkinTasks = [];
  List<EmployeeTask> checkoutTasks = [];
  List<EmployeeTask> preCheckinTasks = [];
  List<EmployeeTask> postCheckoutTasks = [];
  List<EmployeeTask> serviceTasks = [];


  Future getFutureData() async {
    if (!dataLoaded) {
      futureData = await getTaskList(context);
      for(EmployeeTask task in futureData){
        if(task.taskType == NotificationEnum.checkin){
          checkinTasks.add(task);
        } else if(task.taskType == NotificationEnum.checkout){
          checkoutTasks.add(task);
        } else if(task.taskType == NotificationEnum.cleaning){
          cleaningTasks.add(task);
        } else if(task.taskType == NotificationEnum.service){
          serviceTasks.add(task);
        } else if(task.taskType == NotificationEnum.preCheckin){
          preCheckinTasks.add(task);
        } else if(task.taskType == NotificationEnum.postCheckout){
          postCheckoutTasks.add(task);
        }
      }
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

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Center(child: Text("TASK LIST", style: CustomTextStyles.headerText(context),),),
                    Visibility(visible: checkinTasks.isNotEmpty, child: TaskGroup(tasks:checkinTasks, title: "CHECK INs", icon: Icons.double_arrow_outlined, )),
                    Visibility(visible: checkoutTasks.isNotEmpty, child: TaskGroup(tasks:checkoutTasks, title: "CHECK OUTs", icon: Icons.subdirectory_arrow_left_outlined,)),
                    Visibility(visible: cleaningTasks.isNotEmpty, child: TaskGroup(tasks:cleaningTasks, title: "CLEANING", icon: Icons.cleaning_services,)),
                    Visibility(visible: preCheckinTasks.isNotEmpty, child: TaskGroup(tasks:preCheckinTasks, title: "PRE CHECK IN PREPs", icon: Icons.keyboard_double_arrow_down_outlined, )),
                    Visibility(visible: postCheckoutTasks.isNotEmpty, child: TaskGroup(tasks:postCheckoutTasks, title: "POST CHECKOUT PREPs", icon: Icons.keyboard_double_arrow_up_outlined, )),
                  ],
                );

               /* return ListView.builder(
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
                ); */
              }
            }));
  }
}
