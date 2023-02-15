import 'package:boatrack_mobile_app/models/employeeTask.dart';
import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/widgets/settings/widget_task.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/box_decorations.dart';

class TaskGroup extends StatefulWidget {
  final List<EmployeeTask> tasks;
  final String title;
  final IconData icon;

  const TaskGroup(
      {Key? key, required this.tasks, required this.title, required this.icon})
      : super(key: key);

  @override
  State<TaskGroup> createState() => _TaskGroupState();
}

class _TaskGroupState extends State<TaskGroup> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double containerWidth = width * 0.9;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            Icon(widget.icon, color: CustomColors().navigationTextColor,),
            const SizedBox(width: 5,),
            Text(widget.title, style: CustomTextStyles.titleText(context),),
          ],
        ),
        const SizedBox(height: 1,),
        Container(
          width: containerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(EmployeeTask task in widget.tasks)
                TaskWidget(task: task,)
            ],
          ),
        )
      ],
    );
  }
}
