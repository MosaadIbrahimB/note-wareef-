import 'package:flutter/material.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';

class GroupModel extends StatelessWidget {
  String text;
  String countNotes;
  Color colorContainer;
  IconData icon;
  Color colorIcon;
  VoidCallback onTap;

  GroupModel(
      { required this.text,
      required this.colorIcon,
      required this.countNotes,
      required this.colorContainer,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 10, offset: Offset(0, 0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorIcon,
                  size: 40,
                ),
              ),
              SH(5),
              TextModel(
                text: text,
                fontWeight: FontWeight.bold,
              ),
              SH(5),
              TextModel(
                text: countNotes,
                color: Colors.black45,
              ),
              SH(5),
              TextModel(
                text: "Notes",
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
