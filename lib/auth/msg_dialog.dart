import 'package:flutter/material.dart';



class MsgDialog{


 static alertMsg(  String msg,BuildContext context){
    showDialog(context: context, builder:(_)=> AlertDialog(title: Text(msg),));
  }

}
