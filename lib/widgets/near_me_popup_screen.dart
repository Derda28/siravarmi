import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

import '../utilities/consts.dart';
import '../utilities/custom_rect_tween.dart';

class NearMePopupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NearMePopupState();
  }
}

class _NearMePopupState extends State{

  final String _heroNearMe = "near-me-hero";
  double _distance = 100;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroNearMe,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: primaryColor),
                      Divider(
                        indent:2.5,
                        endIndent: 2.5,
                      ),
                      Text(
                        "Yakinimda ara",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: primaryFontFamily,
                            color: primaryColor
                        ),)
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.house,
                        color: fontColor,
                        size: 40,
                      ),
                      SfSlider(
                          value: _distance,
                          activeColor: primaryColor,
                          inactiveColor: primaryColor.withOpacity(0.2),
                          enableTooltip: true,
                          numberFormat: NumberFormat("KM"),
                          interval: 5.0,
                          max: 25.0,
                          min: 0,
                          showTicks: true,
                          showLabels: false,

                          onChanged: (newDistance){
                            setState((){
                              _distance = newDistance;
                            });
                          }
                      ),
                      Icon(
                        Icons.location_on,
                        color: fontColor,
                        size: 40,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "TAMAM",
                            style: TextStyle(
                              fontFamily: primaryFontFamily,
                              fontSize: 18,
                              color: primaryColor
                            ),
                          )
                      )
                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}