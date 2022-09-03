import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/search_textinput.dart';
import 'package:siravarmi/widgets/button/select_city_district_btn.dart';


class FilterPopupScreen extends StatefulWidget {
  String whichOne;
  String? selectedCity;
  List? cities;
  List? districts;
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
  @override
  void initState() {
    super.initState();
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
                SearchTextinput(),
                buildList(context),
              ]),
            ),
          )
          : Text("Data is loading"),
    );
  }

  buildList(BuildContext context) {
    if (widget.whichOne == "city") {
      return Container(
        height: getSize(300),
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: widget.cities?.length,
            itemBuilder: (context, index) =>
                SelectCityDistrictBtn(title: widget.cities?[index])),
      );
    } else {
      return Container(
        height: getSize(300),
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: widget.districts?.length,
            itemBuilder: (context, index) =>
                SelectCityDistrictBtn(title: widget.districts?[index])),
      );
    }
  }
}
