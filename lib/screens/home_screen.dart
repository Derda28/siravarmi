import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/cloud_functions/db_helper_mysql1.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/cloud_functions/favorites_database.dart';
import 'package:siravarmi/cloud_functions/services_database.dart';
import 'package:siravarmi/cloud_functions/working_hours_database.dart';
import 'package:siravarmi/models/appointment_model.dart';
import 'package:siravarmi/models/assessment_model.dart';
import 'package:siravarmi/models/working_hours_model.dart';
import 'package:siravarmi/screens/appointment_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/button/fast_appointment_hs_btn.dart';
import 'package:siravarmi/widgets/button/new_appointment_hs_btn.dart';
import 'package:siravarmi/widgets/navbar.dart';
import 'package:siravarmi/widgets/button/search_btn.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../cloud_functions/users_database.dart';
import '../models/barber_model.dart';
import '../utilities/custom_screen_route.dart';
import '../widgets/appbar.dart';
import '../widgets/list_items/appointment_list_item.dart';
import '../widgets/button/home_screen_btn.dart';
import 'barberList_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State{

  List<AppointmentModel>? commingAppointments;
  List<BarberModel>? barbers;

  bool areDataLoaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Appbar(fromHome: true, labelHome: "", label: ""),
      body: Column(
        children: [mapsBody(), buttonsBody(context), lastBaberBody()],
      ),
      bottomNavigationBar: Navbar(0, context),
    );
  }

  mapsBody() {
    return Container(
      child: Image.network(
        'https://drive.google.com/uc?export=view&id=1bwZ_HIz1P2WhthPRY2UscrKUsOkhbRm6',
        height: screenHeight! / 4,
        width: screenWidth,
      ),
    );
  }

  buttonsBody(BuildContext context) {
    return Column(
      children: [
        const SearchBtn(),
        Padding(
          padding: EdgeInsets.only(top: getSize(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FastAppointmentHsBtn(),
              SizedBox(width: getSize(10),),
              NewAppoinmentHsBtn(),
            ],
          ),
        ),
      ],
    );
  }

  lastBaberBody() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(30), right: getSize(30), top: getSize(15)),
          child: Divider(
            color: fontColor,
            thickness: 1,
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: getSize(30), top: getSize(40)),
            alignment: Alignment.topLeft,
            child: Text("Gelecek Randevu",
                style: TextStyle(
                  fontSize: getSize(18),
                  color: fontColor,
                )
            )
        ),
        areDataLoaded?Padding(
                padding: EdgeInsets.only(top: getSize(75)),
                  child: commingAppointments!.isNotEmpty?AppointmentListItem(
                    date: getDate(commingAppointments![0].dateTime!),
                    time: getTime(commingAppointments![0].dateTime!),
                    itemClicked: (){
                      return Navigator.pushReplacement(context, CustomScreenRoute(
                      child: AppointmentScreen()));
                    },
                    barberModel: getBarberById(commingAppointments![0].barberId),
                  ):SizedBox(width: getSize(5),),
                ):Padding(
                    padding: EdgeInsets.only(top: getSize(75), left: getSize(30)),
                  child: Text("LOADING..."),
                ),
      ],
    );
  }

  Future<void> loadData() async {
    AppointmentDatabase appDb = AppointmentDatabase();
    AssessmentDatabase assDb = AssessmentDatabase();
    BarbersDatabase barbersDb = BarbersDatabase();
    EmployeesDatabase empDb = EmployeesDatabase();
    FavoritesDatabase favDb = FavoritesDatabase();
    ServicesDatabase servicesDb = ServicesDatabase();
    UsersDatabase usersDb = UsersDatabase();
    WorkingHoursDatabase wHDb = WorkingHoursDatabase();


    await appDb.deleteTables();
    await assDb.deleteTables();
    await barbersDb.deleteTables();
    await empDb.deleteTables();
    await favDb.deleteTables();
    await servicesDb.deleteTables();
    await usersDb.deleteTables();
    await wHDb.deleteTables();

    await appDb.getAppointmentsFromMySql(user.id!);
    await assDb.getAssessmentsFromMySql();
    await barbersDb.getBarbersFromMysql();
    await empDb.getEmployeesFromMysql();
    await favDb.getFavoritesFromMysql();
    await servicesDb.getEmployeesFromMysql();
    await usersDb.getUsersFromMySql();
    await wHDb.getWorkingHoursFromMysql();

    favorites = await favDb.getFavorites();

    commingAppointments = await appDb.getCommingAppointments(user.id!);
    barbers = await  barbersDb.getBarbers();

    setState((){
      commingAppointments = commingAppointments;
      areDataLoaded = true;
    });
  }


  getBarberById(int? barberId) {
    for(var barber in barbers!) {
      if(barber.id == barberId){
        return barber;
      }
    }
  }



}
