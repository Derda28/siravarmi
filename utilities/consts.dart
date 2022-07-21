
import 'dart:ui';

import 'package:flutter/cupertino.dart';

//aa1a45
//FF1235FF

const Color primaryColor = Color(0xFF002964);
const Color secondaryColor = Color(0xFFAA1A45);
const Color bgColor = Color(0xFFF5F5F5);
const Color fontColor = Color(0xFF8E96A4);
double? screenHeight;
double? screenWidth;
double designWidth = 412.0;
const String primaryFontFamily = "Montserrat";
const String secondaryFontFamily = "Montserrat-Medium";

double getSize(double sizeNumber){
  return screenWidth!*(sizeNumber/designWidth);
}


