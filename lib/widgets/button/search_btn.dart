import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/barberList_screen.dart';
import '../../screens/barber_screen.dart';
import '../../utilities/consts.dart';

class SearchBtn{
  Widget build({required double height,double? topMargin, required BuildContext btnClick, required String whichScreen}){
    return Container(
      height: height,
      width: screenWidth!*350/designWidth,
      margin: EdgeInsets.only(
          top: topMargin??0),
      child: OutlinedButton(
          style: ButtonStyle(
            animationDuration: Duration(milliseconds: 100),
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
          ),
          onPressed: () => whichScreenNavigate(btnClick, whichScreen),
          child: Stack(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: fontColor,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Berber bul",
                  style: TextStyle(color: fontColor),
                ),
              )
            ],
          )
      ),
    );
  }

  whichScreenNavigate(btnClick, String whichScreen) {
    switch(whichScreen){
      case "list":
        return Navigator.push(btnClick, MaterialPageRoute(builder: (context)=>BarberListScreen()));
        break;
      default: print("No Screen Selected!");
    }
  }
}