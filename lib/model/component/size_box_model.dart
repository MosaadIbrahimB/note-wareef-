
import 'package:flutter/material.dart';

class SW extends StatelessWidget {
  double w;
  SW([this.w = 20]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w);
  }
}

class SH extends StatelessWidget {
  double h;
  SH([this.h = 20]);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: h);
  }
}