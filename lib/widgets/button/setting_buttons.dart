import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/consts.dart';

class SettingButtons extends StatelessWidget {
  double textFont = getSize(18);
  double iconFont = getSize(22);
  double elevationSize = getSize(4);
  double borderSize = getSize(10);

  void Function() itemClicked;
  IconData? selectedIcon;
  String? assetImage;
  String buttonTitle;
  Color? textColor;
  Color? iconColor;

  SettingButtons(
      {Key? key,
        required this.itemClicked,
        this.selectedIcon,
        this.assetImage,
        this.iconColor,
        this.textColor,
        required this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.black38,
          side: BorderSide(color: Colors.black38, width: getSize(2)),
          shadowColor: Colors.white,
          elevation: elevationSize,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderSize))),
          backgroundColor: Colors.white),
      onPressed: itemClicked,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          assetImage != null? Image(
            width: iconFont,
            height: iconFont,
            color: iconColor != null? Colors.red : fontColor,
            image: AssetImage(assetImage!),
          ):Icon(selectedIcon, color: iconColor != null? Colors.red : fontColor, size: iconFont),
          Text(
            buttonTitle,
            style: TextStyle(color: textColor != null? Colors.red : fontColor, fontSize: textFont),
          )
        ],
      ),
    );
  }
}
