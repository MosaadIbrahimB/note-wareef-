import 'package:flutter/material.dart';
import 'package:not/screen/edite_note_screen.dart';
import 'package:not/screen/home_screen.dart';
import 'package:not/screen/login_screen.dart';
import 'package:not/screen/new_note_screen.dart';
import 'package:not/screen/onboard_screen.dart';
import 'package:not/screen/singup_screen.dart';
import 'package:not/test.dart';

import 'firebase_file/firebase_cloud.dart';


class RouteMain  {



 static Map<String, Widget Function(BuildContext)> route = {
    OnBoardScreen.routeName: (_) => OnBoardScreen(),
    SingUpScreen.routeName: (_) => SingUpScreen(),
    LoginScreen.routeName: (_) =>  LoginScreen(),
    HomeScreen.routeName: (_) =>  HomeScreen( ),
    NewNote.routeName: (_) =>  NewNote(),
    EditeNote.routeName: (_) =>  EditeNote(),
    Test.routeName: (_) => Test(),
  };



}