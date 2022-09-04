import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/consts.dart';

class FastAppointmentHsBtn extends StatelessWidget {
  const FastAppointmentHsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getSize(180),
        width: getSize(170),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
            overlayColor: MaterialStateColor.resolveWith((states) {
              return primaryColor.withOpacity(0.1);
            }),
            animationDuration: Duration(milliseconds: 100),

          ),
          onPressed: (){
            btnIsClicked();
            },
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: getSize(20)),
                child: Image.asset(
                  "assets/images/BarberIconBig.png",
                  color: primaryColor,
                  height: getSize(87),
                  width: getSize(82),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: getSize(10)),
                child: Text(
                  "Hizli Randevu",
                  style: TextStyle(
                    color: primaryColor,
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

  void btnIsClicked() {}
}
