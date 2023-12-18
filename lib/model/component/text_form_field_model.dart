import 'package:flutter/material.dart';
import 'package:not/model/component/text_model.dart';

class TextFormFieldModel extends StatelessWidget {
  TextEditingController control;
  String text;

  TextFormFieldModel({required this.text,required this.control});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      maxLines: null,
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 22),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        label: TextModel(
          text: text,
        ),
      ),
    );
    ;
  }
}
