import 'package:boatrack_mobile_app/widgets/settings/widget_board_task.dart';
import 'package:flutter/material.dart';

import '../../models/board_task.dart';
import '../../resources/colors.dart';
import '../../resources/styles/text_styles.dart';

class BoardTaskGroup extends StatefulWidget {
  final List<BoardTask> tasks;
  const BoardTaskGroup({Key? key, required this.tasks}) : super(key: key);

  @override
  State<BoardTaskGroup> createState() => _BoardTaskGroupState();
}

class _BoardTaskGroupState extends State<BoardTaskGroup> {
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
            Icon(Icons.developer_board, color: CustomColors().navigationTextColor,),
            const SizedBox(width: 5,),
            Text("BOARD", style: CustomTextStyles.titleText(context),),
          ],
        ),
        const SizedBox(height: 1,),
        Container(
          width: containerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(BoardTask task in widget.tasks)
                BoardTaskWidget(task: task)
            ],
          ),
        )
      ],
    );
  }
}
