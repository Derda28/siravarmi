import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/consts.dart';

class SelectCityDistrictBtn extends StatelessWidget {

  String title;

  SelectCityDistrictBtn({Key? key, required this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.transparent,
          ),
        ),
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
      ),

      onPressed: (){btnClicked(context);},
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: secondaryFontFamily,
                        color: primaryColor
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),

    );
  }

  void btnClicked(BuildContext context) {
    Navigator.pop(context, title);
  }
}
