import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not/firebase_file/firebase_auth.dart';
import 'package:not/model/component/size_box_model.dart';

class FlexibleSpaceModel extends StatelessWidget {
  bool titleBar;
  String text1;
  String text2;
  String pathImage;

  FlexibleSpaceModel({
    this.titleBar = true,
    this.text1 = "Hello Brenda",
    this.text2 = "Today you  tasks",
    this.pathImage = "assets/images/logo.JPG",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xff362fd5),
        ),
        Positioned(
          bottom: 0,
          left: -125,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            width: 250,
            height: 250,
          ),
        ),
        Positioned(
          top: -45,
          right: -50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            width: 110,
            height: 130,
          ),
        ),
        titleBar
            ? Positioned(
                bottom: 10,
                right: 50,
                left: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "welcome $text1",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SH(5),
                          Text(text2,
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 5,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          color: Colors.white.withOpacity(.1),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(pathImage),
                          ),
                        ),
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
