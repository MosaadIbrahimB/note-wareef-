import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not/model/component/group_model.dart';
import 'package:not/model/component/text_model.dart';
import 'package:not/screen/group_note_view.dart';

class Group extends StatefulWidget {
  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  List<QueryDocumentSnapshot> personal = [];
  List<QueryDocumentSnapshot> work = [];
  List<QueryDocumentSnapshot> meeting = [];
  List<QueryDocumentSnapshot> shopping = [];

  bool isLoading = true;

  String title = "";
  String date = "0";
  String dateMonth = "";
  String dateDay = "";

  @override
  void initState() {
    getDataWhereType("Personal");
    getDataWhereType("Work");
    getDataWhereType("Shopping");
    getDataWhereType("Meeting");
    super.initState();
  }
  List<GroupModel> item=[];
  @override
  Widget build(BuildContext context) {
    item = [
      GroupModel(
        text: "Personal",
        colorContainer: Colors.yellow.shade100,
        countNotes: personal.length == null ? "0" : personal.length.toString(),
        icon: Icons.person,
        colorIcon: Colors.orange,
        onTap:() {
          push("Personal",personal);
        },
      ),
      GroupModel(
        text: "Work",
        colorContainer: Colors.yellow.shade100,
        countNotes: work.length == null ? "0" : work.length.toString(),
        icon: Icons.person,
        colorIcon: Colors.orange,
        onTap:() {
          push("Work",work);
        },
      ),
      GroupModel(
        text: "Shopping",
        colorContainer: Colors.yellow.shade100,
        countNotes: shopping.length == null ? "0" : shopping.length.toString(),
        icon: Icons.person,
        colorIcon: Colors.orange,
        onTap:() {
          push("Shopping",shopping);
        },
      ),
      GroupModel(
        text: "Meeting",
        colorContainer: Colors.yellow.shade100,
        countNotes: meeting.length == null ? "0" : meeting.length.toString(),
        icon: Icons.person,
        colorIcon: Colors.orange,
        onTap:() {
          push("Meeting",meeting);
        },
      ),

    ];

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: TextModel(
              text: "Groups",
              fontSize: 24,
              color: Colors.black38,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: .95),
            itemBuilder: (BuildContext context, int index) {
              return item[index];
            },
            itemCount: item.length,
          ),
        ),
      ],
    );
  }

  getDataWhereType(String type) async {
    try {
      var fb = FirebaseFirestore.instance.collection("note");
      String id = FirebaseAuth.instance.currentUser!.uid;
      switch (type) {
        case "Personal":
          {
            var g = await fb
                .where('userId', isEqualTo: id)
                .where("type", isEqualTo: "Personal")
                .get();
            personal.addAll(g.docs);
          }
          break;
        case "Shopping":
          {
            var g = await fb
                .where('userId', isEqualTo: id)
                .where("type", isEqualTo: "Shopping")
                .get();
            shopping.addAll(g.docs);
          }
          break;
        case "Work":
          {
            var g = await fb
                .where('userId', isEqualTo: id)
                .where("type", isEqualTo: "Work")
                .get();
            work.addAll(g.docs);
          }
          break;
        case "Meeting":
          {
            var g = await fb
                .where('userId', isEqualTo: id)
                .where("type", isEqualTo: "Meeting")
                .get();
            meeting.addAll(g.docs);
          }
          break;
      }
      // print(personal[0]["title"]);
      // print(personal.length);
      // print(work[0]["title"]);
      // listNote.addAll(fb.docs);
    } catch (e) {
      print(e.toString());
    }
    Future.delayed(const Duration(seconds: 0)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  push(String groupName ,List <QueryDocumentSnapshot>list ) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return GroupNoteView(
        listNote: list,
        nameGroup: groupName,
      );
    }));
  }
}

