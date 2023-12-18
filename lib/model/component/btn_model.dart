import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BtnModel extends StatelessWidget {
  String text;
  VoidCallback ontap;
  BtnModel({required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.green,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xff362fd5),
          minimumSize: const Size(200, 55),
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
