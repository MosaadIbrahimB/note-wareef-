import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';


class BottomModel extends StatelessWidget {
 Function takaphoto;
 BottomModel({required this.takaphoto});
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async{
                  print("Image");
                 await takaphoto(ImageSource.gallery);

                },
                child: const Icon(
                  Icons.image,
                  color: Color(0xff362fd5),
                  size: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextModel(
                  text: "Image ",
                ),
              )
            ],
          ),
          SW(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: const EdgeInsets.only(left: 0),
                onPressed: () {
                  print("camera_alt");
                  takaphoto(ImageSource.camera);

                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Color(0xff362fd5),
                  size: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextModel(
                  text: "Camera",
                ),
              )
            ],
          )
        ],
      ),
    );
  }



}
