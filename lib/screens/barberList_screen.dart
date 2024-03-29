import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siravarmi/cloud_functions/address_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/screens/select_address_screen.dart';
import 'package:siravarmi/widgets/popups/sort_popup_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/list_items/list_item.dart';
import '../widgets/popups/near_me_popup_screen.dart';
import '../widgets/popups/price_filter_popup_screen.dart';

class BarberListScreen extends StatefulWidget {
  String whichBtn;
  BarberListScreen( {Key? key, required this.whichBtn}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BarberListState();
  }
}

class _BarberListState extends State<BarberListScreen> {
  String sortType = "Tarihe göre<";
  final double _panelHeightOpen = getSize(320);
  final double _panelHeightClosed = 0;
  final panelController = PanelController();
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<BarberModel> _barbers = [];
  List<ListItem> allListItems = [];
  List<ListItem> listItems = [];

  double? distance;
  int? minPrice;
  int? maxPrice;
  String? district;
  String? city;
  bool dataAreLoaded = false;


  _BarberListState();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkFromWhichBtn();
    loadBarbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sira Var Mi"),
        ),
        body: Stack(
          children: [
            buildSearchBtn(),
            buildFilterBtn(),
            buildList(),
            buildSlidingUpPanel(context)
          ],
        ));
  }

  buildSearchBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: getSize(50),
            width: getSize(350),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
                children: [
              Container(
                margin: EdgeInsets.only(left: getSize(10)),
                alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.search_rounded,
                    color: fontColor,
                  )),
              Container(
                margin: EdgeInsets.only(left: getSize(50), bottom: getSize(11)),
                child: TextField(
                  focusNode: focusNode,
                  controller: searchTextController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Arama yap',
                      hintStyle: TextStyle(
                        color: fontColor,
                        fontSize: getSize(12),
                      )),
                  style:
                  TextStyle(fontSize: getSize(14), fontFamily: secondaryFontFamily),
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
    return dataAreLoaded?Padding(
      padding: EdgeInsets.only(
          top: getSize(150),
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
    ):Text("Loading");
  }

  Future<void> loadBarbers() async {
    BarbersDatabase barbersDb = BarbersDatabase();
    AddressDatabase addressDb = AddressDatabase();
    _barbers = await barbersDb.getBarbers();

    for (int i = 0; i < _barbers.length; i++) {
      var result = await addressDb.getAddressFromBarber(_barbers[i].id!);
      if(result.id != 0){
        setState(() {
          _barbers[i].setAddress(result);
        });
      }
      allListItems.add(ListItem(barber: _barbers[i]));
    }
    setState(() {
      _barbers = _barbers;
      listItems = allListItems;
      dataAreLoaded = true;
    });

    if(dataAreLoaded){
      sortTheList();
    }
  }

  Future<void> sortBtnClicked(BuildContext context) async {
    final result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => SortPopupScreen(sortType: sortType),
    );
    if (result != null) {
      sortType = result as String;
    }

    if(dataAreLoaded){
      sortTheList();
    }
  }

  void filterBtnClicked() {
    if (panelController.isPanelClosed) {
      panelController.open();
    } else {
      panelController.close();
    }
  }

  buildSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      backdropEnabled: true,
      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
      panelBuilder: (sc) => buildBodyOfSUP(context),
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      margin: EdgeInsets.only(left: 30, right: 30),
    );
  }

  Future<void> searchFor(String searchText) async {
    setState(() {
      listItems.clear();
    });
    BarbersDatabase barbersDb = BarbersDatabase();
    String sql =
        "SELECT * FROM barbers WHERE name LIKE '%$searchText%' OR location LIKE '%$searchText%'";
    var result = await barbersDb.getBarberByRawQuery(sql);
    for (var r in result) {
      listItems.add(ListItem(barber: r));
    }
    setState(() {
      listItems = listItems;
    });
  }

  buildBodyOfSUP(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        //Title
        Text(
          "Secenekler",
          style: TextStyle(
            fontSize: 16,
            fontFamily: primaryFontFamily,
            color: fontColor,
          ),
        ),
        Divider(
          color: secondaryColor,
          thickness: 1,
        ),
        //Near Me Button
        OutlinedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            nearMeBtnClicked(context);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Yakinimda Ara",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        distance == null
                            ? "Kapali - Tüm Mesafeler"
                            : "$distance KM ye kadar",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              )
            ],
          ),
        ),
        //Select Address Button
        OutlinedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            selectAddressIsClicked();
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Adres",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        district==null && city==null? "Türkiye" : district==null&&city!=null?"$city" : "$district / $city",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              )
            ],
          ),
        ),
        //Price Button
        OutlinedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.2)),
            side: MaterialStateProperty.all(
              BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(left: 0)),
          ),
          onPressed: () {
            priceBtnClicked(context);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Fiyat",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        minPrice == null && maxPrice == null
                            ? "TÜMÜ"
                            : minPrice == null && maxPrice != null
                                ? "max. $maxPrice ₺"
                                : minPrice != null && maxPrice == null
                                    ? "min. $minPrice ₺"
                                    : "$minPrice ₺ - $maxPrice ₺",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: secondaryFontFamily,
                            color: fontColor),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 5, top: 7.5),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getSize(20),
        ),
        //Confirm Button
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => primaryColor),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => secondaryColor.withOpacity(0.5))),
          onPressed: () {
            confirmBtnIsClicked(context);
          },
          child: Container(
            width: getSize(250),
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
      ],
    );
  }

  Future<void> nearMeBtnClicked(BuildContext context) async {
    final result =
        await showDialog(context: context, builder: (_) => NearMePopupScreen());

    setState(() {
      distance = result;
    });
  }

  Future<void> priceBtnClicked(BuildContext context) async {
    final result = await showDialog(
        context: context, builder: (_) => const PriceFilterPopupScreen());

    if (result != null) {
      setState(() {
        minPrice = int.tryParse(result['min']);
        maxPrice = int.tryParse(result['max']);
      });
    }
  }

  Future<void> selectAddressIsClicked() async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectAddressScreen()));

    if (result != null) {
      if (result['city'] != null && result['district'] != null) {
        setState(() {
          district = result['district'];
          city = result['city'];
        });
      } else if (result['city'] != null && result['district'] == null) {
        setState(() {
          city = result['city'];
          district = null;
        });
      } else {
        setState(() {
          city = null;
          district = null;
        });
      }
    }
  }

  Future<void> confirmBtnIsClicked(BuildContext context) async {
    BarbersDatabase barbersDb = BarbersDatabase();
    String sql = "";

    if (minPrice != null &&
        maxPrice != null) {
      //List all barbers which minPrices are minimum $minPrice AND maximum $maxPrice
      sql =
          "SELECT * FROM `barbers` WHERE minPrice<=$maxPrice AND minPrice>=$minPrice";
    } else if (minPrice != null &&
        maxPrice == null) {
      //List all barbers which minPrices are minimum $minPrice
      sql = "SELECT * FROM `barbers` WHERE minPrice>=$minPrice";
    } else if (minPrice == null &&
        maxPrice != null) {
      //List all barbers which minPrices are maximum $maxPrice
      sql = "SELECT * FROM `barbers` WHERE minPrice<=$maxPrice";
    } else {
      //List all barbers without filter
      sql = "SELECT * FROM `barbers`";
    }

    var result = await barbersDb.getBarberByRawQuery(sql);
    listItems.clear();
    for (var r in result) {
      listItems.add(ListItem(barber: r));
    }

    checkIfAddressIsNull();
  }

  void checkIfAddressIsNull() {
    List<ListItem> listForAddressFilter = [];
    for(var item in listItems){
      listForAddressFilter.add(item);
    }

    setState(() {
      listItems.clear();
    });

    if(city!=null&&district!=null){
      for(var l in listForAddressFilter){
        if(l.barber.addressModel!.city!.toUpperCase()==city&&l.barber.addressModel!.district!.toUpperCase()==district){
          listItems.add(l);
        }
      }
    }else if(city!=null&&district==null){
      for(var l in listForAddressFilter){
        print("selectedCity : $city  barberCity : ${l.barber.addressModel!.city}");
        if(l.barber.addressModel!.city!.toUpperCase()==city){
          listItems.add(l);
        }
      }
    }else if(city==null&&district!=null){
      for(var l in listForAddressFilter){
        if(l.barber.addressModel!.district!.toUpperCase()==district){
          listItems.add(l);
        }
      }
    }else{
      for(var l in listForAddressFilter){
        listItems.add(l);
      }
    }


    checkIfLocationIsNull();
  }

  Future<void> checkIfLocationIsNull() async {
    if (distance != null) {
      //GET LOCATION AND GET ONLY BARBERS IN DISTANCE KM
      Position? position = await getLocation();
      if(position!=null){
        //40.694597, 29.510561
        /*double salonAsLat = 40.694597;
        double salonAsLong = 29.510561;*/

        //String myAddress = "merkez mahallesi esentepe caddesi no 15 altinova yalova";

        List<ListItem> listForDistanceFilter = [];
        for(var item in listItems){
          listForDistanceFilter.add(item);
        }

        setState(() {
          listItems.clear();
        });

        for(var b in listForDistanceFilter){
          List<Location> locations = await locationFromAddress(b.barber.addressModel!.getFullAddress());
          double distance2 = Geolocator.distanceBetween(position.latitude, position.longitude, locations[0].latitude, locations[0].longitude);
          distance2 = distance2/1000;

          if(distance2<=distance!){
            listItems.add(ListItem(barber: b.barber));
          }
        }

        /*final double meter = Geolocator.distanceBetween(
            position.latitude, position.longitude, salonAsLat, salonAsLong);

        final double km = meter/1000;*/
      }
    }

    setState(() {
      listItems=listItems;
    });
    panelController.close();
  }

  Future<void> sortTheList() async {
    BarbersDatabase barbersDb = BarbersDatabase();
    String sql = "";
    switch(sortType){
      case "Tarihe göre<":
        sql = "SELECT * FROM barbers ORDER BY id DESC";
        break;
      case "Tarihe göre>":
        sql = "SELECT * FROM barbers ORDER BY id ASC";
        break;
      case "Fiyata göre<":
        sql = "SELECT * FROM barbers ORDER BY minPrice ASC";
        break;
      case "Fiyata göre>":
        sql = "SELECT * FROM barbers ORDER BY minPrice DESC";
        break;
      case "Degerlendirmeye göre>":
        sql = "SELECT * FROM barbers ORDER BY averageStars DESC";
        break;
      case "Degerlendirmeye göre<":
        sql = "SELECT * FROM barbers ORDER BY averageStars ASC";
        break;
    }
    var result = await  barbersDb.getBarberByRawQuery(sql);
    listItems.clear();
    for(var r in result){
      listItems.add(ListItem(barber: r));
    }
    setState(() {
      listItems = listItems;
    });
  }

  void checkFromWhichBtn() {
    if(widget.whichBtn=="search"){
      focusNode.requestFocus();
    }
  }


}
