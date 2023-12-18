import 'package:flutter/material.dart';

class Test extends StatelessWidget {

  static String routeName = "Test";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.red),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              //هنا curved
              borderRadius: BorderRadius.vertical(bottom:Radius.elliptical(MediaQuery.of(context).size.width, 80)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75)
                  )
                ],
                //هنا مسار الصورة
                image: DecorationImage(image:AssetImage("assets/images/uni.JPG"),fit: BoxFit.fill )
            ),
          ),


        ],
      ),


    );
  }
}
class CurveImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-30);
    path.quadraticBezierTo(size.width / 4, size.height,
        size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}