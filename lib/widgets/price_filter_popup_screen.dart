import 'package:flutter/material.dart';

import '../utilities/consts.dart';
import '../utilities/custom_rect_tween.dart';

class PriceFilterPopupScreen extends StatefulWidget {
  const PriceFilterPopupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriceFilterPopupState();
  }
}

class _PriceFilterPopupState extends State {
  final String _heroPrice = "price-hero";

  @override
  Widget build(BuildContext context) {
    print("build is entered");
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Hero(
          tag: _heroPrice,
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
                      Divider(
                        indent: 2.5,
                        endIndent: 2.5,
                      ),
                      Text(
                        "Fiyat",
                        style: TextStyle(
                            fontSize: 20,
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
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'En az',
                              hintStyle: TextStyle(
                                color: fontColor,
                                fontSize: 12,
                              )),
                          style: TextStyle(
                              fontSize: 14, fontFamily: secondaryFontFamily),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'En cok',
                              hintStyle: TextStyle(
                                color: fontColor,
                                fontSize: 12,
                              )),
                          style: TextStyle(
                              fontSize: 14, fontFamily: secondaryFontFamily),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "IPTAL",
                            style: TextStyle(
                                fontFamily: primaryFontFamily,
                                fontSize: 18,
                                color: primaryColor),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "TAMAM",
                            style: TextStyle(
                                fontFamily: primaryFontFamily,
                                fontSize: 18,
                                color: primaryColor),
                          )),
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
