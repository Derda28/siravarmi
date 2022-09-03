import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/consts.dart';

class SearchTextinput extends StatefulWidget {
  const SearchTextinput({Key? key}) : super(key: key);

  @override
  State<SearchTextinput> createState() => _SearchTextinputState();
}

class _SearchTextinputState extends State<SearchTextinput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: getSize(50),
            width: getSize(300),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(children: [
              Container(
                  padding: EdgeInsets.only(left: 13, top: 13),
                  child: Icon(
                    Icons.search_rounded,
                    color: fontColor,
                  )),
              Container(
                padding: EdgeInsets.only(left: 50, bottom: 10,right: 50),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Arama yap',
                      hintStyle: TextStyle(
                        color: fontColor,
                        fontSize: getSize(12),
                      )),
                  style:
                  TextStyle(fontSize: getSize(14), fontFamily: secondaryFontFamily),
                ),
              ),
            ]))
      ],
    );
  }


}
