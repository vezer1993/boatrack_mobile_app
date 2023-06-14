import 'package:boatrack_mobile_app/models/board_task.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

import '../../helper/conversion.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';

class BoardTaskWidget extends StatefulWidget {
  final BoardTask task;
  const BoardTaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<BoardTaskWidget> createState() => _BoardTaskWidgetState();
}

class _BoardTaskWidgetState extends State<BoardTaskWidget> {

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery
        .of(context)
        .size
        .width);
    double containerWidth = width * 0.9;

    Icon priority = Icon(Icons.priority_high, color: Colors.green,);

    if(widget.task.priorityLevel == "2"){
      priority = Icon(Icons.priority_high, color: Colors.orange,);
    }

    if(widget.task.priorityLevel == "3"){
      priority = Icon(Icons.priority_high, color: Colors.red,);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          if (await confirm(context)) {
          return print('pressedOK');
          }
          return print('pressedCancel');
        },
        child: Container(
          decoration: CustomDecorations.standardBoxDecoration(),
          width: containerWidth,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Row(
                children: [
                  priority,
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.task.toString(),
                        style: CustomTextStyles.titleText(context),
                      ),
                      Text("DEADLINE: " +
                          Conversion.convertISOTimeToStandardFormatWithTime(
                              widget.task.deadline.toString()),
                        style: CustomTextStyles.descriptionText(context),)
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                    color: CustomColors().primaryColor,)
                ],
              )),
        ),
      ),
    );
  }
}
