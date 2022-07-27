import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  String profileUrl =
      "https://icdn.ensonhaber.com/crop/250x141-85/resimler/diger/esh_54955.jpg";
  String customerName = "Mustafa Savaş";
  double textFont = getSize(18);
  double iconFont = getSize(22);
  double containerHSize = getSize(80);
  double containerWSize = getSize(166);
  double elevationSize = getSize(4);
  double borderSize = getSize(10);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Appbar(label:"Menü", labelHome: "", fromHome: false),
      body: Column(
        children: [avatarBody()],
      ),
      bottomNavigationBar: Navbar(3, context),
    );
  }

  avatarBody() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
              image: NetworkImage(profileUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(getSize(50)),
            ),
          ),
          height: getSize(85),
          width: getSize(85),
          margin: EdgeInsets.only(top: getSize(40), left: getSize(40)),
        ),
        Container(
          margin: EdgeInsets.only(
              top: getSize(66), left: getSize(140), right: getSize(40)),
          alignment: Alignment.center,
          child: AutoSizeText(
            maxLines: 1,
            customerName,
            style: TextStyle(
              color: primaryColor,
              fontSize: getSize(28),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Divider(
                height: getSize(293),
                color: Colors.black,
                thickness: getSize(1),
                indent: getSize(40),
                endIndent: getSize(40),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: getSize(146), left: getSize(30)),
            height: getSize(592),
            width: getSize(354),
            child: Stack(
              children: [
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin: EdgeInsets.only(top: getSize(40)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.black,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.favorite,
                              color: fontColor, size: iconFont),
                          Text(
                            "Favoriler",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin: EdgeInsets.only(top: getSize(40), left: getSize(187)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.settings,
                              color: fontColor, size: iconFont),
                          Text(
                            "Ayarlar",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin: EdgeInsets.only(top: getSize(150)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.account_circle_outlined,
                              color: fontColor, size: iconFont),
                          Text(
                            " Hesap \n Bilgileri",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin:
                  EdgeInsets.only(top: getSize(150), left: getSize(187)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                              width: iconFont,
                              height: iconFont,
                              color: fontColor,
                              image:
                              AssetImage("assets/images/BarberIcon2.png")),
                          Text(
                            "Berberler",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin: EdgeInsets.only(top: getSize(260)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.text_snippet_outlined,
                              color: fontColor, size: iconFont),
                          Text(
                            "Hakkımızda",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin:
                  EdgeInsets.only(top: getSize(260), left: getSize(187)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.format_align_center,
                              color: fontColor, size: iconFont),
                          Text(
                            " Kullanım\n Koşulları",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin: EdgeInsets.only(top: getSize(370)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.security,
                              color: fontColor, size: iconFont),
                          Text(
                            "Gizlilik",
                            style:
                            TextStyle(color: fontColor, fontSize: textFont),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: containerHSize,
                  width: containerWSize,
                  margin:
                  EdgeInsets.only(top: getSize(370), left: getSize(187)),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black38,
                          side: BorderSide(
                              color: Colors.black38, width: getSize(2)),
                          shadowColor: Colors.white,
                          elevation: elevationSize,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderSize))),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.exit_to_app,
                              color: Colors.red, size: iconFont),
                          Text(
                            "Çıkış",
                            style: TextStyle(
                                color: Colors.red, fontSize: textFont),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
