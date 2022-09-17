import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/cloud_functions/favorites_database.dart';
import 'package:siravarmi/cloud_functions/services_database.dart';
import 'package:siravarmi/cloud_functions/working_hours_database.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/models/service_model.dart';
import 'package:siravarmi/models/working_hours_model.dart';
import 'package:siravarmi/widgets/list_items/comments_list_item.dart';
import 'package:siravarmi/widgets/popups/selected_service_popup_screen.dart';
import 'package:siravarmi/widgets/slidingUpPanels/barber_slidingUpPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/assessment_model.dart';
import '../models/barber_model.dart';
import '../routes/hero_dialog_route.dart';
import '../utilities/consts.dart';
import '../utilities/custom_rect_tween.dart';

class BarberScreen extends StatefulWidget {
  BarberModel barberModel;
  BarberScreen({required this.barberModel, Key? key}) : super(key: key);

  @override
  State<BarberScreen> createState() => _BarberScreenState();
}

class _BarberScreenState extends State<BarberScreen> {
  double profileHeigt = getSize(300);

  final String phoneNumber = "0 (850) 442 15 22";

  String mondayTime = "Yükleniyor...";
  String tuesdayTime = "Yükleniyor...";
  String wednesdayTime = "Yükleniyor...";
  String thursdayTime = "Yükleniyor...";
  String fridayTime = "Yükleniyor...";
  String saturdayTime = "Yükleniyor...";
  String sundayTime = "Yükleniyor...";

  PageController pageController = PageController(initialPage: 0);

  final panelController = PanelController();

  late final ScrollController controller;

  final double right1 = getSize(211),
      right2 = getSize(115),
      right3 = 0,
      left1 = 0,
      left2 = getSize(111),
      left3 = getSize(205);

  double left = 0, right = getSize(211);

  double daysSize = getSize(16);

  double smallContainerWidthSize = getSize(120);
  double bigContainerWidthSize = getSize(332);
  double containerHeightSize = getSize(30);
  double inContainerSize = getSize(14);

  Color serviceColor = Colors.white,
      infosColor = primaryColor,
      commentsColor = primaryColor;

  List<EmployeeModel> employees = [];
  List<AssessmentModel> assessments = [];
  List<ServiceModel> services = [];
  List<ServiceModel> selectedServices = [];

  List<WorkingHoursModel> workingHoursList = [];
  Map<String, WorkingHoursModel> workingHoursInWeek = {};
  bool areWorkingHoursLoaded = false;

  Map<String, List<ServiceModel>> womenServicesByCategories = {};
  Map<String, List<ServiceModel>> menServicesByCategories = {};

  bool isFavorite = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Sira Var Mi"),
        ), //
        body: frontBody(context));
  }

  frontBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.barberModel.profileURL!),
                  fit: BoxFit.cover)),
          height: profileHeigt,
          width: screenWidth,
        ),
        Container(
          margin: EdgeInsets.only(left: getSize(365), top: getSize(10)),
          height: getSize(35),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getSize(20)),
                  bottomLeft: Radius.circular(getSize(20)))),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getSize(20)),
                      bottomLeft: Radius.circular(getSize(20)))),
              padding: EdgeInsets.only(right: getSize(0)),
            ),
            child: isFavorite
                ? Icon(
                    Icons.favorite,
                    size: getSize(30),
                    color: secondaryColor,
                  )
                : Icon(
                    Icons.favorite_border,
                    size: getSize(30),
                    color: primaryColor,
                  ),
            onPressed: () {
              favoriteBtnIsClicked();
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(getSize(100)),
                topLeft: Radius.circular(getSize(100))),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: getSize(20), right: getSize(20)),
          margin: EdgeInsets.only(
              top: getSize(265),
              bottom: getSize(470),
              left: getSize(60),
              right: getSize(60)),
          child: SizedBox(
            child: AutoSizeText(
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
              maxLines: 1,
              widget.barberModel.name!,
              style: TextStyle(
                color: primaryColor,
                fontSize: getSize(34),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: getSize(50), left: getSize(0)),
          height: getSize(25),
          width: getSize(85),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(getSize(20)),
                  bottomRight: Radius.circular(getSize(20)))),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(getSize(20)),
                      bottomRight: Radius.circular(getSize(20)))),
              padding: EdgeInsets.only(left: getSize(10)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star_purple500_sharp,
                  color: secondaryColor,
                  size: getSize(20),
                ),
                Container(
                  margin: EdgeInsets.only(left: getSize(2)),
                  alignment: Alignment.center,
                  height: getSize(25),
                  width: getSize(45),
                  child: Text(
                    "${widget.barberModel.averageStars} (${widget.barberModel.assessmentCount})",
                    style: TextStyle(
                      fontSize: getSize(11),
                      color: primaryColor,
                    ),
                    softWrap: false,
                  ),
                ),
              ],
            ),
            onPressed: () {
              pageController.animateToPage(2,
                  duration: Duration(milliseconds: 100), curve: Curves.ease);
              _toggleThird();
            },
          ),
        ),

        //Menu Toggle

        Padding(
          padding: EdgeInsets.only(top: getSize(335), left: getSize(45)),
          child: Container(
            height: getSize(50),
            width: getSize(325),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(getSize(25))),
                border: Border.all(color: Colors.transparent)),
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  right: right,
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(getSize(25))),
                    ),
                    height: getSize(50),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.all(Radius.circular(getSize(25))),
                      ),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(18))),
                            )),
                        child: Text(
                          "HİZMETLER",
                          style: TextStyle(
                              color: serviceColor, fontSize: getSize(13)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleFirst();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(getSize(18))),
                          ),
                        ),
                        child: Text(
                          "BİLGİLER",
                          style: TextStyle(
                              color: infosColor, fontSize: getSize(13)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleSecond();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(18))),
                            )),
                        child: Text(
                          "YORUMLAR",
                          style: TextStyle(
                              color: commentsColor, fontSize: getSize(13)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleThird();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: getSize(410),
              left: getSize(40),
              right: getSize(40),
              bottom: getSize(60)),
          child: PageView(
            physics: PageScrollPhysics(),
            controller: pageController,
            onPageChanged: (initialPage){
              switch(initialPage){
                case 0:
                  _toggleFirst();
                  break;
                case 1:
                  _toggleSecond();
                  break;
                case 2:
                  _toggleThird();
                  break;
              }
            },
            children: [
              Container(
                height: getSize(50),
                width: getSize(50),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: getSize(15)),
                      child: Container(
                        padding: EdgeInsets.only(),
                        decoration: BoxDecoration(border: Border.all()),
                        child: ExpansionTile(title: Text("ERKEK"), children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                menServicesByCategories.keys.toList().length,
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: getSize(15)),
                              child: Container(
                                padding: EdgeInsets.only(),
                                child: ExpansionTile(
                                  title: Text(menServicesByCategories.keys
                                      .toList()[index]),
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: menServicesByCategories[
                                                menServicesByCategories.keys
                                                    .toList()[index]]
                                            ?.length,
                                        itemBuilder:
                                            (BuildContext context, int index2) {
                                          return ListTile(
                                            title: Text(menServicesByCategories[
                                                    menServicesByCategories.keys
                                                            .toList()[
                                                        index]]![index2]
                                                .name!),
                                            trailing: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    "₺${menServicesByCategories[menServicesByCategories.keys.toList()[index]]![index2].price!.toString()}"),
                                                Checkbox(
                                                  value: menServicesByCategories[
                                                          menServicesByCategories
                                                                  .keys
                                                                  .toList()[
                                                              index]]![index2]
                                                      .selected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (menServicesByCategories[
                                                                  menServicesByCategories
                                                                          .keys
                                                                          .toList()[
                                                                      index]]![index2]
                                                              .selected ==
                                                          true) {
                                                        menServicesByCategories[
                                                                menServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]
                                                            .selected = false;
                                                        selectedServices.remove(
                                                            menServicesByCategories[
                                                                menServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]);
                                                      } else {
                                                        menServicesByCategories[
                                                                menServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]
                                                            .selected = true;
                                                        selectedServices.add(
                                                            menServicesByCategories[
                                                                menServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: getSize(15)),
                      child: Container(
                        padding: EdgeInsets.only(),
                        decoration: BoxDecoration(border: Border.all()),
                        child: ExpansionTile(title: Text("KADIN"), children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                womenServicesByCategories.keys.toList().length,
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: getSize(15)),
                              child: Container(
                                padding: EdgeInsets.only(),
                                child: ExpansionTile(
                                  title: Text(womenServicesByCategories.keys
                                      .toList()[index]),
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: womenServicesByCategories[
                                                womenServicesByCategories.keys
                                                    .toList()[index]]
                                            ?.length,
                                        itemBuilder:
                                            (BuildContext context, int index2) {
                                          return ListTile(
                                            title: Text(
                                                womenServicesByCategories[
                                                        womenServicesByCategories
                                                                .keys
                                                                .toList()[
                                                            index]]![index2]
                                                    .name!),
                                            trailing: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    "₺${womenServicesByCategories[womenServicesByCategories.keys.toList()[index]]![index2].price!.toString()}"),
                                                Checkbox(
                                                  value: womenServicesByCategories[
                                                          womenServicesByCategories
                                                                  .keys
                                                                  .toList()[
                                                              index]]![index2]
                                                      .selected,
                                                  onChanged: (value) => {
                                                    setState(() {
                                                      if (womenServicesByCategories[
                                                                  womenServicesByCategories
                                                                          .keys
                                                                          .toList()[
                                                                      index]]![index2]
                                                              .selected ==
                                                          true) {
                                                        womenServicesByCategories[
                                                                womenServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]
                                                            .selected = false;
                                                        selectedServices.remove(
                                                            womenServicesByCategories[
                                                                womenServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]);
                                                      } else {
                                                        womenServicesByCategories[
                                                                womenServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]
                                                            .selected = true;
                                                        selectedServices.add(
                                                            womenServicesByCategories[
                                                                womenServicesByCategories
                                                                        .keys
                                                                        .toList()[
                                                                    index]]![index2]);
                                                      }
                                                    })
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: getSize(50),
                width: getSize(50),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: getSize(24),
                        width: getSize(332),
                        decoration: BoxDecoration(color: bgColor),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: getSize(5)),
                        child: Text(
                          "Adres Bilgisi",
                          style: TextStyle(
                              fontSize: getSize(18), color: primaryColor),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(color: Colors.white),
                          padding: EdgeInsets.only(bottom: getSize(153)),
                          margin: EdgeInsets.only(top: getSize(24)),
                          child: SizedBox(
                            child: Icon(Icons.map, size: getSize(30)),
                            height: getSize(40),
                            width: getSize(42),
                          )),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding:
                            EdgeInsets.only(top: getSize(2), left: getSize(10)),
                        margin: EdgeInsets.only(
                            top: getSize(24), left: getSize(42)),
                        width: getSize(292),
                        height: getSize(195),
                        child: AutoSizeText(
                          widget.barberModel.addressModel!.getFullAddress(),
                          maxLines: 4,
                          style: TextStyle(fontSize: inContainerSize),
                        ),
                      ),
                      Container(
                        height: getSize(40),
                        width: getSize(250),
                        margin: EdgeInsets.only(
                            top: getSize(112), left: getSize(41)),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              side: BorderSide(color: Colors.transparent)),
                          child: Text(
                            "Haritada Göster",
                            style: TextStyle(
                                fontSize: getSize(16), color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: getSize(40),
                        width: getSize(250),
                        margin: EdgeInsets.only(
                            top: getSize(165), left: getSize(41)),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              side: BorderSide(color: Colors.transparent)),
                          child: Text(
                            phoneNumber,
                            style: TextStyle(
                                fontSize: getSize(16), color: Colors.white),
                          ),
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber(phoneNumber);
                          },
                        ),
                      ),
                      Container(
                        height: getSize(24),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(color: bgColor),
                        margin: EdgeInsets.only(top: getSize(219)),
                        padding: EdgeInsets.only(left: getSize(5)),
                        child: Text(
                          "Çalışma Saatleri",
                          style: TextStyle(
                              fontSize: getSize(18), color: primaryColor),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: getSize(243)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Pazartesi:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(243), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              mondayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(273)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Salı:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(273), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              tuesdayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(303)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Çarşamba:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(303), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              wednesdayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(333)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Perşembe:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(333), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              thursdayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(363)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Cuma:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(363), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              fridayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(393)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Cumartesi:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(393), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              saturdayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getSize(423)),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey)),
                            height: containerHeightSize,
                            width: bigContainerWidthSize,
                            child: Text(
                              "Pazar:",
                              style: TextStyle(fontSize: daysSize),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: getSize(423), left: getSize(232)),
                            alignment: Alignment.center,
                            height: containerHeightSize,
                            width: smallContainerWidthSize,
                            child: Text(
                              sundayTime,
                              style: TextStyle(fontSize: inContainerSize),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: assessments.length,
                itemBuilder: (context, index) {
                  return CommentsListItem(
                    assessment: assessments[index],
                  );
                },
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: primaryColor,
            width: screenWidth,
            height: getSize(50),
            child: Stack(
              children: [
                TextButton(
                  child: Text(
                      style: TextStyle(
                          color: Colors.white, fontSize: getSize(16)),
                      "${selectedServices.length} Hizmet Seçili"),
                  onPressed: () {
                    selectedServiceBtnClicked(context);
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      child: Text(
                        "Randevu Al >",
                        style: TextStyle(
                            color: secondaryColor, fontSize: getSize(16)),
                      ),
                      onPressed: () {
                        appointmentBtnClicked();
                      }),
                )
              ],
            ),
          ),
        ),
        SlidingUpPanel(
          backdropEnabled: true,
          minHeight: 0,
          maxHeight: getSize(300),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(getSize(15)),
              topRight: Radius.circular(getSize(15))),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: getSize(5),
              blurRadius: getSize(10),
            )
          ],
          controller: panelController,
          padding: EdgeInsets.only(
              left: getSize(20), right: getSize(20), top: getSize(20)),
          panelBuilder: (builder) =>
              BarberSlidingUpPanel(employees, selectedServices),
        )
      ],
    );
  }

  void appointmentBtnClicked() {
    if (panelController.isPanelClosed) {
      panelController.open();
    }
  }

  Future<void> selectedServiceBtnClicked(BuildContext context) async {
    final result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CustomDialog(
            selectedServices)); /*Navigator.push(context, HeroDialogRoute(builder: (context) {
      return SelectedServicePopupScreen(selectedServices: selectedServices);
    }));*/
    setState(() {
      if (result != null) {
        selectedServices = result;
        for (var e in menServicesByCategories.keys) {
          for (int i = 0; i < menServicesByCategories[e]!.length; i++) {
            menServicesByCategories[e]![i].selected = false;
          }
        }
        for (var e in womenServicesByCategories.keys) {
          for (int i = 0; i < womenServicesByCategories[e]!.length; i++) {
            womenServicesByCategories[e]![i].selected = false;
          }
        }
        for (var e in selectedServices) {
          if (e.gender!) {
            menServicesByCategories[e.category]![
                    menServicesByCategories[e.category]!.indexOf(e)]
                .selected = true;
          }
        }
      }
    });
  }

  void _toggleFirst() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left = left1;
      right = right1;
      serviceColor = Colors.white;
      infosColor = primaryColor;
      commentsColor = primaryColor;
      timer.cancel();
      setState(() {});
    });
  }

  void _toggleSecond() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left = left2;
      right = right2;
      serviceColor = primaryColor;
      infosColor = Colors.white;
      commentsColor = primaryColor;
      timer.cancel();
      setState(() {});
    });
  }

  void _toggleThird() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left = left3;
      right = right3;
      serviceColor = primaryColor;
      infosColor = primaryColor;
      commentsColor = Colors.white;
      timer.cancel();
      setState(() {});
    });
  }

  Future<void> loadData() async {
    AssessmentDatabase assDb = AssessmentDatabase();
    EmployeesDatabase empDb = EmployeesDatabase();
    ServicesDatabase servicesDb = ServicesDatabase();
    WorkingHoursDatabase wHDb = WorkingHoursDatabase();

    final assessmentResult = await assDb.getAssessments();
    getAssessmentOnlyForThisBarber(assessmentResult);

    final employeeResult =
        await empDb.getEmployeesFromBarber(widget.barberModel.id!);
    setState(() {
      employees = employeeResult;
    });

    final servicesResult = await servicesDb.getServices();
    getServicesOnlyForThisBarber(servicesResult);

    final workingHoursResult =
        await wHDb.getWorkingHourByBarberId(widget.barberModel.id!);
    placingTheWorkingHours(workingHoursResult);

    checkIfFavorite();
  }

  void getAssessmentOnlyForThisBarber(List<AssessmentModel> result) {
    for (var element in result) {
      if (element.barberId == widget.barberModel.id) {
        assessments.add(element);
      }
    }
    setState(() {
      assessments = assessments;
    });
  }

  void getServicesOnlyForThisBarber(List<ServiceModel> result) {
    for (var element in result) {
      if (element.barberId == widget.barberModel.id) {
        services.add(element);
      }
    }

    for (var element in services) {
      if (element.gender!) {
        if (!menServicesByCategories.containsKey(element.category)) {
          element.selected = false;
          List<ServiceModel> thisList = [element];
          menServicesByCategories[element.category!] = thisList;
        } else {
          element.selected = false;
          menServicesByCategories[element.category]?.add(element);
        }
      } else {
        if (!womenServicesByCategories.containsKey(element.category)) {
          element.selected = false;
          List<ServiceModel> thisList = [element];
          womenServicesByCategories[element.category!] = thisList;
        } else {
          element.selected = false;
          womenServicesByCategories[element.category]?.add(element);
        }
      }
    }
  }

  void placingTheWorkingHours(List<WorkingHoursModel> workingHoursResult) {
    setState(() {
      workingHoursList = workingHoursResult;
      for (var w in workingHoursResult) {
        if (w.type == "shp") {
          workingHoursInWeek[w.day!] = w;
        }
      }
      areWorkingHoursLoaded = true;
    });

    writingDownWorkingHours();
  }

  void writingDownWorkingHours() {
    setState(() {
      mondayTime = formateTime(workingHoursInWeek['mon']!.open!.hour,
              workingHoursInWeek['mon']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['mon']!.close!.hour,
              workingHoursInWeek['mon']!.open!.minute);
      tuesdayTime = formateTime(workingHoursInWeek['tue']!.open!.hour,
              workingHoursInWeek['tue']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['tue']!.close!.hour,
              workingHoursInWeek['tue']!.open!.minute);
      wednesdayTime = formateTime(workingHoursInWeek['wed']!.open!.hour,
              workingHoursInWeek['wed']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['wed']!.close!.hour,
              workingHoursInWeek['wed']!.open!.minute);
      thursdayTime = formateTime(workingHoursInWeek['thu']!.open!.hour,
              workingHoursInWeek['thu']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['thu']!.close!.hour,
              workingHoursInWeek['thu']!.open!.minute);
      fridayTime = formateTime(workingHoursInWeek['fri']!.open!.hour,
              workingHoursInWeek['fri']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['fri']!.close!.hour,
              workingHoursInWeek['fri']!.open!.minute);
      saturdayTime = formateTime(workingHoursInWeek['sat']!.open!.hour,
              workingHoursInWeek['sat']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['sat']!.close!.hour,
              workingHoursInWeek['sat']!.open!.minute);
      sundayTime = formateTime(workingHoursInWeek['sun']!.open!.hour,
              workingHoursInWeek['sun']!.open!.minute) +
          " - " +
          formateTime(workingHoursInWeek['sun']!.close!.hour,
              workingHoursInWeek['sun']!.open!.minute);
    });
  }

  Future<void> checkIfFavorite() async {
    isFavorite = await isBarberFavorite(widget.barberModel.id!);
    setState(() {
      isFavorite = isFavorite;
    });
  }

  void favoriteBtnIsClicked() {
    //BURADAN DEVAAAAAAMMM
    FavoritesDatabase favDb = FavoritesDatabase();
    favDb.negateIt(widget.barberModel.id!);
    setState(() {
      isFavorite = !isFavorite;
    });
  }
}

class CustomDialog extends StatefulWidget {
  final List<ServiceModel> selectedServicesPop = [];

  CustomDialog(List<ServiceModel> selectedServices, {Key? key})
      : super(key: key) {
    for (var i in selectedServices) {
      selectedServicesPop.add(i);
    }
  }

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Secili Hizmetler",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: primaryFontFamily,
                    color: primaryColor),
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: widget.selectedServicesPop.length,
                  itemBuilder: (context, index) => OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => secondaryColor),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.selectedServicesPop.remove(widget
                                  .selectedServicesPop[
                              index]); //TODO: Service becomes -1 even if cancled
                        });
                      },
                      child: ListTile(
                        title: Text(
                          (index + 1).toString() +
                              ". ${widget.selectedServicesPop[index].name}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: secondaryFontFamily,
                              color: Colors.white),
                        ),
                        trailing: Text(
                          "₺${widget.selectedServicesPop[index].price}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: secondaryFontFamily,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: Text("IPTAL")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, widget.selectedServicesPop);
                      },
                      child: Text("TAMAM")),
                ],
              )
            ],
          )),
    );
  }
}

const String _heroselectedService = "selected-service-hero";
