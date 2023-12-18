import 'package:flutter/material.dart';
import 'package:not/model/component/btn_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';
import 'package:not/screen/login_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static String routeName = "OnBoardScreen";

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SizedBox(
                    width: 150, child: Image.asset("assets/images/logo.JPG"))),
            SH(200),
            TextModel(
              text: "Made it simple",
              fontSize: 32,
            ),
            SH(6),
            TextModel(
              text: "Her we can write Notes",
              fontSize: 17,
            ),
            SH(50),
            BtnModel(
              text: "Get Started",
              ontap: click,
            ),
            SH(50),


          ],
        ),
      ),
    );
  }

  click() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}


