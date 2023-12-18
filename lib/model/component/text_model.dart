import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextModel extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color ?color;
  TextModel({super.key, required this.text, this.fontSize, this.fontWeight=FontWeight.w600,this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      // ("Her we can write Notes"),
      text,
      style: GoogleFonts.openSans(color:color,fontSize: fontSize, fontWeight: fontWeight),
    );
    ;
  }
}
