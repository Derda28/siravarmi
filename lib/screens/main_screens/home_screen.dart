import 'package:flutter/material.dart';
import 'package:siravarmi/cloud_functions/address_database.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/cloud_functions/favorites_database.dart';
import 'package:siravarmi/cloud_functions/services_database.dart';
import 'package:siravarmi/cloud_functions/working_hours_database.dart';
import 'package:siravarmi/models/appointment_model.dart';
import 'package:siravarmi/screens/main_screens/appointment_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/button/fast_appointment_hs_btn.dart';
import 'package:siravarmi/widgets/button/new_appointment_hs_btn.dart';
import 'package:siravarmi/widgets/button/search_btn.dart';
import 'package:siravarmi/widgets/navbar.dart';

import '../../cloud_functions/users_database.dart';
import '../../models/barber_model.dart';
import '../../utilities/custom_screen_route.dart';
import '../../widgets/appbar.dart';
import '../../widgets/list_items/appointment_list_item.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State{

  AppointmentModel? commingAppointment;
  BarberModel? barberOfAppointment;

  bool areDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if(isLoggedIn){
      loadComingAppointment();
    }
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
                  child: commingAppointment!=null&&barberOfAppointment!=null?AppointmentListItem(
                    date: formateDate(commingAppointment!.dateTime!),
                    time: formateTimeFromDateTime(commingAppointment!.dateTime!),
                    itemClicked: (){
                      return Navigator.pushReplacement(context, CustomScreenRoute(
                      child: AppointmentScreen()));
                    },
                    barberModel: barberOfAppointment!,
                  ):SizedBox(width: getSize(5),),
                ):Padding(
                    padding: EdgeInsets.only(top: getSize(75), left: getSize(30)),
                  child: Text("LOADING..."),
                ),
      ],
    );
  }


  loadComingAppointment() async{
    AppointmentDatabase appDb = AppointmentDatabase();
    var result = await appDb.getNearestAppointment(user.id!);
    if(result.isNotEmpty){
      setState(() {
        commingAppointment = AppointmentModel.fromJson(result[0]);
      });
    }
    barberOfAppointment = await getBarberById(commingAppointment!.barberId);


    setState(() {
      barberOfAppointment = barberOfAppointment;
      areDataLoaded = true;
    });
  }

  getBarberById(int? barberId) async {
    /*for(var barber in barbers!) {
      if(barber.id == barberId){
        return barber;
      }
    }*/
    BarbersDatabase barbersDb = BarbersDatabase();
    AddressDatabase addressDb = AddressDatabase();
    var result = await barbersDb.getBarberById(barberId!);
    var result2 = await addressDb.getAddressFromBarber(result.id!);
    if(result2.barberId!=0){
      setState(() {
        result.setAddress(result2);
      });
    }
    if(result.id!=0){
      return result;
    }
  }

}
