import 'package:flutter/material.dart';

class Responsive {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static SizedBox h(BuildContext context, double percent) =>
      SizedBox(height: height(context) * percent / 100);

  static SizedBox w(BuildContext context, double percent) =>
      SizedBox(width: width(context) * percent / 100);
}
