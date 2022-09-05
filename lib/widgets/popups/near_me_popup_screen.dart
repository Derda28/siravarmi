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
          padding: EdgeInsets.only(left: getSize(10), right: getSize(10), top: getSize(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: primaryColor),
                  SizedBox(
                    width: getSize(10),
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
              SizedBox(
                height: getSize(10),
              ),
              Row(
                children: [
                  Icon(
                    Icons.house,
                    color: fontColor,
                    size: getSize(40),
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
                    size: getSize(40),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        btnIsClicked(context, false);
                      },
                      child: Text(
                        "IPTAL",
                        style: TextStyle(
                            fontFamily: primaryFontFamily,
                            fontSize: getSize(18),
                            color: primaryColor
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        btnIsClicked(context, true);
                      },
                      child: Text(
                        "TAMAM",
                        style: TextStyle(
                          fontFamily: primaryFontFamily,
                          fontSize: getSize(18),
                          color: primaryColor
                        ),
                      )
                  ),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }

  void btnIsClicked(BuildContext context, bool isOk) {
    if(isOk){
      if(_distance==null){
        Navigator.pop(context);
      }else{
        int result = _distance!.toInt();
        Navigator.pop(context, result);
      }
    }else{
      Navigator.pop(context);
    }
  }

}