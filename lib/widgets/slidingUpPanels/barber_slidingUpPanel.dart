import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/select_barber_popup_screen.dart';

final String _heroSelectBarber = "select-barber-hero";

class BarberSlidingUpPanel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Randevu olustur",
              style: TextStyle(
                fontSize: 20,
                fontFamily: primaryFontFamily,
                color: primaryColor,
                decoration: TextDecoration.underline
              ),
            )
          ],
        ),
        Divider(
          height: 28,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Berber Sec",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: primaryFontFamily,
                      color: primaryColor,
                    ),
                ),
                Divider(
                  height: 20,
                ),
                Text(
                  "Tarih Sec",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
                Divider(
                  height: 20,
                ),
                Text(
                  "Saat Sec",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: _heroSelectBarber,
                  child: Container(
                    height: 22,
                    width: 205,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),

                      ),
                      onPressed: (){
                        selectBarberClicked(context);
                      },
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/BarberIcon2.png",
                            color: primaryColor,
                            scale: 0.1,
                          ),
                          Divider(
                            indent: 5,
                            endIndent: 5,
                          ),
                          Text(
                              "Fark etmez",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: secondaryFontFamily,
                              color: primaryColor
                            ),
                          ),
                          Divider(
                            indent: 5,
                            endIndent: 5,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 8,
                ),
                Container(
                  width: 205,
                  height: 22,
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),

                    ),
                    onPressed: (){},
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: primaryColor,
                          size: 20,
                        ),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text(
                          "21.07.2022",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: secondaryFontFamily,
                              color: primaryColor
                          ),
                        ),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 12,
                ),
                Container(
                  width: 205,
                  height: 22,
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),

                    ),
                    onPressed: (){},
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: primaryColor,
                          size: 15,
                        ),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text(
                          "13:00",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: secondaryFontFamily,
                              color: primaryColor
                          ),
                        ),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  void selectBarberClicked(BuildContext context) {
    Navigator.push(context, HeroDialogRoute(builder: (context) => SelectBarberPopupScreen()));
  }

}