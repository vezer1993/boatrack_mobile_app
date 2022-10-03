import 'dart:typed_data';

import 'package:boatrack_mobile_app/helper/lottie/lottie_manager.dart';
import 'package:boatrack_mobile_app/models/helper/custom_image.dart';
import 'package:boatrack_mobile_app/models/issues.dart';
import 'package:boatrack_mobile_app/resources/colors.dart';
import 'package:boatrack_mobile_app/resources/styles/box_decorations.dart';
import 'package:boatrack_mobile_app/resources/styles/text_styles.dart';
import 'package:boatrack_mobile_app/services/api/api_issues.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WidgetIssueReport extends StatefulWidget {
  final int yachtID;

  const WidgetIssueReport({Key? key, required this.yachtID}) : super(key: key);

  @override
  State<WidgetIssueReport> createState() => _WidgetIssueReportState();
}

class _WidgetIssueReportState extends State<WidgetIssueReport> {

  final ImagePicker _picker = ImagePicker();
  bool hasPictures = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  List<CustomImage> pictures = [];
  List<String> pictureNames = [];

  Future takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo != null){
      CustomImage image = CustomImage(await photo!.readAsBytes(), photo.name.toString());
      pictures.add(image);
      hasPictures = true;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: CustomColors().appBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.1),
              child: Text(
                "TITLE",
                style: CustomTextStyles.headerText(context),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: width * 0.7,
                child: TextFormField(
                  controller: titleController,
                  autocorrect: false,
                  cursorColor: CustomColors().primaryColor,
                  style: CustomTextStyles.regularText(context),
                  decoration: CustomDecorations.inputDecoration(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.1),
              child: Text(
                "DESCRIPTION",
                style: CustomTextStyles.headerText(context),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: width * 0.7,
                child: TextFormField(
                  controller: descriptionController,
                  autocorrect: false,
                  minLines: 5,
                  maxLines: 12,
                  cursorColor: CustomColors().primaryColor,
                  style: CustomTextStyles.regularText(context),
                  decoration: CustomDecorations.inputDecoration(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(visible: hasPictures,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(CustomImage pic in pictures)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.memory(pic.imageByte, width: 50, height: 70,),
                    ),
                ],
              ),),
            const SizedBox(height: 5,),
            Center(
              child: InkWell(
                onTap: () {
                  takePicture();
                },
                child: Container(
                    width: width * 0.5,
                    height: height * 0.08,
                    decoration: CustomDecorations
                        .buttonFailBoxDecoration(),
                    child: Center(
                      child: Text(
                        "TAKE PICTURE",
                        style: CustomTextStyles.buttonText(
                            context),
                      ),
                    )),
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    reportIssue();
                  },
                  child: Container(
                      width: width * 0.7,
                      height: height * 0.08,
                      decoration: CustomDecorations
                          .buttonBoxDecoration(),
                      child: Center(
                        child: Text(
                          "REPORT ISSUE",
                          style: CustomTextStyles.buttonText(
                              context),
                        ),
                      )),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  reportIssue() async{
    IssuesNavigation issue = IssuesNavigation();
    issue.name = titleController.text;
    issue.description = descriptionController.text;
    issue.yachtId = widget.yachtID;
    issue.hasPictures = hasPictures;

    bool response = await postIssue(issue, context, pictures);

    if(response){
      Navigator.pop(context, issue);
    }
  }
}
