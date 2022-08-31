import 'package:flutter/material.dart';
import 'package:siravarmi/widgets/button/filter_btn.dart';

import '../utilities/consts.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';

class NotificationScreen extends StatefulWidget{
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationState();
  }

}

class _NotificationState extends State{

  
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Appbar(label: " ", labelHome: "", fromHome: false,),
      body: Column(
        children: [
          buildBody(),
        ]
      ),
      bottomNavigationBar: Navbar(2,context),
    );
  }

  buildBody() {
    return Column(
      children: [
        Text("Test"),
      ],
    );
  }

}