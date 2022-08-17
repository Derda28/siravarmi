import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/select_barber_popup_screen.dart';

final String _heroSelectBarber = "select-barber-hero";

class BarberSlidingUpPanel extends StatefulWidget {
  @override
  State<BarberSlidingUpPanel> createState() => _BarberSlidingUpPanelState();
}



class _BarberSlidingUpPanelState extends State<BarberSlidingUpPanel> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Randevu Oluştur",
              style: TextStyle(
                  fontSize: getSize(24),
                  fontFamily: primaryFontFamily,
                  color: primaryColor,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
        Divider(
          height: getSize(28),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Berber Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
                Divider(
                  height: getSize(24),
                ),
                Text(
                  "Tarih Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
                Divider(
                  height: getSize(24),
                ),
                Text(
                  "Saat Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
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
                    height: getSize(35),
                    width: getSize(205),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                      ),
                      onPressed: () {
                        selectBarberClicked(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/BarberIcon2.png",
                            color: primaryColor,
                            scale: getSize(0.1),
                          ),
                          Divider(
                            indent: getSize(5),
                            endIndent: getSize(0),
                          ),
                          AutoSizeText(
                            "Farketmez",
                            style: TextStyle(
                                fontSize: getSize(18),
                                fontFamily: secondaryFontFamily,
                                color: primaryColor),
                          ),
                          Divider(
                            indent: getSize(5),
                            endIndent: getSize(5),
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
                  height: getSize(8),
                ),
                Container(
                  width: getSize(205),
                  height: getSize(35),
                  margin: EdgeInsets.only(top: getSize(10)),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2031));

                      // if 'cancel' => null
                      if (newDate == null) return;

                      setState(() => date = newDate);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: primaryColor,
                          size: getSize(20),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Text(
                            getDate(date),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getSize(18),
                                fontFamily: secondaryFontFamily,
                                color: primaryColor)),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
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
                  height: getSize(12),
                ),
                Container(
                  width: getSize(205),
                  height: getSize(35),
                  margin: EdgeInsets.only(top: getSize(10)),
                  child: OutlinedButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () async{
                      TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: time,


                      );
                      if (newTime == null) return;

                      setState(() => time = newTime);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: primaryColor,
                          size: getSize(15),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Text(
                          formateTime(time.hour, time.minute, null),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getSize(18),
                              fontFamily: secondaryFontFamily,
                              color: primaryColor),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
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
    Navigator.push(context,
        HeroDialogRoute(builder: (context) => SelectBarberPopupScreen()));
  }
}

