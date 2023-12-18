import 'package:flutter/material.dart';
import 'package:not/model/component/text_model.dart';

class MessageModel{


static  displayMessage(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextModel(text: message,)));

  }


}