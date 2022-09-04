import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/barberList_screen.dart';
import '../../utilities/consts.dart';

class NewAppoinmentHsBtn extends StatelessWidget {
  const NewAppoinmentHsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getSize(180),
        width: getSize(170),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
            overlayColor: MaterialStateColor.resolveWith((states) {
                return secondaryColor.withOpacity(0.1);
            }),
            animationDuration: Duration(milliseconds: 100),

          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BarberListScreen(whichBtn: 'regular',))),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: getSize(20)),
                child: Image.asset(
                  "assets/images/CalendarIcon.png",
                  color: secondaryColor,
                  height: getSize(87),
                  width: getSize(82),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: getSize(10)),
                child: Text(
                  "Yeni Randevu",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: getSize(24),
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
