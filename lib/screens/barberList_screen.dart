import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/models/employee_model.dart';
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
import '../widgets/search_textinput.dart';
import 'barber_screen.dart';

class BarberListScreen extends StatefulWidget {
  const BarberListScreen({Key? key}) : super(key: key);

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

  List<BarberModel> _barbers = [];




  @override
  void initState() {
    super.initState();
    loadBarbers();
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
    return SearchTextinput();
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
          itemCount: _barbers.length,
          itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: getSize(5)),
                child: ListItem(
                    itemHeigth: 60,
                    itemWidth: 350,
                    profileHeigth: 50,
                    profileWidth: 50,
                    barber: _barbers[index],
                    date: "15/07/2022",
                    time: "15:30"),
              )),
    );
  }

  /*Future<void> loadJson() async {
    final String res =
        await rootBundle.loadString('assets/BarberListExample.json');
    final itemsData = json.decode(res);

    setState(() {
      _items = itemsData['data'];
    });
  }*/

  Future<void> loadBarbers() async{
   /* DbHelperHttp dbHelper = DbHelperHttp();
    final itemsData = dbHelper.getBarberList();
    var items = await itemsData;

    setState((){
      items.forEach((element) {
        _barbers.add(BarberModel(
            id: int.parse(element['id']),
            name: element['name'],
            address: element['location'],
            minPrice: int.parse(element['minPrice']),
            profileURL: element['profileUrl'],
            open: element['open']==1?true:false,
            averageStars: double.parse("${element['averageStars']}"),
            assessmentCount: int.parse("${element['assessmentCount']}"),
        ));
      });
    });*/

    BarbersDatabase barbersDb = BarbersDatabase();
    _barbers = await barbersDb.getBarbers();
    setState((){
      _barbers = _barbers;
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
