import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/working_hours_database.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/popups/select_barber_popup_screen.dart';
import 'package:siravarmi/widgets/popups/time_list_popup.dart';

import '../../models/appointment_model.dart';
import '../../models/employee_model.dart';
import '../../models/service_model.dart';
import '../../models/time_of_day_model.dart';
import '../../models/working_hours_model.dart';

final String _heroSelectBarber = "select-barber-hero";

class BarberSlidingUpPanel extends StatefulWidget {
  List<EmployeeModel> employees = [];
  List<ServiceModel> selectedServices = [];
  BarberSlidingUpPanel(List<EmployeeModel> employees, List<ServiceModel> services) {
    for (var e in employees) {
      this.employees.add(e);
    }
    for(var s in services){
      selectedServices.add(s);
    }
  }

  @override
  State<BarberSlidingUpPanel> createState() => _BarberSlidingUpPanelState();
}

class _BarberSlidingUpPanelState extends State<BarberSlidingUpPanel> {
  DateTime? date;
  TimeOfDay? time;
  EmployeeModel? selectedEmployee;

  List<TimeOfDayModel> selectableTimesForAppointment = [];
  List<AppointmentModel> appointmentsOfDay = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Randevu Oluştur",
              style: TextStyle(
                  fontSize: getSize(24),
                  fontFamily: primaryFontFamily,
                  color: primaryColor,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
        Divider(
          height: getSize(20),
        ),
        Padding(
          padding: EdgeInsets.only(left: getSize(10), top: getSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Berber Seç",
                style: TextStyle(
                  fontSize: getSize(22),
                  fontFamily: primaryFontFamily,
                  color: primaryColor,
                ),
              ),

              Container(
                height: getSize(35),
                width: getSize(205),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                  ),
                  onPressed: () {
                    selectBarberClicked(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/BarberIcon2.png",
                        color: primaryColor,
                        scale: getSize(0.1),
                      ),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(0),
                      ),
                      AutoSizeText(
                        selectedEmployee == null
                            ? "Farketmez"
                            : selectedEmployee!.name!,
                        style: TextStyle(
                            fontSize: getSize(18),
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      ),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(5),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: getSize(10), top: getSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarih Seç",
                style: TextStyle(
                  fontSize: getSize(22),
                  fontFamily: primaryFontFamily,
                  color: primaryColor,
                ),
              ),
              Container(
                width: getSize(205),
                height: getSize(35),
                margin: EdgeInsets.only(top: getSize(10)),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                  ),
                  onPressed: () {
                    dateIsSelected(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                        size: getSize(20),
                      ),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(5),
                      ),
                      Text(date!=null?getDate(date!):"seciniz",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getSize(18),
                              fontFamily: secondaryFontFamily,
                              color: primaryColor)),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(5),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: getSize(10), top: getSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Saat Seç",
                style: TextStyle(
                  fontSize: getSize(22),
                  fontFamily: primaryFontFamily,
                  color: primaryColor,
                ),
              ),
              Container(
                width: getSize(205),
                height: getSize(35),
                margin: EdgeInsets.only(top: getSize(10)),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                  ),
                  onPressed: () async {
                    showListOfTimes(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        color: primaryColor,
                        size: getSize(15),
                      ),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(5),
                      ),
                      Text(
                        time!=null?formateTime(time!.hour, time!.minute, null):"seciniz",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getSize(18),
                            fontFamily: secondaryFontFamily,
                            color: primaryColor),
                      ),
                      Divider(
                        indent: getSize(5),
                        endIndent: getSize(5),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: getSize(10), right: getSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateColor.resolveWith((states) => primaryColor),
                    overlayColor: MaterialStateColor.resolveWith(
                            (states) => secondaryColor.withOpacity(0.2))),
                onPressed: () {
                  createAppointment();
                },
                child: Text(
                  "Randevu olustur",
                  style: TextStyle(
                    fontSize: getSize(18),
                    fontFamily: secondaryFontFamily,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Berber Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
                Divider(
                  height: getSize(24),
                ),
                Text(
                  "Tarih Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
                Divider(
                  height: getSize(24),
                ),
                Text(
                  "Saat Seç",
                  style: TextStyle(
                    fontSize: getSize(22),
                    fontFamily: primaryFontFamily,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Hero(
                  tag: _heroSelectBarber,
                  child: Container(
                    height: getSize(35),
                    width: getSize(205),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                      ),
                      onPressed: () {
                        selectBarberClicked(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/BarberIcon2.png",
                            color: primaryColor,
                            scale: getSize(0.1),
                          ),
                          Divider(
                            indent: getSize(5),
                            endIndent: getSize(0),
                          ),
                          AutoSizeText(
                            selectedEmployee == null
                                ? "Farketmez"
                                : selectedEmployee!.name!,
                            style: TextStyle(
                                fontSize: getSize(18),
                                fontFamily: secondaryFontFamily,
                                color: primaryColor),
                          ),
                          Divider(
                            indent: getSize(5),
                            endIndent: getSize(5),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: getSize(8),
                ),
                Container(
                  width: getSize(205),
                  height: getSize(35),
                  margin: EdgeInsets.only(top: getSize(10)),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2031));

                      // if 'cancel' => null
                      if (newDate == null) return;

                      setState(() => date = newDate);
                      if(selectedEmployee!=null){
                        loadSelectableTimesForAppointment();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: primaryColor,
                          size: getSize(20),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Text(getDate(date),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getSize(18),
                                fontFamily: secondaryFontFamily,
                                color: primaryColor)),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: getSize(12),
                ),
                Container(
                  width: getSize(205),
                  height: getSize(35),
                  margin: EdgeInsets.only(top: getSize(10)),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () async {
                      showListOfTimes(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: primaryColor,
                          size: getSize(15),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Text(
                          formateTime(time.hour, time.minute, null),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getSize(18),
                              fontFamily: secondaryFontFamily,
                              color: primaryColor),
                        ),
                        Divider(
                          indent: getSize(5),
                          endIndent: getSize(5),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateColor.resolveWith((states) => primaryColor),
                      overlayColor: MaterialStateColor.resolveWith(
                              (states) => secondaryColor.withOpacity(0.2))),
                  onPressed: () {
                    createAppointment();
                  },
                  child: Text(
                    "Randevu olustur",
                    style: TextStyle(
                      fontSize: getSize(18),
                      fontFamily: secondaryFontFamily,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),*/
      ],
    );
  }

  Future<void> selectBarberClicked(BuildContext context) async {
    var resultFuture = showDialog(
        context: context,
        builder: (_) => SelectBarberPopupScreen(employees: widget.employees));
    var result = await resultFuture;

    setState(() {
      selectedEmployee = result;
    });
  }

  Future<List<TimeOfDayModel>> loadWorkingHoursForEmployee(int employeeId) async {
    WorkingHoursDatabase wHDb = WorkingHoursDatabase();
    WorkingHoursModel workingHoursOfSelectedEmployee =
        await wHDb.getWorkingHoursByEmployeeId(employeeId);

    List<TimeOfDayModel> timeList = [];
    if(workingHoursOfSelectedEmployee.id!>0){
      int startOfTime = workingHoursOfSelectedEmployee.open!.hour * 60 +
          workingHoursOfSelectedEmployee.open!.minute;
      int endOfTime = workingHoursOfSelectedEmployee.close!.hour * 60 +
          workingHoursOfSelectedEmployee.close!.minute;



      for (int i = startOfTime; i <= endOfTime; i += 30) {
        timeList.add(TimeOfDayModel(
            timeOfDay: TimeOfDay(hour: i ~/ 60, minute: i % 60),
            available: true));
      }
      AppointmentDatabase appDb = AppointmentDatabase();
      if(date!=null){
        appointmentsOfDay = await appDb.getAppointmentsOfDayAndEmployee(
            date!, employeeId);
        for (int i = 0; i < timeList.length; i++) {
          if(date!.year==DateTime.now().year&&date!.month==DateTime.now().month&&date!.day==DateTime.now().day){
            if(timeOfDayToDouble(timeList[i].timeOfDay!)<=timeOfDayToDouble(TimeOfDay.now())){
              setState(() {
                timeList[i].available = false;
              });
            }
          }
          for (int j = 0; j < appointmentsOfDay.length; j++) {
            if (timeList[i].timeOfDay ==
                TimeOfDay.fromDateTime(appointmentsOfDay[j].dateTime!)) {
              setState(() {
                timeList[i].available = false;
              });
            }
          }
        }
      }
      }
    return timeList;
  }

  Future<void> showListOfTimes(BuildContext context) async {
    var result = await showDialog(
        context: context,
        builder: (_) => TimeListPopup(selectableTimes: selectableTimesForAppointment)
    );

    if(result!=null){
      setState(() {
        time = result;
      });
    }
  }

  Future<void> createAppointment() async {
    int res = checkData();
    AppointmentDatabase appDb = AppointmentDatabase();

    switch(res){
      case 1:
        await appDb.createAppointment(selectedEmployee!.barberId!, selectedEmployee!.id!, widget.selectedServices, DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute));
        break;
      case 2:
      //Toast that Min 1 Service, Date and Time must be selected
        break;
    }
  }

  int checkData() {
    if(widget.selectedServices.isNotEmpty&&selectedEmployee!=null&&date!=null&&time!=null){
      return 1;
    }else{
      return 2;
    }
  }

  Future<EmployeeModel> getEarliestEmployeeId() async {
    Map<int,TimeOfDay> earliestTimeOfEmployees = {};
    TimeOfDay? earliestEmployeeTime;
    for(int i=0; i<widget.employees.length; i++){
      var result = await loadWorkingHoursForEmployee(widget.employees[i].id!);
      for(int j=0; j<result.length; j++){
        if(result[j].available!&&timeOfDayToDouble(result[j].timeOfDay!)>timeOfDayToDouble(TimeOfDay.now())){
          earliestTimeOfEmployees[i]=result[j].timeOfDay!;
          break;
        }
      }
    }
    for(var m in earliestTimeOfEmployees.keys.toList()){
      if(earliestEmployeeTime==null){
        earliestEmployeeTime = earliestTimeOfEmployees[m];

      }else{
        if(timeOfDayToDouble(earliestTimeOfEmployees[m]!)<timeOfDayToDouble(earliestEmployeeTime)){
          earliestEmployeeTime = earliestTimeOfEmployees[m];
        }
      }
    }

    return widget.employees[earliestTimeOfEmployees.keys.firstWhere((element) => earliestTimeOfEmployees[element] == earliestEmployeeTime)];
  }

  double timeOfDayToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;

  Future<void> dateIsSelected(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date!=null?date!:DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2031));

    // if 'cancel' => null
    if (newDate == null) return;

    setState(() => date = newDate);
    if(selectedEmployee!=null){
      selectableTimesForAppointment = await loadWorkingHoursForEmployee(selectedEmployee!.id!);
      setState(() {
        selectableTimesForAppointment = selectableTimesForAppointment;
      });
    }else{
      selectedEmployee = await getEarliestEmployeeId();
      selectableTimesForAppointment = await loadWorkingHoursForEmployee(selectedEmployee!.id!);
      setState(() {
        selectableTimesForAppointment = selectableTimesForAppointment;
      });
    }
  }
}
