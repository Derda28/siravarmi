import 'package:flutter/material.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/appointment_list_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../cloud_functions/dbHelperHttp.dart';
import '../models/appointment_model.dart';
import '../models/assessment_model.dart';
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
  AssessmentDatabase assDbHelper = AssessmentDatabase();
  BarbersDatabase barbersDbHelper = BarbersDatabase();
  EmployeesDatabase empDbHelper = EmployeesDatabase();

  List<AppointmentModel> appointments = [];
  List<AppointmentModel> commingAppointments = [];
  List<AppointmentModel> lastAppointments = [];

  bool isLastAppointment = true;
  AppointmentModel? selectedAppointment;
  AssessmentModel? selectedAssessment;
  BarberModel? selectedBarber;
  EmployeeModel? selectedEmployee;

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
        appointment: selectedAppointment,
        barber : selectedBarber,
        employee : selectedEmployee,
        assessment : selectedAssessment,
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
    return areAppointmentsLoaded?SizedBox(
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
              date: getDate(commingAppointments[index].dateTime!),
              time: getTime(commingAppointments[index].dateTime!),
              itemClicked: (){
                setState((){
                  isLastAppointment = false;
                });
                return itemClicked(index);
              },
              barberModel: getBarberById(commingAppointments[index].barberId),
            ),
          );
        },
      ),
    ):Text("YÜKLENIYOR...");
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
    return areAppointmentsLoaded?SizedBox(
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
              date: getDate(lastAppointments[index].dateTime!),
              time: getTime(lastAppointments[index].dateTime!),
              itemClicked: (){
                setState((){
                  isLastAppointment = true;
                });
                return itemClicked(index);
              },
              barberModel: getBarberById(lastAppointments[index].barberId),
            ),
          );
        },
      ),
    ):Text("YÜKLENIYOR...");
  }

  Future<void> loadAppointments() async{
    lastAppointments = await appDbHelper.getLastAppointments(user.id!);
    commingAppointments = await appDbHelper.getCommingAppointments(user.id!);

    setState((){
      lastAppointments = lastAppointments;
      commingAppointments = commingAppointments;
      areAppointmentsLoaded = true;
    });
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



  Future<void> itemClicked(int index) async {
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
      selectedAssessment = await assDbHelper.getAssessmentById(selectedAppointment!.assessmentId!);
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
    selectedBarber = await barbersDbHelper.getBarberById(selectedAppointment!.barberId!);
    selectedEmployee = await empDbHelper.getEmployeeById(selectedAppointment!.employeeId!);
    setState(() {
      selectedAppointment = selectedAppointment;
      selectedAssessment = selectedAssessment;
      selectedEmployee = selectedEmployee;
      selectedBarber = selectedBarber;
    });

    if(panelController.isPanelClosed){
      panelController.open();
    }else{
      panelController.close();
    }
  }

  getBarberById(int? barberId) {
    BarberModel? res;
    for(var value in _barbers){
      if(value.id==barberId){
        res = value;
      }
    }
    return res;
  }
}
