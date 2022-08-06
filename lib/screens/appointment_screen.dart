import 'package:flutter/material.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/appointment_list_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../cloud_functions/dbHelperHttp.dart';
import '../models/appointment_model.dart';
import '../models/barber_model.dart';
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
  List<BarberModel> _barbers = [];

  final panelController = PanelController();

  final String lastAppointmentTxt = "Gecmis Randevular";
  final String commingAppointmentTxt = "Gelecek Randevular";

  AppointmentDatabase appDbHelper = AppointmentDatabase();

  List<AppointmentModel> appointments = [];
  List<AppointmentModel> commingAppointments = [];
  List<AppointmentModel> lastAppointments = [];

  bool isLastAppointment = true;
  AppointmentModel? selectedAppointment;
  bool areAppointmentsLoaded = false;

  @override
  void initState() {
    super.initState();
    if(isLoggedIn){
      loadAppointments();
      loadBarbers();
    }
  }

  @override
  void dispose() {
    super.dispose();
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
    return areAppointmentsLoaded?SlidingUpPanel(
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
        isLastAppointment: isLastAppointment,
        appointment: selectedAppointment
      ),
    ):Text("Yükleniyor...");
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
      height: getSize((65 * commingAppointments.length.toDouble())),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: commingAppointments.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: getSize(5)),
            child: AppointmentListItem(
              itemHeigth: 60,
              itemWidth: 350,
              itemBgColor: Colors.white,
              profileHeigth: 50,
              profileWidth: 50,
              title: commingAppointments[index].barberId.toString(),
              location: commingAppointments[index].barberId.toString(),
              minPrice: commingAppointments[index].totalPrice!,
              assessmentTxt: commingAppointments[index].assessmentId.toString(),
              date: getDate(commingAppointments[index].dateTime!),
              time: getTime(commingAppointments[index].dateTime!),
              profileURL: 'http://dummyimage.com/217x156.png/ff4444/ffffff',
              itemClicked: (){
                setState((){
                  isLastAppointment = false;
                });
                return itemClicked(index);
              },
              index: index,
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
      height: getSize(65 * lastAppointments.length.toDouble()),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: lastAppointments.length,

        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: getSize(5)),
            child: AppointmentListItem(
              itemHeigth: 60,
              itemWidth: 350,
              itemBgColor: Colors.white,
              profileHeigth: 50,
              profileWidth: 50,
              title: lastAppointments[index].barberId.toString(),
              location: lastAppointments[index].barberId.toString(),
              minPrice: lastAppointments[index].totalPrice!,
              assessmentTxt: lastAppointments[index].assessmentId.toString(),
              date: getDate(lastAppointments[index].dateTime!),
              time: getTime(lastAppointments[index].dateTime!),
              profileURL: 'http://dummyimage.com/217x156.png/ff4444/ffffff',
              itemClicked: (){
                setState((){
                  isLastAppointment = true;
                });
                return itemClicked(index);
              },
              index: index,
            ),
          );
        },
      ),
    );
  }

  Future<void> loadAppointments() async{
    /*DbHelperHttp dbHelper = DbHelperHttp();
    final appointmentsData = dbHelper.getAppointmentList(user.id!);
    var app = await appointmentsData;

    for(int i=0; i<app.length; i++){
      appointments.add(AppointmentModel(
          userId: int.parse(app[i]["userId"]),
          dateTime: DateTime.parse(app[i]["dateTime"]),
          assessmentId: int.parse(app[i]["assessmentId"]),
          barberId: int.parse(app[i]["barberId"]),
          employeeId: int.parse(app[i]["employeeId"]),
          id: int.parse(app[i]["id"]),
          totalPrice: int.parse(app[i]["totalPrice"]))
      );
    }*/
    final appointmentsResult = await appDbHelper.getAppointments(user.id!);
    appointments = appointmentsResult;
    setState((){
      appointments = appointments;
    });

    sortAppointments();
  }

  Future<void> loadBarbers() async{
    DbHelperHttp dbHelper = DbHelperHttp();
    final itemsData = dbHelper.getBarberList();
    var items = await itemsData;
    print(items[0]["id"]);

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
    });
  }

  sortAppointments(){
    for (var value in appointments) {
      if(value.dateTime!.isAfter(DateTime.now())){
        commingAppointments.add(value);
      }else{
        lastAppointments.add(value);
      }
    }
    setState((){
      areAppointmentsLoaded = true;
    });
  }



  void itemClicked(int index) {
    setState(() {
      if(isLastAppointment){
        selectedAppointment = AppointmentModel(
            userId: lastAppointments[index].userId,
            dateTime: lastAppointments[index].dateTime,
            assessmentId: lastAppointments[index].assessmentId,
            barberId: lastAppointments[index].barberId,
            employeeId: lastAppointments[index].employeeId,
            id: lastAppointments[index].id,
            totalPrice: lastAppointments[index].totalPrice
        );
      }else{
        selectedAppointment = AppointmentModel(
            userId: commingAppointments[index].userId,
            dateTime: commingAppointments[index].dateTime,
            assessmentId: commingAppointments[index].assessmentId,
            barberId: commingAppointments[index].barberId,
            employeeId: commingAppointments[index].employeeId,
            id: commingAppointments[index].id,
            totalPrice: commingAppointments[index].totalPrice
        );
      }

    });

    if(panelController.isPanelClosed){
      panelController.open();
    }else{
      panelController.close();
    }
  }
}
