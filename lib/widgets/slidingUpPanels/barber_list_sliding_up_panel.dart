

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/custom_screen_route.dart';
import 'package:siravarmi/widgets/popups/near_me_popup_screen.dart';
import 'package:siravarmi/widgets/popups/price_filter_popup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../routes/hero_dialog_route.dart';
import '../../screens/select_address_screen.dart';
import '../../screens/sort_popup_screen.dart';

class BarberListSlidingUpPanel extends StatelessWidget{
  final String _hero_near_me = "near-me-hero";
  final String _heroPrice = 'price-hero';

  final ScrollController controller;
  final PanelController panelController;

  BarberListSlidingUpPanel({ Key? key, required this.controller, required this.panelController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Secenekler",
          style: TextStyle(
            fontSize: 16,
            fontFamily: primaryFontFamily,
            color: fontColor,
          ),
        ),
        Divider(
          color: secondaryColor,
          thickness: 1,
        ),
        OutlinedButton(
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
              side: MaterialStateProperty.all(
                BorderSide(
                      color: Colors.transparent,
                ),
              ),
            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
          ),

          onPressed: (){nearMeBtnClicked(context);},
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: _hero_near_me,
                        child: Text(
                          "Yakinimda Ara",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Kapali - Tüm Mesafeler",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: secondaryFontFamily,
                          color: fontColor
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5,top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              )
            ],
          ),

        ),
        OutlinedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
          ),

          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectAddressScreen()));},
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Adres",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Türkiye",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5,top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              )
            ],
          ),

        ),
        OutlinedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
          ),

          onPressed: (){
            priceBtnClicked(context);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: _heroPrice,
                        child: Text(
                          "Fiyat",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: secondaryFontFamily,
                              color: primaryColor
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tümü",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5,top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              )
            ],
          ),

        ),
      ],
    );
  }

  Future<void> nearMeBtnClicked(BuildContext context) async {
    final result = await Navigator.push(context,HeroDialogRoute(builder: (context){
      return NearMePopupScreen();
    }));

  }

  Future<void> priceBtnClicked(BuildContext context) async {
    print("PriceBtn is Clicked");
    final result = await Navigator.push(context,HeroDialogRoute(builder: (context){
      return PriceFilterPopupScreen();
    }));

  }

}

