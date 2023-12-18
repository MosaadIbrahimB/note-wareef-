import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not/auth/msg_dialog.dart';
import 'package:not/firebase_file/firebase_cloud.dart';
import 'package:not/firebase_file/firebase_store.dart';
import 'package:not/model/component/bottom_model.dart';
import 'package:not/model/component/flexible_space_model.dart';
import 'package:not/model/component/message_model.dart';
import 'package:not/model/component/radio_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/model/component/text_form_field_model.dart';
import 'package:not/model/component/text_model.dart';
import 'package:not/model/data/note_data_model.dart';
import 'package:not/screen/home_screen.dart';

class EditeNote extends StatefulWidget {
  static String routeName = "EditeNote";

  String date, id, title, desc, type, image;

  EditeNote({
    this.date = "",
    this.id = "",
    this.title = "",
    this.desc = "",
    this.type = "",
    this.image = "",
  });

  @override
  State<EditeNote> createState() => _EditeNote();
}

class _EditeNote extends State<EditeNote> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleControl = TextEditingController();
  TextEditingController descControl = TextEditingController();
  DateTime time = DateTime.now();

  int groupValue = 0;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  List<DocumentSnapshot> name = [];
  String text1 = "d";
  @override
  void initState() {
    titleControl.text = widget.title;
    descControl.text = widget.desc;
    groupValue = typeNoteEdait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.date);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "EditeNote",
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 80,
        flexibleSpace: FlexibleSpaceModel(titleBar: false),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50, bottom: 12),
            child: IconButton(
              onPressed: () {
                check()
                    ? edaitNote()
                    : MessageModel.displayMessage("Not Empty", context);
                print(check());
              },
              icon: const Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextModel(text: time.toString().substring(0, 10)),
              Card(
                  child: Column(
                children: [
                  Row(
                    children: [
                      RadioModel(
                          title: "Personal",
                          group: groupValue,
                          val: 1,
                          onChange: click),
                      RadioModel(
                          title: "Work",
                          group: groupValue,
                          val: 2,
                          onChange: click),
                    ],
                  ),
                  Row(
                    children: [
                      RadioModel(
                          title: "Meeting",
                          group: groupValue,
                          val: 3,
                          onChange: click),
                      RadioModel(
                          title: "Shopping",
                          group: groupValue,
                          val: 4,
                          onChange: click),
                    ],
                  ),
                ],
              )),
              SH(15),
              TextFormFieldModel(
                text: "Title note ",
                control: titleControl,
              ),
              TextFormFieldModel(
                text: "Description note ",
                control: descControl,
              ),
              SH(15),
              image == null
                  ? Expanded(
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        child: Image.network(widget.image, fit: BoxFit.fill),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              // const Spacer(),
              SH(15),

              BottomModel(takaphoto: takePhoto),
            ],
          ),
        ),
      ),
    );
  }

  click(int? value) {
    setState(() {
      value != null ? groupValue = value : "";
    });
  }

  check() {
    if (groupValue == 0) {
      return false;
    }
    if (titleControl.text.isEmpty) {
      return false;
    }
    if (descControl.text.isEmpty) {
      return false;
    }

    return true;
  }

  String url = "";
  void edaitNote() async {
    MsgDialog.alertMsg("Upload Note ....", context);
    if (image != null) {
      url = await upload();
      setState(() {});
    }
    // print("url $url");
    // print("image $image");
    var uid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference note = FirebaseFirestore.instance.collection('note');
    note
        .doc(widget.id)
        .update({
          "userId": uid ?? "null",
          "date": time.millisecondsSinceEpoch,
          "title": titleControl.text,
          "type": typeNote(),
          "desc": descControl.text,
          //هنا شرط لو الفايل كامرا مش فارغ ابعت url اللى جاى من upload function ولو فارغ خليه زى ماهو مرسل من صفحة النوت
          "image": image != null ? url : widget.image
        })
        .then((value) => push())
        .catchError((error) => print("Failed to update user: $error"));
  }



  push() {

    FireBaseCloudControl.getDataCurrentUser(name).then((value) {
      text1 = name[0]["name"];

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(
                nameUser: text1,
              )),
              (route)=>false
      );

    });

  }

  typeNote() {
    switch (groupValue) {
      case 0:
        return "";
      case 1:
        return "Personal";
      case 2:
        return "Work";
      case 3:
        return "Meeting";
      case 4:
        return "Shopping";
    }
  }

  typeNoteEdait() {
    switch (widget.type) {
      case "":
        return "";
      case "Personal":
        return 1;
      case "Work":
        return 2;
      case "Meeting":
        return 3;
      case "Shopping":
        return 4;
    }
  }

  Future<void> takePhoto(ImageSource source) async {
    image = await picker.pickImage(source: source).catchError((e) {
      print(e);
    });
    setState(() {});
  }

  Future<String> upload() async {
    String url = await FireBaseStoreControl.upload(
        file: File(image!.path), name: image!.name);
    print(url);
    return url;
  }
}
