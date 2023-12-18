import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:not/auth/valid_utils.dart';
import 'package:not/firebase_file/firebase_auth.dart';
import 'package:not/firebase_file/firebase_cloud.dart';
import 'package:not/model/component/btn_model.dart';
import 'package:not/model/component/row_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_model.dart';
import 'package:not/model/data/user_data_model.dart';
import 'package:not/screen/home_screen.dart';
import 'package:not/screen/login_screen.dart';

class SingUpScreen extends StatefulWidget {
  static String routeName = "SingUpScreen";

  @override
  State<SingUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SingUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: keyForm,
        child: ListView(
          shrinkWrap: false,
          padding: const EdgeInsets.all(8),
          children: [
            Column(
              children: [
                SizedBox(
                    width: 160,
                    child: Image.asset("assets/images/logo_login.JPG")),
                SH(20),
                RowModel(
                  validator: ValidUtils.ifValidName,
                  text: "User name",
                  icon: Icons.person,
                  textEditingController: nameController,
                ),
                SH(20),
                RowModel(
                  validator: ValidUtils.ifValidEmail,
                  text: "Email",
                  icon: Icons.email,
                  textEditingController: emailController,
                ),
                SH(20),
                RowModel(
                  validator: ValidUtils.ifValidPassword,
                  text: "Password",
                  obscureText: obscureText,
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
                  icon: Icons.lock,
                  textEditingController: passwordController,
                ),
                SH(25),
                BtnModel(
                  text: "SIGN UP",
                  ontap: signUp,
                ),
                SH(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextModel(
                      text: "Don't Have any account ",
                      color: Colors.black26,
                      fontSize: 18,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: TextModel(
                        text: "login",
                        color: const Color(0xff362fd5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  signUp() async {
    if (keyForm.currentState!.validate()) {
      await createUser();
      await addUDatabase();
    }
  }

  createUser() async {
    await FireBaseAuthControl.createUser(
            emailAddress: emailController.text,
            password: passwordController.text)
        .then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
    });
  }

  addUDatabase() async {
    // await FireBaseCloudControl.addUser(UserDataModel(name: nameController.text,
    //     email: emailController.text));

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(UserDataModel.userDataModelToJson(
            UserDataModel(name: nameController.text, email: emailController.text)));
  }

  click() async {
    UserDataModel userOne =
        UserDataModel(name: nameController.text, email: emailController.text);
    try {
      context.loaderOverlay.show();

      await FireBaseAuthControl.createUser(
              emailAddress: emailController.text,
              password: passwordController.text)
          .then(
        (value) async {
          await Future.delayed(
            const Duration(seconds: 2),
            () {
              context.loaderOverlay.hide();
              //هنا اضافة اليوزر الى الداتابيز
              FireBaseCloudControl.addUser(userOne);
              value != null
                  ? Navigator.pushNamed(context, HomeScreen.routeName)
                  : "";
            },
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
