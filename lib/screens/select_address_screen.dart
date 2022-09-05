import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siravarmi/utilities/consts.dart';

import '../routes/hero_dialog_route.dart';
import '../widgets/button/filter_btn.dart';
import '../widgets/popups/select_address_popup_screen.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectAddressState();
  }
}

class _SelectAddressState extends State {
  IconData iconData = Icons.arrow_drop_down;

  String titleCity = "Sehir";
  String titleDistrict = "Ilce";

  String? countryValue;
  String? selectedCity;
  String? selectedDistrict;
  bool isCitySelected = false;

  Map<String,List<String>> data = {};
  bool isLoaded = false;
  List<String> districts = [];
  List<String> cities = [];



  @override
  void initState() {
    loadJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomSheet: buildConfirmBtn(),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(
        "KONUM SECIMI",
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontFamily: primaryFontFamily),
      ),
      actions: [
        IconButton(
          icon : Icon(Icons.gps_fixed),
          onPressed: (){
            locationBtnIsClicked();
          },
        )
      ],
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      height: 250,
      child: Column(children: [
        OutlinedButton(
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
                        "Türkiye",
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
                        "",
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
                  iconData,
                  color: primaryColor,
                ),
              )
            ],
          ),

        ),
        OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
          side: MaterialStateProperty.all(
            BorderSide(
              color: Colors.transparent,
            ),
          ),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
        ),

        onPressed: (){openCityList(context);},
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      titleCity,
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
                      selectedCity==null?"TÜMÜ":selectedCity!,
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
                iconData,
                color: primaryColor,
              ),
            )
          ],
        ),

      ),
        Visibility(
          visible: isCitySelected,
            child: OutlinedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.2)),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 0)),
              ),

              onPressed: (){openDistrictList(context);},
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            titleDistrict,
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
                            selectedDistrict==null?"TÜMÜ":selectedDistrict!,
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
                      iconData,
                      color: primaryColor,
                    ),
                  )
                ],
              ),

            ),

          ),
        ]
      )
    );
  }

  buildConfirmBtn() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => primaryColor),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => secondaryColor.withOpacity(0.5))),
        onPressed: () {
          confirmBtnIsClicked(context);
        },
        child: Container(
          width: getSize(404),
          height: getSize(50),
          alignment: Alignment.center,
          child: Text(
            "Uygula",
            style: TextStyle(
              fontSize: getSize(16),
              fontFamily: primaryFontFamily,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadJson() async {

    final String resDistricts =
    await rootBundle.loadString('assets/districtList.json');
    final data2 = json.decode(resDistricts);
    List districtsData = data2['data'];

    for(int i=0; i<districtsData.length; i++){
      if(data.containsKey(districtsData[i]["il"])){
        var list = data[districtsData[i]["il"]];
        var realList = list?.toList();
        realList?.add(districtsData[i]['ilce']);
        data[districtsData[i]["il"]] = realList!;
      }else{
        List<String> firstList = [];
        firstList.add(districtsData[i]['ilce']);
        data[districtsData[i]["il"]] = firstList;
      }

    }

    convertCitiesToLists();
    setState((){
      isLoaded = true;
    });
  }

  openDistrictList(BuildContext context) async {
    selectedDistrict = await showDialog(
        context: context,
        builder: (_)=>FilterPopupScreen(
          whichOne: "district",
          selectedCity: selectedCity,
          isLoaded: isLoaded,
          districts: districts,)
    );

    updateSelectedDistrict();
  }

  openCityList(BuildContext context) async {
    selectedCity = await Navigator.push(context,
        HeroDialogRoute(builder: (context)=>FilterPopupScreen(
          whichOne: "city",
          isLoaded: isLoaded,
          cities: cities,)));
    updateSelectedCity();
    makeDistrictBtnVisible();
  }

  void convertCitiesToLists() {
    cities = data.keys.toList();
  }

  void convertDistrictsToList() {
    /*for (int i=0; i<data[selectedCity]!.length; i++) {
      districts[i] = data[selectedCity]!.elementAt(i);
    }*/
    districts = data[selectedCity] as List<String>;
  }

  updateSelectedCity() {
    setState(() {
      selectedCity=selectedCity;
      selectedDistrict=null;
    });
    convertDistrictsToList();
  }

  void makeDistrictBtnVisible() {
    setState((){
      isCitySelected=true;
    });
  }

  updateSelectedDistrict() {
    setState((){
      selectedDistrict=selectedDistrict;
    });
  }

  void confirmBtnIsClicked(BuildContext context) {
    Navigator.pop(context, {'city' : selectedCity, 'district' : selectedDistrict});
  }

  void locationBtnIsClicked() {
    Geolocator
  }



}
