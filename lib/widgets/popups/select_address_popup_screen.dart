import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/search_textinput.dart';
import 'package:siravarmi/widgets/button/select_city_district_btn.dart';

class FilterPopupScreen extends StatefulWidget {
  String whichOne;
  String? selectedCity;
  List<String>? cities;
  List<String>? districts;
  bool isLoaded;

  FilterPopupScreen(
      {Key? key,
      required this.whichOne,
      this.selectedCity,
      this.cities,
      this.districts,
      required this.isLoaded})
      : super(key: key);

  @override
  State<FilterPopupScreen> createState() => _FilterPopupScreenState();
}

class _FilterPopupScreenState extends State<FilterPopupScreen> {
  bool searching = false;

  List<String> citiesListed = [];
  List<String> districtsListed = [];

  @override
  void initState() {
    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: widget.isLoaded
          ? Material(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  buildSearchField(),
                  buildList(context),
                ]),
              ),
            )
          : Text("Data is loading"),
    );
  }

  buildSearchField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: getSize(50),
            width: getSize(300),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0,
                  color: searching ? Colors.blueAccent : fontColor,
                  style: BorderStyle.solid),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(children: [
              Container(
                  margin: EdgeInsets.only(left: getSize(10)),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.search_rounded,
                    color: searching ? Colors.blueAccent : fontColor,
                  )),
              Container(
                margin: EdgeInsets.only(left: getSize(50), bottom: getSize(11)),
                child: TextField(
                  onTap: () {
                    setState(() {
                      searching = true;
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Arama yap',
                      hintStyle: TextStyle(
                        color: fontColor,
                        fontSize: getSize(12),
                      )),
                  style: TextStyle(
                      fontSize: getSize(14), fontFamily: secondaryFontFamily),
                  onChanged: (searchText) {
                    searchFor(searchText);
                  },
                ),
              ),
            ]))
      ],
    );
  }

  buildList(BuildContext context) {
    if (widget.whichOne == "city") {
      return Container(
        height: getSize(300),
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: citiesListed.length,
            itemBuilder: (context, index) =>
                SelectCityDistrictBtn(title: citiesListed[index])),
      );
    } else {
      return Container(
        height: getSize(300),
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: districtsListed.length,
            itemBuilder: (context, index) =>
                SelectCityDistrictBtn(title: districtsListed[index])),
      );
    }
  }

  Future<void> searchFor(String searchText) async {
    setState(() {
      citiesListed.clear();
      districtsListed.clear();
    });


    if (widget.cities != null) {
      for (int i = 0; i < widget.cities!.length; i++) {
        if (widget.cities![i].toLowerCase().contains(searchText)) {
          citiesListed.add(widget.cities![i]);
        }
      }
    }

    if (widget.districts != null) {
      for (int i = 0; i < widget.districts!.length; i++) {
        if (widget.districts![i].toLowerCase().contains(searchText)) {
          districtsListed.add(widget.districts![i]);
        }
      }
    }

    setState(() {
      //update the list
      citiesListed = citiesListed;
      districtsListed = districtsListed;
    });
  }

  void getLists() {
    if (widget.cities != null) {
      setState(() {
        for(var c in widget.cities!){
          citiesListed.add(c);
        }
      });
    }
    if (widget.districts != null) {
      setState(() {
        for(var d in widget.districts!){
          districtsListed.add(d);
        }
      });
    }
  }
}
