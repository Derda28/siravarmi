import 'package:flutter/material.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/screens/sort_popup_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/custom_rect_tween.dart';
import 'package:siravarmi/widgets/slidingUpPanels/barber_list_sliding_up_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/list_items/list_item.dart';
import '../widgets/search_textinput.dart';

class BarberListScreen extends StatefulWidget {
  const BarberListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BarberListState();
  }
}

class _BarberListState extends State {
  String sortType = "gelismis";
  double _panelHeightOpen = getSize(550);
  final double _panelHeightClosed = 0;
  final panelController = PanelController();

  List<BarberModel> _barbers = [];
  List<ListItem> allListItems = [];
  List<ListItem> listItems = [];

  @override
  void initState() {
    super.initState();
    loadBarbers();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = screenHeight! * 0.35;
    return Scaffold(
        appBar: AppBar(
          title: Text("Sira Var Mi"),
        ),
        body: Stack(
          children: [
            buildSearchBtn(),
            buildFilterBtn(),
            buildList(),
            buildSlidingUpPanel()
          ],
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
                padding: EdgeInsets.only(left: 50, bottom: 10, right: 50),
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
                  onChanged: (searchText) {
                    searchFor(searchText);
                  },
                ),
              ),
            ]))
      ],
    );
  }

  buildFilterBtn() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 75, left: 30),
        child: ElevatedButton(
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.5)),
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
        child: ElevatedButton(
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.5)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide.none,
                ))),
            onPressed: () {
              sortBtnClicked(context);
            },
            child: Icon(Icons.sort, color: primaryColor)),
      ),
    ]);
  }

  buildList() {
    return Padding(
      padding: EdgeInsets.only(
          top: getSize(130),
          bottom: getSize(10),
          left: getSize(30),
          right: getSize(30)),
      child: ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: getSize(5)),
              child: listItems[index],
            );
          }),
    );
  }

  Future<void> loadBarbers() async {
    BarbersDatabase barbersDb = BarbersDatabase();
    _barbers = await barbersDb.getBarbers();
    for (int i = 0; i < _barbers.length; i++) {
      allListItems.add(ListItem(barber: _barbers[i]));
    }
    setState(() {
      _barbers = _barbers;
      listItems = allListItems;
    });
  }

  Future<void> sortBtnClicked(BuildContext context) async {
    final result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => SortPopupScreen(sortType: ''),
    );
    if (result != null) {
      sortType = result as String;
    }
  }

  void filterBtnClicked() {
    if (panelController.isPanelClosed) {
      panelController.open();
    } else {
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
      panelBuilder: (sc) => BarberListSlidingUpPanel(
          controller: sc, panelController: panelController),
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      margin: EdgeInsets.only(left: 30, right: 30),
    );
  }

  Future<void> searchFor(String searchText) async {
    setState(() {
      listItems.clear();
    });
    BarbersDatabase barbersDb = BarbersDatabase();
    String sql =
        "SELECT * FROM barbers WHERE name LIKE '%$searchText%' OR address LIKE '%$searchText%'";
    var result = await barbersDb.getBarberByRawQuery(sql);
    for (var r in result) {
      listItems.add(ListItem(barber: r));
    }
    setState(() {
      listItems = listItems;
    });
  }
}
