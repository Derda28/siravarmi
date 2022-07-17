import 'package:flutter/material.dart';
import 'package:siravarmi/widgets/list_item.dart';

import '../widgets/appbar.dart';
import '../widgets/navbar.dart';

class AppointmentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AppointmentState();
  }

}

class _AppointmentState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar("Randevular").build(context),
      body: buildBody(),
      bottomNavigationBar: Navbar(1,context),
    );
  }

  buildNavbar(){

  }

  buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 45),
        child: ListItem().build(
            itemHeigth: 60,
            itemWidth: 320,
            itemBgColor: Colors.white,
            profileHeigth: 50,
            profileWidth: 50,
            title: "S.A.",
            location: "Istanbul",
            minPrice: 50,
            assessmentTxt: "3,9 (+199)",
            date: "Yarin",
            time: "15:30"),
    );
  }

}