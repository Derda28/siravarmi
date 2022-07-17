import 'package:flutter/material.dart';

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
      appBar: Appbar(" ").build(context),
      body: buildBody(),
      bottomNavigationBar: Navbar(2,context),
    );
  }

  buildBody() {}

}