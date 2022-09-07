import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/list_items/appointment_list_item.dart';
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
  List<AppointmentModel> comingAppointments = [];
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
    if (isLoggedIn) {
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
    return isLoggedIn
        ? Scaffold(
            appBar: Appbar(
              label: "Randevular",
              labelHome: "",
              fromHome: false,
            ),
            body: buildSUP(),
            bottomNavigationBar: Navbar(1, context),
          )
        : Scaffold(
            appBar: Appbar(label: "Randevular", fromHome: false, labelHome: ""),
            body: Text("Giris Yapin"),
            bottomNavigationBar: Navbar(1, context),
          );
  }

  buildSUP() {
    return areAppointmentsLoaded
        ? SlidingUpPanel(
            panelSnapping: false,
            isDraggable: false,
            backdropOpacity: 0.5,
            header: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              ),
              height: getSize(50),
              width: screenWidth,
              child: Container(
                margin: EdgeInsets.only(top: getSize(5)),
                alignment: Alignment.center,
                child: Text(
                  isLastAppointment?"Geçmiş Randevu": "Gelecek Randevu",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset(0, -6))
                    ],
                    color: Colors.transparent,
                    fontSize: getSize(28),
                    decoration:
                    TextDecoration.underline,
                    decorationColor: secondaryColor,
                    decorationThickness: 1,
                    decorationStyle:
                    TextDecorationStyle.dashed,
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                //buildComingTxt(),
                buildComingAppointment(),
                //buildLastTxt(),
                //buildLastAppointments(),
              ],
            ),
            backdropEnabled: true,
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            maxHeight: getSize(500),
            minHeight: 0,
            controller: panelController,
            /*body: _body(),*/
            panelBuilder: (sc) => AppointmentSlidingUpPanel(
              scrollController: sc,
              isLastAppointment: isLastAppointment,
              appointment: selectedAppointment,
              barber: selectedBarber,
              employee: selectedEmployee,
              assessment: selectedAssessment,
            ),
          )
        : Text("Yükleniyor...");
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
    return areAppointmentsLoaded
        ? SizedBox(
            height: getSize(715),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: comingAppointments.length+lastAppointments.length+2,
              itemBuilder: (context, index) {
                if(index==0){
                 return buildComingTxt();
                }
                int index3 = index-1;
                if(index<comingAppointments.length+1){
                  return Padding(
                    padding: EdgeInsets.only(top: getSize(5)),
                    child: AppointmentListItem(
                      date: getDate(comingAppointments[index3].dateTime!),
                      time: getTime(comingAppointments[index3].dateTime!),
                      itemClicked: () {
                        setState(() {
                          isLastAppointment = false;
                        });
                        return itemClicked(index3);
                      },
                      barberModel:
                      getBarberById(comingAppointments[index3].barberId),
                    ),
                  );
                }else{
                  if(index==comingAppointments.length+1){

                  }else{
                    int index2 = (index-comingAppointments.length-2);
                    return Padding(
                      padding: EdgeInsets.only(top: getSize(5)),
                      child: AppointmentListItem(
                        date: getDate(lastAppointments[index2].dateTime!),
                        time: getTime(lastAppointments[index2].dateTime!),
                        itemClicked: () {
                          setState(() {
                            isLastAppointment = true;
                          });
                          return itemClicked(index2);
                        },
                        barberModel:
                        getBarberById(lastAppointments[index2].barberId),
                      ),
                    );
                  }
                  return buildLastTxt();

                }
              },
            ),
          )
        : Text("YÜKLENIYOR...");
  }

  buildLastTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          margin: EdgeInsets.only(
              left: getSize(25), top: getSize(10), bottom: getSize(5)),
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

  Future<void> loadAppointments() async {
    lastAppointments = await appDbHelper.getLastAppointments(user.id!);
    comingAppointments = await appDbHelper.getComingAppointments(user.id!);

    setState(() {
      lastAppointments = lastAppointments;
      comingAppointments = comingAppointments;
      areAppointmentsLoaded = true;
    });
  }

  Future<void> loadBarbers() async {
    /*DbHelperHttp dbHelper = DbHelperHttp();*/
    BarbersDatabase barbersDbHelper = BarbersDatabase();
    final itemsData = barbersDbHelper.getBarbers();
    var result = await itemsData;

    setState(() {
      _barbers = result;
    });
  }

  Future<void> itemClicked(int index) async {
    if (isLastAppointment) {
      selectedAppointment = AppointmentModel(
          userId: lastAppointments[index].userId,
          dateTime: lastAppointments[index].dateTime,
          assessmentId: lastAppointments[index].assessmentId,
          barberId: lastAppointments[index].barberId,
          employeeId: lastAppointments[index].employeeId,
          id: lastAppointments[index].id,
          totalPrice: lastAppointments[index].totalPrice,
          services: lastAppointments[index].services,
          assessmentModel: lastAppointments[index].assessmentModel);
      selectedAssessment = await assDbHelper
          .getAssessmentById(selectedAppointment!.assessmentId!);
    } else {
      selectedAppointment = AppointmentModel(
          userId: comingAppointments[index].userId,
          dateTime: comingAppointments[index].dateTime,
          assessmentId: comingAppointments[index].assessmentId,
          barberId: comingAppointments[index].barberId,
          employeeId: comingAppointments[index].employeeId,
          id: comingAppointments[index].id,
          totalPrice: comingAppointments[index].totalPrice,
          services: comingAppointments[index].services,
          assessmentModel: comingAppointments[index].assessmentModel);
    }
    selectedBarber =
        await barbersDbHelper.getBarberById(selectedAppointment!.barberId!);
    selectedEmployee =
        await empDbHelper.getEmployeeById(selectedAppointment!.employeeId!);
    setState(() {
      selectedAppointment = selectedAppointment;
      selectedAssessment = selectedAssessment;
      selectedEmployee = selectedEmployee;
      selectedBarber = selectedBarber;
    });

    if (panelController.isPanelClosed) {
      panelController.open();
    } else {
      panelController.close();
    }
  }

  getBarberById(int? barberId) {
    BarberModel? res;
    for (var value in _barbers) {
      if (value.id == barberId) {
        res = value;
      }
    }
    return res;
  }
}
