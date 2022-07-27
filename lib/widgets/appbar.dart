import 'package:flutter/material.dart';
import 'package:siravarmi/screens/login_screen.dart';

import '../utilities/consts.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget{
  String? label;
  String? labelHome;
  bool fromHome;
  Appbar({this.label , this.labelHome, required this.fromHome, Key? key}) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();

  @override
  Size get preferredSize {
    return Size(getSize(screenWidth!), getSize(54));
  }
}

class _AppbarState extends State<Appbar> {

  @override
  void initState() {
    updateTitle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenWidth! * 0.12),
                  bottomRight: Radius.circular(screenWidth! * 0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, screenWidth! * 0.0024271845),
                ),
              ],
            ),
            height: screenWidth! * 0.136,
            width: screenWidth! * 5 / 6,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth! * 0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.fromHome ? widget.labelHome! :widget.label!,
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: primaryFontFamily,
                        fontSize: screenWidth!/12,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth! * 0.02),
          child: IconButton(
              onPressed: () {profileIsClicked(context);},
              icon: Icon(Icons.account_circle_outlined,
                  size: screenWidth! * 0.097),
              color: Colors.white),
        )
      ],
    );
  }

  Future<void> profileIsClicked(BuildContext context) async {
    if(!isLoggedIn){
      bool logInSuccess = await Navigator
          .push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

      if(logInSuccess){
        updateTitle();
      }
    }else{

    }
  }

  updateTitle() {
    setState((){
      if(isLoggedIn){
        widget.labelHome = "Merhaba "+user.name!;
      }else{
        widget.labelHome = "Giris Yapin.";
      }
    });
  }
}