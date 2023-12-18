import 'package:flutter/material.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';

class NoteModel extends StatelessWidget {
  int index;
  String title;
  String dateDay;
  String dateMonth;



  NoteModel({
  super.key,
    this.title="",
    this.dateDay="00",
    this.dateMonth="00",
    this.index=0,

  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ]),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 10,
            decoration: BoxDecoration(
              color: Color((index + 1) * 0xff998855),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          SW(25),
          //date
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextModel(
                  text: dateDay.substring(8,10),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 22),
              SH(5),
              TextModel(
                fontSize: 14,
                text: dateMonth,
                color: Colors.black45,
              ),
            ],
          ),
          SW(25),
          // titel note
          TextModel(
              text: title,
              fontWeight: FontWeight.bold,
              // color: Color(0xff0505EF),
              color: Color((index + 1) * 0xff998855),
              fontSize: 22),
          const Spacer(),
          Icon(Icons.favorite,color: Colors.grey.shade300,)
          ,SW(5)
        ],
      ),
    );
  }
}
