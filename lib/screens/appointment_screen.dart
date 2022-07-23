import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/appointment_list_item.dart';
import 'package:siravarmi/widgets/list_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../widgets/slidingUpPanels/appointment_slidingUpPanel.dart';

class AppointmentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AppointmentState();
  }

}

class _AppointmentState extends State{

  double _panelHeightOpen = 150;
  double _panelHeightClosed = 10.0;
  final panelController = PanelController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = screenHeight! * .80;


    return Scaffold(
      appBar: Appbar("Randevular").build(context),
      body: Stack(
        children: [
          buildBody(),buildSUP(),
        ],
      ),
      bottomNavigationBar: Navbar(1,context),
    );
  }

  buildNavbar(){

  }

  buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: AppointmentListItem(
            itemHeigth: 60,
            itemWidth: 350,
            itemBgColor: Colors.white,
            profileHeigth: 50,
            profileWidth: 50,
            title: "S.A.",
            location: "Istanbul",
            minPrice: 50,
            assessmentTxt: "3,9 (+199)",
            date: "Yarin",
            time: "15:30", profileURL: 'http://dummyimage.com/217x156.png/ff4444/ffffff',
            panelController: panelController,)

    );
  }

  buildSUP() {
    return SlidingUpPanel(
      backdropEnabled: true,
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      maxHeight: 650,
      minHeight: 0,
      controller: panelController,
      /*body: _body(),*/
      panelBuilder: (sc) => AppointmentSlidingUpPanel(scrollController: sc,),

    );
  }

  openPanel() {

  }


}