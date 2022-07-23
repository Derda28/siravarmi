import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/consts.dart';
import '../utilities/custom_rect_tween.dart';

final String _heroselectedService = "selected-service-hero";

class SelectedServicePopupScreen extends StatelessWidget {
  const SelectedServicePopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Hero(
            tag: _heroselectedService,
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
                    Text(
                      "Secili Hizmetler",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: primaryFontFamily,
                        color: primaryColor
                      ),
                    ),
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) => OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
                            overlayColor: MaterialStateColor.resolveWith((states) => secondaryColor),
                          ),
                          onPressed: (){},
                          child:Text(
                            index.toString()+". Hizmet",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: secondaryFontFamily,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
        )
    );
  }
}
