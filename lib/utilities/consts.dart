
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

String getDate(DateTime dateTime) {
  return formateDate(dateTime.day, dateTime.month, dateTime.year);
}

String getTime(DateTime dateTime) {
  return formateTime(dateTime.hour , dateTime.minute, null);
}

String formateDate(int day, int month, int year){
  String dayR,monthR,yearR;
  if(day<10){
    dayR = "0$day";
  }else{
    dayR = "$day";
  }
  if(month<10){
    monthR = "0$month";
  }else{
    monthR = "$month";
  }
  yearR = "$year";
  return dayR+"."+monthR+"."+yearR;
}

formateTime(int hour, int minute, int? second){
  String hourR,minuteR,secondR;
  if(hour<10){
    hourR = "0$hour";
  }else{
    hourR = "$hour";
  }
  if(minute<10){
    minuteR = "0$minute";
  }else{
    minuteR = "$minute";
  }
  if(second!=null){
    if(second<10){
      secondR = "0$second";
    }else{
      secondR = "$second";
    }
    return hourR+"."+minuteR+"."+secondR;
  }else{
    return hourR+"."+minuteR;
  }
}


