import 'package:flutter/material.dart';

import '../../utilities/consts.dart';
import '../../utilities/custom_rect_tween.dart';

class PriceFilterPopupScreen extends StatefulWidget {
  const PriceFilterPopupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriceFilterPopupState();
  }
}

class _PriceFilterPopupState extends State {

  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();

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
          padding: EdgeInsets.all(getSize(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Divider(
                    indent: 2.5,
                    endIndent: 2.5,
                  ),
                  Text(
                    "Fiyat",
                    style: TextStyle(
                        fontSize: getSize(20),
                        fontFamily: primaryFontFamily,
                        color: primaryColor),
                  )
                ],
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getSize(250),
                    child: TextField(
                      controller: minPrice,
                      decoration: InputDecoration(
                          hintText: 'En az',
                          hintStyle: TextStyle(
                            color: fontColor,
                            fontSize: getSize(12),
                          )),
                      style: TextStyle(
                          fontSize: getSize(14), fontFamily: secondaryFontFamily),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getSize(250),
                    child: TextField(
                      controller: maxPrice,
                      decoration: InputDecoration(
                          hintText: 'En cok',
                          hintStyle: TextStyle(
                            color: fontColor,
                            fontSize: getSize(12),
                          )),
                      style: TextStyle(
                          fontSize: getSize(14), fontFamily: secondaryFontFamily),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        cancelBtnIsClicked(context);
                      },
                      child: Text(
                        "IPTAL",
                        style: TextStyle(
                            fontFamily: primaryFontFamily,
                            fontSize: getSize(18),
                            color: primaryColor),
                      )),
                  TextButton(
                      onPressed: () {
                        confirmBtnIsClicked(context);
                      },
                      child: Text(
                        "TAMAM",
                        style: TextStyle(
                            fontFamily: primaryFontFamily,
                            fontSize: getSize(18),
                            color: primaryColor),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void cancelBtnIsClicked(BuildContext context) {
    Navigator.pop(context);
  }

  void confirmBtnIsClicked(BuildContext context) {
    Navigator.pop(context, {'min': minPrice.text, 'max' : maxPrice.text});
  }
}
