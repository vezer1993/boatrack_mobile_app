import 'package:flutter/material.dart';

class WidgetImageGallery extends StatefulWidget {
  final List<String> images;

  const WidgetImageGallery({Key? key, required this.images}) : super(key: key);

  @override
  State<WidgetImageGallery> createState() => _WidgetImageGalleryState();
}

class _WidgetImageGalleryState extends State<WidgetImageGallery> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if(index >= widget.images.length){
      index = 0;
    }

    return Column(
      children: [
        SizedBox(
          width: width * 0.9,
          height: height * 0.32,
          child: Image.network(
            widget.images[index],
            fit: BoxFit.fill,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              if(index > 0){
                setState(() {
                  index--;
                });
              }
            }, icon: Icon(Icons.arrow_back, size: 40,)),
            const SizedBox(width: 20,),
            IconButton(onPressed: () {
              if(index < (widget.images.length -1)){
                setState(() {
                  index++;
                });
              }
            }, icon: Icon(Icons.arrow_forward, size: 40,))
          ],
        )
      ],
        );
  }
}
