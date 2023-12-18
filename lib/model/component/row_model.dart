import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not/model/component/size_box_model.dart';
class RowModel extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  String text;
  IconData? icon;
   bool obscureText;
  Widget? suffixIcon;
  TextInputAction? textInputAction;
final String? Function(String?)? validator;
  RowModel(
      {super.key,
        required this.textEditingController,
        required this.text,
        required this.icon,
        this.validator,
       this.obscureText =false,
        this.suffixIcon,
        this.textInputAction
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Icon(
            icon,
            size: 35,
            color: const Color(0xff362fd5),
          ),
        ),
        SW(10),
        Expanded(
          flex: 6,
          child: TextFormField(
            obscureText: obscureText,
            // textInputAction:TextInputAction.next,
            textInputAction:textInputAction,
            validator: validator,
            controller: textEditingController,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
                label: Text(
                  text,
                  style: GoogleFonts.openSans(
                      color: const Color(0xff362fd5).withOpacity(.3),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
          ),
        ),
      ],
    );
  }
}
