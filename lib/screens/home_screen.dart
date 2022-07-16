import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/navbar.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [mapsBody(), buttonsBody(), lastBaberBody(), buildNavBar()],
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      /*title: const Text("Burada Randevu Yaziyor"),
        titleTextStyle: const TextStyle(color: primaryColor),*/
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
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            height: 56,
            width: screenWidth! * 5 / 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Merhaba, Derda!',
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Montserrat',
                      )),
                ],
              ),
            ),
          ),
          // Your widgets here
        ],
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined, size: 40),
              color: primaryColor),
        )
      ],
    );
  }

  mapsBody() {
    return Container(
      child: Image.network(
        'https://drive.google.com/uc?export=view&id=1bwZ_HIz1P2WhthPRY2UscrKUsOkhbRm6',
        height: screenHeight! / 4,
        width: screenWidth,
      ),
    );
  }

  buttonsBody() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          margin: const EdgeInsets.only(top: 45, left: 25, right: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 0,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          height: 50,
          child: Stack(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.search,),
              ),

              SizedBox(width: 150,),
              Align(
                alignment: Alignment.center,
                child: Text("Berber bul",),
              )
            ],
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              height: 200,
              width: 171,
              padding: EdgeInsets.only(bottom: 20),
              child: Stack(
                children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.ac_unit,
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Hizli Randevu",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              )
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 0,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                height: 200,
                width: 171,
                padding: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.ac_unit,
                        color: primaryColor,
                        size: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,

                      child: Text(
                        "Yeni Randevu",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 25,
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        )
      ],
    );
  }

  lastBaberBody() {
    return Container();
  }

  buildNavBar() {
    return Navbar();
  }
}
