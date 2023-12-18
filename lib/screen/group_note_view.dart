import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:not/model/component/list_month.dart';
import 'package:not/model/component/not_model.dart';
import 'package:not/model/component/size_box_model.dart';
import 'package:not/screen/edite_note_screen.dart';
import 'package:not/screen/home_screen.dart';
import 'package:characters/characters.dart';
import 'package:not/test.dart';
import 'package:intl/intl.dart';


class GroupNoteView extends StatefulWidget {
  static String routeName = "GroupNoteView";
   String nameGroup = "GroupNoteView";
  List<QueryDocumentSnapshot> listNote = [];
  GroupNoteView({super.key,required this.listNote,required this.nameGroup});

  @override
  State<GroupNoteView> createState() => _GroupNoteViewState();
}

class _GroupNoteViewState extends State<GroupNoteView> {

  String title = "";
  String date = "0";
  String dateMonth = "";
  String dateDay = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text(" ${widget.nameGroup}",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor:  const Color(0xff362fd5),),
      body: widget.listNote.isEmpty?
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
        itemCount: widget.listNote.length,
        itemBuilder: (c, i) {

          int millisecondsSinceEpoch =widget.listNote[i]["date"];
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
          String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

          // print(formattedDate);

          date = formattedDate;
          dateDay = formattedDate;
          dateMonth = formattedDate.substring(5, 7);
          title = widget.listNote[i]["title"];
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


                      Navigator.push(context, MaterialPageRoute (builder: (context) {
                        return  EditeNote(
                          date: formattedDate.substring(0,10),
                          id:widget.listNote[i].id,
                          title: widget.listNote[i]["title"],
                          desc: widget.listNote[i]["desc"],
                          type: widget.listNote[i]["type"],
                          image: widget.listNote[i]["image"],
                        );
                      },));
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
      ),


    );
  }



  deleteData(int i) async {
    await FirebaseFirestore.instance
        .collection("note")
        .doc(widget.listNote[i].id)
        .delete();
  }

  push() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }


}
