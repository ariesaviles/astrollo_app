import 'package:flutter/widgets.dart';

/*
  ensures sizing scales to different size screens
 */
class ThemeConfig {
  static Color orange;
  static Color blue;
  static Color purple700;
  static Color purple500;
  static Color purple300;

  void init(BuildContext context) {
    orange = Color(0xfff2911d);
    blue = Color(0xff29baed);
    purple700 = Color(0xff2e243d);
    purple500 = Color(0xff403156);
    purple300 = Color(0xff655a82);

  }
}