import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:not/firebase_file/firebase_cloud.dart';
import 'package:not/model/component/list_month.dart';
import 'package:not/model/component/not_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/screen/edite_note_screen.dart';
import 'package:not/screen/home_screen.dart';
import 'package:characters/characters.dart';
import 'package:not/test.dart';
import 'package:intl/intl.dart';


class Note extends StatefulWidget {
  Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  List<QueryDocumentSnapshot> listNote = [];

  List <QueryDocumentSnapshot>personal=[];
  List<DocumentSnapshot> name = [];
  bool isLoading = true;
  String title = "";
  String date = "0";
  String dateMonth = "";
  String dateDay = "";

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :listNote.isEmpty?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_note.PNG"),
          const Text("No Notes",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          const Text("You no task to do ",style: TextStyle(fontSize: 24),),
        ],
      ),
    ):
    ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            separatorBuilder: (c, i) {
              return SH(10);
            },
            itemCount: listNote.length,
            itemBuilder: (c, i) {

              int millisecondsSinceEpoch =listNote[i]["date"];
              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
              String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

          // print(formattedDate);

              date = formattedDate;
              dateDay = formattedDate;
              dateMonth = formattedDate.substring(5, 7);
              title = listNote[i]["title"];
              // print(listNote[i].get("date"));
              return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: UniqueKey(),
                //edite data
                startActionPane: ActionPane(
                  extentRatio: .2,
                  motion: const ScrollMotion(),
                  children: [

                    CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      radius: 30,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        color: Colors.white,
                        onPressed: () {


                          Navigator.push(context,
                              MaterialPageRoute (builder: (context) {
                            return  EditeNote(
                              date: formattedDate.substring(0,10),
                              id:listNote[i].id,
                              title: listNote[i]["title"],
                              desc: listNote[i]["desc"],
                              type: listNote[i]["type"],
                              image: listNote[i]["image"],
                            );
                          },));
                          // print(formattedDate.substring(0,10));
                          // print(listNote[i]["title"]);
                          // print(listNote[i]["desc"]);
                          // print(listNote[i]["type"]);
                          // print(listNote[i]["image"]);
                        },
                      ),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: .2,
                  motion: const ScrollMotion(),
                  children: [
                    //Delete
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        radius: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            deleteData(i);
                            push();
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                child: NoteModel(
                  index: i,
                  title: title,
                  dateDay: dateDay,
                  dateMonth: month[dateMonth] ?? "",
                ),
              );
            },
          );
  }

  getData() async {
    try {
      QuerySnapshot fb = await FirebaseFirestore
          .instance
          .collection("note")
          .where('userId', isEqualTo:  FirebaseAuth.instance.currentUser!.uid)
          .orderBy('date',descending: false)
          .get();
      //get all data
      listNote.addAll(fb.docs);

    } catch (e) {
      print(e.toString());
    }
    Future.delayed(const Duration(seconds: 0)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  deleteData(int i) async {
    await FirebaseFirestore.instance
        .collection("note")
        .doc(listNote[i].id)
        .delete();
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
String text1="note_tabs";

}
