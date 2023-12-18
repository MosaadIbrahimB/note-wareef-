import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not/firebase_file/firebase_auth.dart';
import 'package:not/firebase_file/firebase_cloud.dart';
import 'package:not/model/component/btn_model.dart';
import 'package:not/model/component/row_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';
import 'package:not/network/check_internet.dart';
import 'package:not/screen/home_screen.dart';
import 'package:not/screen/singup_screen.dart';

import '../auth/msg_dialog.dart';
import '../auth/valid_utils.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "loginScreen";

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool obscureText = true;
  bool loading = false;
  List<DocumentSnapshot> name = [];
  String text1 = "d";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: keyForm,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  SH(h * .1),
                  SizedBox(
                      height: 130,
                      width: 160,
                      child: Image.asset("assets/images/logo_login.JPG")),

                  SH(h * .05),
                  RowModel(
                    textInputAction: TextInputAction.next,
                    validator: ValidUtils.ifValidEmail,
                    text: "Email",
                    icon: Icons.person,
                    textEditingController: emailController,
                  ),
                  SH(20),
                  RowModel(
                    textInputAction: TextInputAction.go,
                    validator: ValidUtils.ifValidPassword,
                    text: "Password",
                    icon: Icons.lock,
                    obscureText: obscureText,
                    textEditingController: passwordController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText == true
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  SH(15),
                  //Forgotten password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          forgottenPassword();
                        },
                        child: TextModel(
                          text: "Forgotten password?",
                          color: const Color(0xff362fd5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SH(10),
                  BtnModel(
                    text: "login",
                    ontap: () async {
                      print("-------------------------");
                      keyForm.currentState!.validate();
                      var x = await checkInternet();
                      if (x) {
                        if (keyForm.currentState!.validate()) {
                          try {
                            loginEmail();
                          } catch (e) {
                            debugPrint(e as String?);
                          }
                        }
                      } else {
                        msg(message: "checkInternet");
                      }
                    },
                  ),
                  SH(25),
                  BtnModel(
                    text: "Google Login",
                    ontap: () async {
                      googleLogin();
                    },
                  ),
                  SH(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextModel(
                        text: "Don't Have any account ",
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SingUpScreen.routeName);
                        },
                        child: TextModel(
                          text: "SIGN UP",
                          color: const Color(0xff362fd5),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> loginEmail() async {
    setState(() {
      loading = true;

      // text1="a";
    });
    await FireBaseAuthControl.login(
            context: context,
            emailAddress: emailController.text,
            password: passwordController.text)
        .then(
      (value) {
        // emailVerified
        // if (value!.user!.emailVerified) {
        //   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        // }

        if (value != null) {
          FireBaseCloudControl.getDataCurrentUser(name).then((value) {
            text1 = name[0]["name"];

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                          nameUser: text1,
                        )));
            loading = false;
          });

          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            loading = false;
            setState(() {});
          });
        }
      },
    ).catchError((e) {
      setState(() {
        loading = false;
      });
    });
  }

  googleLogin() async {
    await FireBaseAuthControl.signInWithGoogle().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    });
  }

  void forgottenPassword() async {
    if (ValidUtils.ifValidEmail(emailController.text) == null) {
      await FireBaseAuthControl.forgetPassword(emailController.text).then((v) {
        MsgDialog.alertMsg("send rest your email", context);
      }).catchError((e) {
        MsgDialog.alertMsg(e, context);
      });
    } else {
      String? msg = ValidUtils.ifValidEmail(emailController.text);
      if (msg == null) {
        return;
      } else {
        MsgDialog.alertMsg(msg, context);
      }
    }
  }

  checkInternet() async {
    var x = await CheckInternet.checkInternetStatus();
    setState(() {});
    return x;
  }

  msg({required String message}) {
    MsgDialog.alertMsg(message, context);
  }
}
