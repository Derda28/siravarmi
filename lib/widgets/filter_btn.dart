import 'package:flutter/material.dart';

import '../utilities/consts.dart';

class FilterBtn extends StatelessWidget {

  String title,subtitle;
  IconData icon;

  FilterBtn({Key? key, required this.title, required this.subtitle, required this.icon}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.transparent,
          ),
        ),
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
      ),

      onPressed: (){},
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
              Row(
                children: [
                  Text(
                    subtitle,
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
              icon,
              color: primaryColor,
            ),
          )
        ],
      ),

    );
  }

}
