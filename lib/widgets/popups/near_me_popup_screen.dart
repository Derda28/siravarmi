import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

import '../../utilities/consts.dart';
import '../../utilities/custom_rect_tween.dart';

class NearMePopupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NearMePopupState();
  }
}

class _NearMePopupState extends State{

  double? _distance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Material(
        color: Colors.white,
        elevation: 10,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.house,
                    color: fontColor,
                    size: 40,
                  ),
                  SfSlider(
                      value: _distance ?? 25.0,
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
                      onPressed: () {
                        btnIsClicked(context);
                      },
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
    );
  }

  void btnIsClicked(BuildContext context) {
    if(_distance==null){
      Navigator.pop(context);
    }else{
      int result = _distance!.toInt();
      Navigator.pop(context, result);
    }
  }

}