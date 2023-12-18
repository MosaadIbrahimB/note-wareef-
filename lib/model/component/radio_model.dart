import 'package:flutter/material.dart';
import 'package:not/model/component/text_model.dart';

class RadioModel extends StatelessWidget {
  String title;
  int val;
  int group;
  void Function(int?)? onChange;

  RadioModel({
    required this.title,
    required this.val,
    required this.group,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile(
        title: TextModel(text: title),
        value: val,
        groupValue: group,
        onChanged: onChange,
      ),
    );
  }
}
