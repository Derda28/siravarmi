import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utilities/consts.dart';

class MenuSettingScreen extends StatefulWidget {
  @override
  State<MenuSettingScreen> createState() => _MenuSettingScreenState();
}

class _MenuSettingScreenState extends State<MenuSettingScreen> {
  final lang = ['Tr', 'Eng', 'De'];
  String avoidSlide = "Tr";
  String? value;

  bool _value = false;
  late int specialFontSize;

  int getFontSize(int index) {
    if (index == 0) {
      return 14;
    } else if (index == 1) {
      return 17;
    } else if (index == 2) {
      return 20;
    }
    throw {'asdasd'};
  }

  late List<bool> isSelected;
  void initState() {
    isSelected = [false, true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: wholeMenu(),
      backgroundColor: bgColor,
    );
  }

  wholeMenu() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          height: getSize(60),
          width: getSize(designWidth),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: getSize(15)),
          child: AutoSizeText(
            "Uygulama Ayarları",
            style: TextStyle(fontSize: getSize(22)),
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white),
              height: getSize(60),
              width: designWidth,
              padding: EdgeInsets.only(left: getSize(35)),
              child: Row(
                children: [
                  Container(
                    height: getSize(60),
                    width: getSize(200),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Dil Seçenekleri",
                      maxLines: 1,
                      style: TextStyle(fontSize: getSize(20)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: getSize(5)),
                    margin: EdgeInsets.only(left: getSize(80)),
                    height: getSize(35),
                    width: getSize(80),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: getSize(2), color: Colors.blueGrey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          value: value,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down),
                          items: lang.map(buildMenuLang).toList(),
                          hint: AutoSizeText(avoidSlide,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: primaryColor)),
                          onChanged: (value) =>
                              setState(() => avoidSlide = value!)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: getSize(1),
          thickness: getSize(0.5),
          color: Colors.blueGrey,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          height: getSize(60),
          width: getSize(designWidth),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: getSize(15)),
          child: AutoSizeText(
            textAlign: TextAlign.center,
            "Bildirim Ayarları",
            style: TextStyle(fontSize: getSize(22)),
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white),
              height: getSize(60),
              width: designWidth,
              padding: EdgeInsets.only(left: getSize(35)),
              child: Row(
                children: [
                  Container(
                    height: getSize(60),
                    width: getSize(250),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Bildirimlere izin ver",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: getSize(20)),
                    ),
                  ),
                  Expanded(
                    child: SwitchListTile(
                      value: _value,
                      onChanged: (bool value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Divider(
          height: getSize(1),
          thickness: getSize(0.5),
          color: Colors.blueGrey,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          height: getSize(60),
          width: getSize(designWidth),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: getSize(15)),
          child: Text(
            "Metin Boyutu",
            style: TextStyle(fontSize: getSize(22)),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          height: getSize(90),
          width: getSize(designWidth),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                width: getSize(412),
                alignment: Alignment.center,
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (index) {
                    for (var i = 0; i < isSelected.length; i++) {
                      if (i == index) {
                        isSelected[i] = true;
                      } else {
                        isSelected[i] = false;
                      }
                    }
                    specialFontSize = getFontSize(index);
                    setState(() {});
                  },
                  children: [
                    Text("A", style: TextStyle(fontSize: getSize(12))),
                    Text("A", style: TextStyle(fontSize: getSize(16))),
                    Text("A", style: TextStyle(fontSize: getSize(20)))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  DropdownMenuItem<String> buildMenuLang(String lang) => DropdownMenuItem(
      value: lang,
      child: AutoSizeText(
        lang,
        style: TextStyle(
          fontSize: getSize(16),
          color: primaryColor,
        ),
      ));
}
