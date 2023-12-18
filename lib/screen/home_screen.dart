import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:not/firebase_file/firebase_auth.dart';
import 'package:not/model/component/flexible_space_model.dart';
import 'package:not/screen/tabs/group_tab.dart';
import 'package:not/screen/login_screen.dart';
import 'package:not/screen/new_note_screen.dart';
import 'package:not/screen/tabs/note_tab.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";
  String nameUser;

   HomeScreen({super.key,  this.nameUser="x"});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;
  List<Widget> list = [ Note(),Group()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar:AppBar(
      flexibleSpace: FlexibleSpaceModel(text1: widget.nameUser),
        toolbarHeight: 80,
        actions: [IconButton(onPressed: (){
          singOut();

        }, icon: const Icon(Icons.logout),color: Colors.white,)],
      ),

      body: Column(
        children: [
           // BarModel(),
          Expanded(child: list[index]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pushNamed(context, NewNote.routeName);
        },

        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    Color(0xffface01),
                    Color(0xfffa7a19),
                  ],
                )),
            child: Container(
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,

              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],

        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items:  [
            BottomNavigationBarItem(
                icon: Icon(Icons.note_alt_outlined,color: index==0?Colors.blue:Colors.grey,), label: "Notes",),
            BottomNavigationBarItem(icon: Icon(Icons.groups,color: index==1?Colors.blue:Colors.grey,), label: "Groups"),
          ],
        ),
      ),
    );
  }




  // function out
  void singOut() async{
    final GoogleSignIn googleUser = GoogleSignIn();
    googleUser.disconnect().catchError((e){
      debugPrint(e.toString());
    });
    await FireBaseAuthControl.signOut().then((value) {
      debugPrint("out");

      Navigator.pushReplacementNamed(context,LoginScreen.routeName);
    });
  }


}
