import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/cloud_functions/db_helper_mysql1.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/cloud_functions/favorites_database.dart';
import 'package:siravarmi/cloud_functions/services_database.dart';
import 'package:siravarmi/models/assessment_model.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/navbar.dart';
import 'package:siravarmi/widgets/search_btn.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../cloud_functions/users_database.dart';
import '../widgets/appbar.dart';
import '../widgets/home_screen_btn.dart';
import 'barberList_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {


  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    //closeData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Appbar(fromHome: true, labelHome: "", label: ""),
      body: Column(
        children: [mapsBody(), buttonsBody(), lastBaberBody()],
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

  buttonsBody() {
    return Column(
      children: [
        SearchBtn().build(height: screenWidth!*50/screenWidth!, btnClick: context, whichScreen: "list"),
        /*Container(
          padding: EdgeInsets.only(left: screenWidth! * 0.01),
          margin: EdgeInsets.only(
              top: screenWidth! * 0.1,
              left: screenWidth! * 0.06,
              right: screenWidth! * 0.06),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
              ),
              onPressed: () {  },
              child: Stack(
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.search,
                      color: fontColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Berber bul",
                      style: TextStyle(color: fontColor),
                    ),
                  )
                ],
              )),
        ),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeScreenBtn().build(
                btnHeigth : screenWidth! * 0.48,
                btnWidth : screenWidth! * 0.41,
                btnBottomPadding : screenWidth! * 0.05,
                btnBgColor : Colors.white,
                btnIcon : "assets/images/BarberIconBig.png",
                btnIconHeigth : screenWidth! * 0.213,
                btnIconWidth : screenWidth! * 0.278,
                btnIconLeftPadding : screenWidth! * 0.04,
                btnTxt : "Hizli Randevu",
                btnTxtFontSize : screenWidth! * 0.06,
                btnLeftMargin : screenWidth! * 0.05,
                btnRightMargin : screenWidth! * 0.025,
                btnOverlayColor: "mavi",
                btnTopMargin : screenWidth! * 0.05,
                btnBottomMargin : null,
                btnClick: context,
            ),
            /*Container(
                margin: EdgeInsets.only(
                    top: screenWidth! * 0.05,
                    left: screenWidth! * 0.05,
                    right: screenWidth! * 0.025),
                height: screenWidth! * 0.48,
                width: screenWidth! * 0.41,
                padding: EdgeInsets.only(bottom: screenWidth! * 0.05),
                child: ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  ),
                  onPressed: () {  },
                  child: Stack(
                    children: [
                      Container(

                        margin: EdgeInsets.only(top: 25, left: screenWidth! * 0.04),
                        child: Image.asset(
                          "assets/images/BarberIconBig.png",
                          color: primaryColor,
                          height: screenWidth! * 0.213,
                          width: screenWidth! * 0.278,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Hizli Randevu",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: screenWidth! * 0.06,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )),*/
            HomeScreenBtn().build(
                btnClick: context,
                btnHeigth : screenWidth! * 0.48,
                btnWidth : screenWidth! * 0.41,
                btnBottomPadding : screenWidth! * 0.05,
                btnBgColor : Colors.white,
                btnIcon : "assets/images/CalendarIcon.png",
                btnIconHeigth : screenWidth! * 0.213,
                btnIconWidth : screenWidth! * 0.20,
                btnIconColor: secondaryColor,
                btnIconLeftPadding : screenWidth!*0.078,
                btnTxt : "Yeni Randevu",
                btnTxtFontSize : screenWidth! * 0.06,
                btnTxtColor: secondaryColor,
                btnLeftMargin : screenWidth! * 0.025,
                btnRightMargin : screenWidth! * 0.05,
                btnTopMargin : screenWidth! * 0.05,
                btnBottomMargin : null),
            /*Container(
                margin: EdgeInsets.only(
                    top: screenWidth! * 0.05,
                    right: screenWidth! * 0.05,
                    left: screenWidth! * 0.025),
                height: screenWidth! * 0.48,
                width: screenWidth! * 0.41,
                padding: EdgeInsets.only(bottom: screenWidth! * 0.05),
                child: ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  ),
                  onPressed: () {  },
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: screenWidth! * 0.12),
                            child: Image.asset(
                              "assets/images/CalendarIcon.png",
                              color: secondaryColor,
                              height: screenWidth! * 0.213,
                              width: screenWidth! * 0.20,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Yeni Randevu",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: screenWidth! * 0.06,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )),*/
          ],
        ),

      ],
    );
  }

  lastBaberBody() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth!*0.069, right: screenWidth!*0.069),
          child: Divider(
            height: screenWidth! * 0.15,
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: screenWidth!*0.069),
            alignment: Alignment.topLeft,
            child: Text("Gelecek Randevu",
                style: TextStyle(
                  fontSize: screenWidth!*0.04,
                  color: fontColor,
                )))
      ],
    );
  }

  void loadData() {
    AppointmentDatabase appDb = AppointmentDatabase();
    AssessmentDatabase assDb = AssessmentDatabase();
    BarbersDatabase barbersDb = BarbersDatabase();
    EmployeesDatabase empDb = EmployeesDatabase();
    FavoritesDatabase favDb = FavoritesDatabase();
    ServicesDatabase servicesDb = ServicesDatabase();
    UsersDatabase usersDb = UsersDatabase();


    appDb.getAppointmentsFromMySql(user.id!);
    assDb.getAssessmentsFromMySql();
    barbersDb.getBarbersFromMysql();
    empDb.getEmployeesFromMysql();
    favDb.getEmployeesFromMysql();
    servicesDb.getEmployeesFromMysql();
    usersDb.getUsersFromMySql();
  }

  void closeData() {
  }



}
