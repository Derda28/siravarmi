import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siravarmi/providers/extensions.dart';
import 'package:siravarmi/providers/shared_prefs_provider.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/screens/select_address_screen.dart';
import 'package:siravarmi/screens/sort_popup_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/custom_rect_tween.dart';
import 'package:siravarmi/widgets/search_btn.dart';
import 'package:siravarmi/widgets/slidingUpPanels/barber_list_sliding_up_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/list_item.dart';
import 'barber_screen.dart';

class BarberListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BarberListState();
  }
}

class _BarberListState extends State {
  String sortType = "gelismis";
  double _panelHeightOpen = 550;
  double _panelHeightClosed = 0;
  final panelController = PanelController();

  List _items = [];




  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = screenHeight!*0.35;
    return Scaffold(
        appBar: AppBar(
          title: Text("Sira Var Mi"),
        ),
        body: Stack(
          children: [buildSearchBtn(), buildFilterBtn(), buildList(), buildSlidingUpPanel()],
        ));
  }

  buildSearchBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 50,
            width: screenWidth! * 350 / designWidth,
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
                        fontSize: 12,
                      )),
                  style:
                      TextStyle(fontSize: 14, fontFamily: secondaryFontFamily),
                ),
              ),
            ]))
      ],
    );
  }

  String _heroAddTodo = 'add-todo-hero';

  buildFilterBtn() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 75, left: 30),
        child: ElevatedButton(

            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.5)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide.none,
                ))),
            onPressed: () {
              filterBtnClicked();
            },
            child: Icon(Icons.filter_alt, color: primaryColor)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 75, left: 100),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: ElevatedButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.5)),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ))),
              onPressed: () {
                sortBtnClicked();
              },
              child: Icon(Icons.sort, color: primaryColor)),
        ),
      ),
    ]);
  }

  buildList() {
    return Padding(
      padding: const EdgeInsets.only(top: 130, bottom: 10),
      child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 5),
                child: ListItem(
                    itemHeigth: 60,
                    itemWidth: 350,
                    profileHeigth: 50,
                    profileWidth: 50,
                    profileURL: _items[index]["url"],
                    title: _items[index]["title"],
                    location: _items[index]["location"],
                    minPrice: int.parse(
                        _items[index]["price"].toString().substring(1, 3)),
                    assessmentTxt: "${_items[index]["assessment"]} (+199)",
                    date: _items[index]["date"],
                    time: "15:30"),
              )),
    );
  }

  Future<void> loadJson() async {
    final String res =
        await rootBundle.loadString('assets/BarberListExample.json');
    final itemsData = json.decode(res);

    setState(() {
      _items = itemsData['data'];
    });
  }

  Future<void> sortBtnClicked() async {
    final result = await Navigator.push(context,HeroDialogRoute(builder: (context){
      return SortPopupScreen(sortType: sortType);
    }));
    if(result!=null){
      sortType = result as String;
    }
  }

  void filterBtnClicked() {
    if(panelController.isPanelClosed){
      panelController.open();
    }else{
      panelController.close();
    }
  }

  buildSlidingUpPanel() {
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      backdropEnabled: true,
      padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
      footer: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
          overlayColor: MaterialStateColor.resolveWith((states) => secondaryColor.withOpacity(0.5))
        ),
        onPressed: () {  },
        child: Container(
          width: 250,
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
      panelBuilder: (sc) => BarberListSlidingUpPanel( controller: sc, panelController: panelController),
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)),
      margin: EdgeInsets.only(left: 30,right: 30),
    );
  }
}
