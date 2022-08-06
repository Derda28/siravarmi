
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

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

bool isLoggedIn = true;
UserModel user = UserModel(name: "derda", surname: "savas", isMan: true, id: 1);

double getSize(double sizeNumber){
  return screenWidth!*(sizeNumber/designWidth);
}

getDate(DateTime dateTime) {
  print("getTimeEntered");
  String day = dateTime.day.toString();
  String month = dateTime.month.toString();
  String year = dateTime.year.toString();
  return day+"."+month+"."+year;
}

getTime(DateTime dateTime) {
  print("getTimeEntered");
  String hours = dateTime.hour.toString();
  String minutes = dateTime.minute.toString();
  return hours+":"+minutes;
}


