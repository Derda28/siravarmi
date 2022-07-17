
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siravarmi/utilities/consts.dart';


class Navbar extends StatelessWidget{

  int index;
  Navbar(this.index);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth!/4,
          height: 50,
          child: ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                overlayColor: index!=0 ? MaterialStateColor.resolveWith((states) => fontColor.withOpacity(0.5)):MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide.none
                      )
                  )

              ),

              child: Image.asset(
                "assets/images/HomeNav.png",
                height: 28,
                width: 36.01,
                color: index==0?primaryColor:fontColor,
              )
          ),
        ),
        SizedBox(
          width: screenWidth!/4,
          height: 50,
          child: ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor: index!=1 ? MaterialStateColor.resolveWith((states) => fontColor.withOpacity(0.5)):MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide.none
                      )
                  )

              ),

              child: Image.asset(
                "assets/images/AppointmentNav.png",
                height: 28,
                width: 24.5,
                color: index==1?primaryColor:fontColor,
              )
          ),
        ),
        SizedBox(
          width: screenWidth!/4,
          height: 50,
          child: ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor: index!=2 ? MaterialStateColor.resolveWith((states) => fontColor.withOpacity(0.5)):MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide.none
                      )
                  )

              ),

              child: Image.asset(
                "assets/images/NotificationNav.png",
                height: 28,
                width: 24.5,
                color: index==2?primaryColor:fontColor,
              )
          ),
        ),
        SizedBox(
          width: screenWidth!/4,
          height: 50,
          child: ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor: index!=3 ? MaterialStateColor.resolveWith((states) => fontColor.withOpacity(0.5)):MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide.none
                      )
                  )

              ),

              child: Image.asset(
                "assets/images/MenuNav.png",
                height: 28,
                width: 28,
                color: index==3?primaryColor:fontColor,
              )
          ),
        ),
      ],
    );
  }



}