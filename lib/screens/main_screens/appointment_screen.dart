import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/address_database.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/list_items/appointment_list_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../cloud_functions/dbHelperHttp.dart';
import '../../models/appointment_model.dart';
import '../../models/assessment_model.dart';
import '../../models/barber_model.dart';
import '../../utilities/custom_screen_route.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import '../../widgets/slidingUpPanels/appointment_slidingUpPanel.dart';
import 'home_screen.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppointmentState();
  }
}

class _AppointmentState extends State {
  List<BarberModel> _barbers = [];

  final panelController = PanelController();

  final String pastAppointmentTxt = "Gecmis Randevular";
  final String comingAppointmentTxt = "Gelecek Randevular";

  AppointmentDatabase appDbHelper = AppointmentDatabase();
  AssessmentDatabase assDbHelper = AssessmentDatabase();
  BarbersDatabase barbersDbHelper = BarbersDatabase();
  EmployeesDatabase empDbHelper = EmployeesDatabase();

  List<AppointmentModel> appointments = [];
  List<AppointmentModel> comingAppointments = [];
  List<AppointmentModel> pastAppointments = [];

  bool isPastAppointment = true;
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await onBackPressed(context);
        return true;
      },
      child: isLoggedIn
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
              appBar:
                  Appbar(label: "Randevular", fromHome: false, labelHome: ""),
              body: Text("Giris Yapin"),
              bottomNavigationBar: Navbar(1, context),
            ),
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
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              height: getSize(50),
              width: screenWidth,
              child: Container(
                margin: EdgeInsets.only(top: getSize(5)),
                alignment: Alignment.center,
                child: Text(
                  isPastAppointment ? "Geçmiş Randevu" : "Gelecek Randevu",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: Colors.white, offset: Offset(0, -6))
                    ],
                    color: Colors.transparent,
                    fontSize: getSize(28),
                    decoration: TextDecoration.underline,
                    decorationColor: secondaryColor,
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
              ),
            ),
            body: buildAppointmentList(),
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
              isLastAppointment: isPastAppointment,
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
            comingAppointmentTxt,
            style: TextStyle(
                color: fontColor,
                fontFamily: primaryFontFamily,
                fontSize: getSize(18)),
          ),
        ),
      ],
    );
  }

  buildAppointmentList() {
    return areAppointmentsLoaded
        ? RefreshIndicator(
            onRefresh: refreshList,
            child: comingAppointments.isEmpty && pastAppointments.isEmpty
                ? getNoAppointmentText()
                : SizedBox(
                    height: getSize(715),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: comingAppointments.isNotEmpty &&
                                pastAppointments.isNotEmpty
                            ? comingAppointments.length +
                                pastAppointments.length +
                                2
                            : comingAppointments.isNotEmpty &&
                                    pastAppointments.isEmpty
                                ? comingAppointments.length + 1
                                : comingAppointments.isEmpty &&
                                        pastAppointments.isNotEmpty
                                    ? pastAppointments.length + 1
                                    : 0,
                        itemBuilder: (c, index) => getItemBuilder(c, index),
                      ),
                    ),
                  ),
          )
        : Text("YÜKLENIYOR...");
  }

  buildPastTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          margin: EdgeInsets.only(
              left: getSize(25), top: getSize(10), bottom: getSize(5)),
          child: Text(
            pastAppointmentTxt,
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
    pastAppointments = await appDbHelper.getLastAppointments(user.id!);
    comingAppointments = await appDbHelper.getComingAppointments(user.id!);

    if (mounted) {
      setState(() {
        pastAppointments = pastAppointments;
        comingAppointments = comingAppointments;
      });
    }
  }

  Future<void> loadBarbers() async {
    /*DbHelperHttp dbHelper = DbHelperHttp();*/
    BarbersDatabase barbersDbHelper = BarbersDatabase();
    AddressDatabase addressDb = AddressDatabase();
    final itemsData = barbersDbHelper.getBarbers();
    var result = await itemsData;

    for(int i=0; i<result.length; i++){
      var result2 = await addressDb.getAddressFromBarber(result[i].id!);
      if(result2.id != 0){
        setState(() {
          result[i].setAddress(result2);
        });
      }
    }

    setState(() {
      _barbers = result;
      areAppointmentsLoaded = true;
    });
  }

  Future<void> itemClicked(int index) async {
    if (isPastAppointment) {
      selectedAppointment = AppointmentModel(
          userId: pastAppointments[index].userId,
          dateTime: pastAppointments[index].dateTime,
          assessmentId: pastAppointments[index].assessmentId,
          barberId: pastAppointments[index].barberId,
          employeeId: pastAppointments[index].employeeId,
          id: pastAppointments[index].id,
          totalPrice: pastAppointments[index].totalPrice,
          services: pastAppointments[index].services,
          assessmentModel: pastAppointments[index].assessmentModel);
      if (pastAppointments[index].assessmentId != null) {
        selectedAssessment = await assDbHelper
            .getAssessmentById(selectedAppointment!.assessmentId!);
      }
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

  Widget getItemBuilder(BuildContext c, int index) {
    //If the user has coming and past appointments
    if (comingAppointments.isNotEmpty && pastAppointments.isNotEmpty) {
      if (index == 0) {
        return buildComingTxt();
      } else if (index < comingAppointments.length + 1) {
        int index2 = index - 1;
        return AppointmentListItem(
          date: formateDate(comingAppointments[index2].dateTime!),
          time: formateTimeFromDateTime(comingAppointments[index2].dateTime!),
          itemClicked: () {
            setState(() {
              isPastAppointment = false;
            });
            return itemClicked(index2);
          },
          barberModel: getBarberById(comingAppointments[index2].barberId!),
        );
      } else if (index == comingAppointments.length + 1) {
        return buildPastTxt();
      } else {
        int index3 = index - comingAppointments.length - 2;
        return AppointmentListItem(
          date: formateDate(pastAppointments[index3].dateTime!),
          time: formateTimeFromDateTime(pastAppointments[index3].dateTime!),
          itemClicked: () {
            setState(() {
              isPastAppointment = true;
            });
            return itemClicked(index3);
          },
          barberModel: getBarberById(pastAppointments[index3].barberId!),
        );
      }
    }
    //If the user has only coming appointments
    else if (comingAppointments.isNotEmpty && pastAppointments.isEmpty) {
      if (index == 0) {
        return buildComingTxt();
      } else {
        int index2 = index - 1;
        return AppointmentListItem(
          date: formateDate(comingAppointments[index2].dateTime!),
          time: formateTimeFromDateTime(comingAppointments[index2].dateTime!),
          itemClicked: () {
            isPastAppointment = false;
            return itemClicked(index2);
          },
          barberModel: getBarberById(comingAppointments[index2].barberId!),
        );
      }
    }
    //If the user has only past appointments
    else if (comingAppointments.isEmpty && pastAppointments.isNotEmpty) {
      if (index == 0) {
        return buildPastTxt();
      } else {
        int index2 = index - 1;
        return AppointmentListItem(
          date: formateDate(pastAppointments[index2].dateTime!),
          time: formateTimeFromDateTime(pastAppointments[index2].dateTime!),
          itemClicked: () {
            isPastAppointment = true;
            return itemClicked(index2);
          },
          barberModel: getBarberById(pastAppointments[index2].barberId!),
        );
      }
    }
    //If the user has no appointments
    else {
      return const Text("");
    }
  }

  Widget getNoAppointmentText() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          alignment: Alignment.center,
          child: Text(
            "Randevunuz yok :(",
            style: TextStyle(),
          ),
        ),
      ),
    );
  }

  Future refreshList() async {
    await appDbHelper.deleteTables();
    await appDbHelper.getAppointmentsFromMySql(user.id!);
    await loadAppointments();
  }

  onBackPressed(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, CustomScreenRoute(child: HomeScreen()));
    });
  }
}
