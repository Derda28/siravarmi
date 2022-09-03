import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/screens/barberList_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/custom_screen_route.dart';
import 'package:siravarmi/widgets/popups/near_me_popup_screen.dart';
import 'package:siravarmi/widgets/popups/price_filter_popup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../routes/hero_dialog_route.dart';
import '../../screens/select_address_screen.dart';
import '../../screens/sort_popup_screen.dart';

class BarberListSlidingUpPanel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  BarberListSlidingUpPanel(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  State<BarberListSlidingUpPanel> createState() =>
      _BarberListSlidingUpPanelState();
}

int? distance;
int? minPrice;
int? maxPrice;
String? district;
String? city;

class _BarberListSlidingUpPanelState extends State<BarberListSlidingUpPanel> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
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
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            nearMeBtnClicked(context);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Yakinimda Ara",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        distance == null
                            ? "Kapali - Tüm Mesafeler"
                            : "$distance KM ye kadar",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
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
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            selectAddressIsClicked();
          },
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
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        district == null ? "Türkiye" : "$district / $city",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
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
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            priceBtnClicked(context);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Fiyat",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        minPrice == null ? "Tümü" : "$minPrice ₺ - $maxPrice ₺",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getSize(20),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => primaryColor),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => secondaryColor.withOpacity(0.5))),
          onPressed: () {
            confirmBtnIsClicked(context);
          },
          child: Container(
            width: getSize(250),
            alignment: Alignment.center,
            child: Text(
              "Uygula",
              style: TextStyle(
                fontSize: 16,
                fontFamily: primaryFontFamily,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> nearMeBtnClicked(BuildContext context) async {
    final result =
        await showDialog(context: context, builder: (_) => NearMePopupScreen());

    if (result != null) {
      setState(() {
        distance = result;
      });
    }
  }

  Future<void> priceBtnClicked(BuildContext context) async {
    final result = await showDialog(
        context: context, builder: (_) => const PriceFilterPopupScreen());

    if (result != null) {
      setState(() {
        minPrice = int.tryParse(result['min']);
        maxPrice = int.tryParse(result['max']);
      });
    }
  }

  Future<void> selectAddressIsClicked() async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectAddressScreen()));

    if (result != null) {
      if (result['city'] != "TÜMÜ" && result['district'] != "TÜMÜ") {
        setState(() {
          district = result['district'];
          city = result['city'];
        });
      }
    }
  }

  void confirmBtnIsClicked(BuildContext context) {

    //Find a way to notificate the barberlistscreen that confirm btn is clicked in the sliding up panel

  }
}
