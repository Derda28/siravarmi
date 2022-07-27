import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/appointment_list_item.dart';
import 'package:siravarmi/widgets/list_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../cloud_functions/dbHelperHttp.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../widgets/slidingUpPanels/appointment_slidingUpPanel.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppointmentState();
  }
}

class _AppointmentState extends State {
  final panelController = PanelController();

  final String lastAppointmentTxt = "Gecmis Randevular";
  final String commingAppointmentTxt = "Gelecek Randevular";

  List appointments = [];

  @override
  void initState() {
    super.initState();
    if(isLoggedIn){
      loadAppointments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn?Scaffold(
      appBar: Appbar(
        label: "Randevular",
        labelHome: "",
        fromHome: false,
      ),
      body: buildSUP(),
      bottomNavigationBar: Navbar(1, context),
    ):
    Scaffold(
      appBar: Appbar(label: "Randevular", fromHome: false, labelHome: ""),
      body: Text("Giris Yapin"),
      bottomNavigationBar: Navbar(1, context),
    );
  }

  buildSUP() {
    return SlidingUpPanel(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildComingTxt(),
            buildComingAppointment(),
            buildLastTxt(),
            buildLastAppointments(),
          ],
        ),
      ),
      backdropEnabled: true,
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      maxHeight: 650,
      minHeight: 0,
      controller: panelController,
      /*body: _body(),*/
      panelBuilder: (sc) => AppointmentSlidingUpPanel(
        scrollController: sc,
      ),
    );
  }

  buildComingTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          margin: EdgeInsets.only(left: getSize(25), bottom: getSize(5)),
          child: Text(
            commingAppointmentTxt,
            style: TextStyle(
                color: fontColor,
                fontFamily: primaryFontFamily,
                fontSize: getSize(18)),
          ),
        ),
      ],
    );
  }

  buildComingAppointment() {
    return SizedBox(
      height: getSize(65 * 2),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: getSize(5)),
            child: AppointmentListItem(
              itemHeigth: 60,
              itemWidth: 350,
              itemBgColor: Colors.white,
              profileHeigth: 50,
              profileWidth: 50,
              title: "S.A.",
              location: "Istanbul",
              minPrice: 50,
              assessmentTxt: "3,9 (+199)",
              date: "Yarin",
              time: "15:30",
              profileURL: 'http://dummyimage.com/217x156.png/ff4444/ffffff',
              panelController: panelController,
            ),
          );
        },
      ),
    );
  }

  buildLastTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          margin: EdgeInsets.only(left: getSize(25), top: getSize(10), bottom: getSize(5)),
          child: Text(
            lastAppointmentTxt,
            style: TextStyle(
                color: fontColor,
                fontFamily: primaryFontFamily,
                fontSize: getSize(18)),
          ),
        ),
      ],
    );
  }

  buildLastAppointments() {
    return SizedBox(
      height: getSize(65 * 15),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: getSize(5)),
            child: AppointmentListItem(
              itemHeigth: 60,
              itemWidth: 350,
              itemBgColor: Colors.white,
              profileHeigth: 50,
              profileWidth: 50,
              title: "S.A.",
              location: "Istanbul",
              minPrice: 50,
              assessmentTxt: "3,9 (+199)",
              date: "Yarin",
              time: "15:30",
              profileURL: 'http://dummyimage.com/217x156.png/ff4444/ffffff',
              panelController: panelController,
            ),
          );
        },
      ),
    );
  }

  Future<void> loadAppointments() async{
    DbHelperHttp dbHelper = DbHelperHttp();
    final appointmentsData = dbHelper.getAppointmentList(user.id!);

    appointments = await appointmentsData;
    setState((){
      appointments = appointments;
    });
    print(appointments.length);
  }

}
