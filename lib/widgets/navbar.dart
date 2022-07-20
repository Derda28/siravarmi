import 'package:flutter/material.dart';
import 'package:siravarmi/screens/appointment_screen.dart';
import 'package:siravarmi/screens/home_screen.dart';
import 'package:siravarmi/screens/notification_screen.dart';
import 'package:siravarmi/screens/settings_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/custom_screen_route.dart';


class Navbar extends StatefulWidget{

  int index;
  BuildContext context2;
  Navbar(this.index, this.context2, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavbarState(index, context2);
  }



}

class _NavbarState extends State{

  late int index;
  late BuildContext context2;
  _NavbarState(this.index, this.context2);


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
              onPressed: () =>buttonPressed(0),
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
              onPressed: () =>buttonPressed(1),
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
              onPressed: () =>buttonPressed(2),
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
              onPressed: () =>buttonPressed(3),
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

  buttonPressed(int whichOne) {
    print("GirdiAMK");
    if(whichOne!=index){
      switch(whichOne){
        case 0:
          Navigator.pushReplacement(context2, CustomScreenRoute(
              child: HomeScreen()));
          break;
        case 1:
          Navigator.pushReplacement(context2, CustomScreenRoute(
               child: AppointmentScreen()));
          break;
        case 2:
          Navigator.pushReplacement(context2, CustomScreenRoute(
              child: NotificationScreen()));
          break;
        case 3:
          Navigator.pushReplacement(context2, CustomScreenRoute(
              child: SettingsScreen()));
          break;
      }
    }
  }
}