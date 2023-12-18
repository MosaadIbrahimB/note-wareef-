import 'dart:io';

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
import 'package:not/routes.dart';
import 'package:not/screen/home_screen.dart';

class NewNote extends StatefulWidget {
  static String routeName = "NewNote";

  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleControl = TextEditingController();
  TextEditingController descControl = TextEditingController();
  DateTime time = DateTime.now();

  int groupValue = 0;
  final ImagePicker picker = ImagePicker();
  XFile? image;
List name=[];
  String text1="";
  @override
  Widget build(BuildContext context) {
    print(typeNote());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("New note",style: TextStyle(color: Colors.white,fontSize:20 ,fontWeight: FontWeight.bold),),centerTitle: true,
        toolbarHeight: 80,
        flexibleSpace: FlexibleSpaceModel(titleBar: false),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50, bottom: 12),
            child: IconButton(
              onPressed: () {
                check()
                    ? createNote()
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
                  ? const Expanded(
                      child: SizedBox(height: 2, width: double.infinity))
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
    if (image==null) {
      return false;
    }
    return true;
  }

  void createNote() async {
    MsgDialog.alertMsg("Upload Note ....", context);
    String url = await upload();

    var uid = FirebaseAuth.instance.currentUser?.uid;
    NoteDataModel not = NoteDataModel(
        userId: uid ?? "null",
        date: time.millisecondsSinceEpoch,
        title: titleControl.text,
        type: typeNote(),
        desc: descControl.text,
        image: url);

    await FireBaseCloudControl.addNote(not).then((value) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, HomeScreen.routeName, (route) => false);


      FireBaseCloudControl.getDataCurrentUser(name).then((value) {
        text1 = name[0]["name"];
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(
                  nameUser: text1,
                )
            ,),
            (route)=>false
        );
      });



    }).catchError((e) => debugPrint(e));
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
