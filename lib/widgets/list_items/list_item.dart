import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/cloud_functions/favorites_database.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:siravarmi/utilities/consts.dart';

import '../../cloud_functions/appointments_database.dart';
import '../../cloud_functions/working_hours_database.dart';
import '../../models/appointment_model.dart';
import '../../models/time_of_day_model.dart';
import '../../models/working_hours_model.dart';

class ListItem extends StatefulWidget {
  Color? itemBgColor;
  BarberModel barber;

  ListItem({
    Key? key,
    this.itemBgColor,
    required this.barber,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool? isFavorite;
  DateTime? earliestDateTime;

  List<EmployeeModel> employees = [];

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
    loadEmployees(widget.barber.id);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => widget.itemBgColor ?? Colors.white),
        side: MaterialStateProperty.all(
          BorderSide.none,
        ),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => primaryColor.withOpacity(0.2)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        itemClicked(context);
      },
      child: Stack(
        children: [
          Container(
            height: getSize(197),
            width: getSize(350),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(getSize(5)), topRight: Radius.circular(getSize(5))),
              image: DecorationImage(
                image: NetworkImage(widget.barber.profileURL!),
                fit: BoxFit.fitWidth,
              ),
              /*borderRadius:
              BorderRadius.all(Radius.elliptical(getSize(100), getSize(100))),
              border:
              Border.all(width: 1.0, color: fontColor),*/
            ),
          ),

          //NAME

          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(getSize(20)))
            ),
            margin: EdgeInsets.only(top: getSize(170)),
            padding: EdgeInsets.only(left: getSize(10)),
            child: Padding(
              padding: EdgeInsets.only(right: getSize(10)),
              child: Text(
                widget.barber.name!,
                style: TextStyle(
                  fontSize: getSize(24),
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                softWrap: false,
              ),
            ),
          ),

          //ADDRESS

          Padding(
            padding: EdgeInsets.only(top: getSize(210), left: getSize(10)),
            child: Text(
              widget.barber.address!,
              style: TextStyle(
                fontSize: getSize(14),
                color: fontColor,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              softWrap: false,
            ),
          ),

          //FAVORITE

          isFavorite != null && isFavorite!
              ? Container(
                  margin: EdgeInsets.only(left: getSize(315), top: getSize(10)),
                  height: getSize(25),
                  width: getSize(25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(getSize(25)))),
                  child: Icon(
                    Icons.favorite,
                    size: getSize(20),
                    color: secondaryColor,
                  ),
                ) /*Container(
                child: Icon(
                  Icons.favorite,
                  color: secondaryColor,
                  size: getSize(15),
                ),
              )*/
              : const SizedBox(),

          //ASSESSMENT
          Container(
            margin: EdgeInsets.only(top: getSize(10), left: getSize(0)),
            height: getSize(25),
            width: getSize(85),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(getSize(20)), bottomRight: Radius.circular(getSize(20)))
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: secondaryColor,
                  size: getSize(15),
                ),
                /*SvgPicture.string(
            '<svg viewBox="4.2 0.0 13.0 14.0" ><path transform="translate(4.19, 0.04)" d="M 5.545415878295898 3.058419704437256 C 5.837581157684326 2.122341632843018 7.162418365478516 2.122341394424438 7.454583644866943 3.058419466018677 L 7.912450790405273 4.525391578674316 C 8.039627075195312 4.932857990264893 8.411420822143555 5.214677810668945 8.838094711303711 5.227030754089355 L 10.43678283691406 5.2733154296875 C 11.34757041931152 5.299683570861816 11.75143527984619 6.430988311767578 11.06324768066406 7.028173446655273 L 9.598885536193848 8.29889965057373 C 9.31135368347168 8.54841136932373 9.190435409545898 8.939540863037109 9.286985397338867 9.307791709899902 L 9.767523765563965 11.14060211181641 C 10.01010799407959 12.06583595275879 8.940021514892578 12.7709379196167 8.185545921325684 12.18299865722656 L 7.114673614501953 11.34850120544434 C 6.753277778625488 11.06687641143799 6.246722221374512 11.06687641143799 5.885326862335205 11.34850120544434 L 4.814454078674316 12.18299865722656 C 4.059978485107422 12.77093887329102 2.989891529083252 12.06583690643311 3.232475757598877 11.14060211181641 L 3.713014364242554 9.307791709899902 C 3.809564828872681 8.939540863037109 3.688646793365479 8.54841136932373 3.401114225387573 8.29889965057373 L 1.936752438545227 7.028174877166748 C 1.248566150665283 6.430989265441895 1.652429819107056 5.299684524536133 2.563218116760254 5.273315906524658 L 4.161904811859131 5.22703218460083 C 4.588578224182129 5.21467924118042 4.960371971130371 4.932858943939209 5.087549209594727 4.525392055511475 Z" fill="#002964" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
            allowDrawingOutsideViewBox: true,
            color: secondaryColor,
            fit: BoxFit.fill,
          ),*/

                /*Pin(size: screenWidth!*50/designWidth, end: 4.0),
          Pin(size: screenWidth!*15/designWidth, start: 1.0),*/
                Container(
                  height: getSize(16),
                  width: getSize(55),
                  child: Text(
                    "${widget.barber.averageStars} (${widget.barber.assessmentCount})",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                    textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),

          //MIN PRICE

          Padding(
            padding: EdgeInsets.only(top: getSize(245), left: getSize(10)),
            child: Text(
              'Min. ₺' + widget.barber.minPrice.toString(),
              style: TextStyle(
                fontSize: screenWidth! * 12 / designWidth,
                color: primaryColor,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),

          //Date and Time

          Padding(
            padding: EdgeInsets.only(top: getSize(215), left: getSize(260)),
            child: Text(
              'En erken:',
              style: TextStyle(
                fontSize: getSize(10),
                color: fontColor,
                fontWeight: FontWeight.w700,
              ),
              textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: getSize(230), left: getSize(260), bottom: getSize(10)),
            child: Text(
              earliestDateTime != null ? '${getDate(earliestDateTime!)}\nSaat ${getTime(earliestDateTime!)}':"DOLU",
              style: TextStyle(
                fontSize: screenWidth! * 14 / designWidth,
                color: secondaryColor,
                fontWeight: FontWeight.w700,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          )
        ],
      ),
    );
  }

  void itemClicked(BuildContext context) {
    widget.barber.setEmployees(employees);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BarberScreen(
                  barberModel: widget.barber,
                )));
  }

  void loadEmployees(int? id) async {
    EmployeesDatabase empDb = EmployeesDatabase();
    employees = await empDb.getEmployeesFromBarber(id!);
    getEarliestDateTime();
  }

  Future<void> checkFavoriteStatus() async {
    FavoritesDatabase favDb = FavoritesDatabase();
    isFavorite = await favDb.isFavorite(widget.barber.id!);

    setState(() {
      isFavorite = isFavorite;
    });
  }

  Future<DateTime> getEarliestEmployeeId() async {
    Map<int,TimeOfDay> earliestTimeOfEmployees = {};
    TimeOfDay? earliestEmployeeTime;

    for(int i=0; i<employees.length; i++){
      var result = await loadWorkingHoursForEmployee(employees[i].id!);
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

    if(earliestEmployeeTime!=null){
      return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, earliestEmployeeTime.hour, earliestEmployeeTime.minute);
    }else{
      return DateTime(0,0,0,0,0);
    }
  }

  Future<List<TimeOfDayModel>> loadWorkingHoursForEmployee(int employeeId) async {
    WorkingHoursDatabase wHDb = WorkingHoursDatabase();
     WorkingHoursModel workingHoursOfSelectedEmployee =
    await wHDb.getWorkingHoursByEmployeeId(employeeId);
    int startOfTime = workingHoursOfSelectedEmployee.open!.hour * 60 +
        workingHoursOfSelectedEmployee.open!.minute;
    int endOfTime = workingHoursOfSelectedEmployee.close!.hour * 60 +
        workingHoursOfSelectedEmployee.close!.minute;

    List<TimeOfDayModel> timeList = [];
    for (int i = startOfTime; i <= endOfTime; i += 30) {
      timeList.add(TimeOfDayModel(
          timeOfDay: TimeOfDay(hour: i ~/ 60, minute: i % 60),
          available: true));
    }
    AppointmentDatabase appDb = AppointmentDatabase();
    List<AppointmentModel> appointmentsOfDay = await appDb.getAppointmentsOfDayAndEmployee(
        DateTime.now(), employeeId);

    for (int i = 0; i < timeList.length; i++) {
      for (int j = 0; j < appointmentsOfDay.length; j++) {
        if (timeList[i].timeOfDay ==
            TimeOfDay.fromDateTime(appointmentsOfDay[j].dateTime!)) {
          setState(() {
            timeList[i].available = false;
          });
        }
      }
    }

    return timeList;
  }

  double timeOfDayToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;

  void getEarliestDateTime() async{
    var result = await getEarliestEmployeeId();
    if(result.year>0){
      earliestDateTime = result;
      setState(() {
        earliestDateTime = earliestDateTime;
      });
    }
  }
}
