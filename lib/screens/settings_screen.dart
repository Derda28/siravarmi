import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/navbar.dart';

import '../widgets/appbar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Appbar("Menü").build(context),
      body: Column(
        children: [avatarBody()],
      ),
      bottomNavigationBar: Navbar(3, context),
    );
  }

  /*buildAppBar() {
    return AppBar(
      backgroundColor: secondaryColor,
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
                children: const [
                  Text("Menü",
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: "Montserrat",
                        fontSize: 30,
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
              onPressed: () {},
              icon: Icon(Icons.account_circle_outlined,
                  size: screenWidth! * 0.097),
              color: primaryColor),
        )
      ],
    );
  }*/

  avatarBody() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://icdn.ensonhaber.com/crop/250x141-85/resimler/diger/esh_54955.jpg"),
              fit: BoxFit.cover,

            ),
            borderRadius:
            BorderRadius.all(Radius.circular(screenWidth! * 0.12),

            ),
          ),
          height: 85,
          width: 85,
          margin: EdgeInsets.only(
              top: screenWidth! * 0.10, left: screenWidth! * 0.10),
        ),
        Container(
          margin: EdgeInsets.only(
              top: screenWidth! * 0.16, left: screenWidth! * 0.25),
          alignment: Alignment.center,
          child: Text(
            "Musafa Savaş",
            style: TextStyle(
              color: primaryColor,
              fontSize: screenWidth! * 0.07,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Divider(
                height: screenWidth! * 0.71,
                color: Colors.black,
                thickness: 1,
                indent: screenWidth! * 0.1,
                endIndent: screenWidth! * 0.1,
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: screenWidth!*0.440,left: screenWidth!*0.54),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0,1),
                ),
              ],
            ),

            height: screenWidth!*0.18,
            width: screenWidth!*0.35,

            child: Stack(
              children:  [
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.007),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: screenWidth!*0.07,
                  ),
                ),

                SizedBox(width: screenWidth!*0.36,),
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.03),
                  alignment: Alignment.center,
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(
                      fontSize: screenWidth!*0.06,
                      color: fontColor,
                    ),
                  ),
                )
              ],
            )

        ),
        Container(
            margin: EdgeInsets.only(top: screenWidth!*0.440, left: screenWidth!*0.11),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0,1),
                ),
              ],
            ),

            height: screenWidth!*0.18,
            width: screenWidth!*0.35,
            child: Stack(
              children:  [
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.007),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: screenWidth!*0.07,
                  ),
                ),

                SizedBox(width: screenWidth!*0.36,),
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.03),
                  alignment: Alignment.center,
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(
                      fontSize: screenWidth!*0.06,
                      color: fontColor,
                    ),
                  ),
                )
              ],
            )
        ),
        Container(
            margin: EdgeInsets.only(top: screenWidth!*0.7, left: screenWidth!*0.11),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0,1),
                ),
              ],
            ),

            height: screenWidth!*0.18,
            width: screenWidth!*0.35,

            child: Stack(
              children:  [
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.007),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: screenWidth!*0.07,
                  ),
                ),

                SizedBox(width: screenWidth!*0.36,),
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.03),
                  alignment: Alignment.center,
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(
                      fontSize: screenWidth!*0.06,
                      color: fontColor,
                    ),
                  ),
                )
              ],
            )
        ),
        Container(
            margin: EdgeInsets.only(top: screenWidth!*0.7, left: screenWidth!*0.54),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0,1),
                ),
              ],
            ),

            height: screenWidth!*0.18,
            width: screenWidth!*0.35,

            child: Stack(
              children:  [
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.007),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: screenWidth!*0.07,
                  ),
                ),

                SizedBox(width: screenWidth!*0.36,),
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.03),
                  alignment: Alignment.center,
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(
                      fontSize: screenWidth!*0.06,
                      color: fontColor,
                    ),
                  ),
                )
              ],
            )
        ),
        Container(
            margin: EdgeInsets.only(top: screenWidth!*0.96, left: screenWidth!*0.11),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0,1),
                ),
              ],
            ),

            height: screenWidth!*0.18,
            width: screenWidth!*0.35,
            child: Stack(
              children:  [
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.007),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: screenWidth!*0.07,
                  ),
                ),

                SizedBox(width: screenWidth!*0.36,),
                Container(
                  padding: EdgeInsets.only(left: screenWidth!*0.03),
                  alignment: Alignment.center,
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(
                      fontSize: screenWidth!*0.06,
                      color: fontColor,
                    ),
                  ),
                )
              ],
            )
        ),

      ],
    );
  }

}
