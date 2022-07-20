import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/barberList_screen.dart';
import '../utilities/consts.dart';

class HomeScreenBtn {
  Widget build(
      { required BuildContext btnClick,
        required double btnHeigth,
        required double btnWidth,
        double? btnBottomPadding,
        double? btnLeftMargin,
        double? btnRightMargin,
        double? btnTopMargin,
        double? btnBottomMargin,
        required Color btnBgColor,
        required String btnIcon,
        required double btnIconHeigth,
        required double btnIconWidth,
        Color? btnIconColor,
        double? btnIconLeftPadding,
        double? btnIconRightPadding,
        String? btnOverlayColor,
        required String btnTxt,
        required double btnTxtFontSize,
        Color? btnTxtColor
        }){
    return Container(
        margin: EdgeInsets.only(
            top: btnTopMargin ?? 0,
            left: btnLeftMargin ?? 0,
            right: btnRightMargin ?? 0,
            bottom: btnBottomMargin ?? 0),
        height: btnHeigth,
        width: btnWidth,
        padding: EdgeInsets.only(bottom : btnBottomPadding??0),
        child: ElevatedButton(

          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => btnBgColor),
            overlayColor: MaterialStateColor.resolveWith((states) {
              if(btnOverlayColor == "mavi"){
                return secondaryColor.withOpacity(0.3);
              }else{
                return primaryColor.withOpacity(0.3);
              }
            }),
            animationDuration: Duration(milliseconds: 100),

          ),
          onPressed: () => Navigator.push(btnClick, MaterialPageRoute(builder: (context) => BarberListScreen())),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: (btnHeigth-btnIconHeigth)/5, left: btnIconLeftPadding ?? 0, right: btnIconRightPadding ?? 0),
                child: Image.asset(
                  btnIcon,
                  color: btnIconColor??primaryColor,
                  height: btnIconHeigth,
                  width: btnIconWidth,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  btnTxt,
                  style: TextStyle(
                    color: btnTxtColor??primaryColor,
                    fontSize: btnTxtFontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
    );
  }
}