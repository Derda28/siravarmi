import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siravarmi/widgets/search_btn.dart';
import 'package:siravarmi/widgets/selected_service_popup_screen.dart';
import 'package:siravarmi/widgets/slidingUpPanels/barber_slidingUpPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/barber_model.dart';
import '../routes/hero_dialog_route.dart';
import '../utilities/consts.dart';
import '../utilities/custom_rect_tween.dart';

class BarberScreen extends StatefulWidget {
  String profileURL =
      "https://static.booksy.com/static/live/covers/barbers.jpg";
  String barberName = "Salon AS";
  String assessmentTxt = "3.1 (+200)";
  String adressInfo =
      "İstanbul Beykoz İstanbul Beykoz İstanbul Beykoz İstanbul Beykoz İstanbul Beykozİstanbul Beykoz İstanbul Beykoz İstanbul Beykoz ";

  BarberScreen(BarberModel barberModel, {Key? key}) : super(key: key) {
    barberName = barberModel.title;
    profileURL = barberModel.profileURL;
    assessmentTxt = barberModel.assessment;
    adressInfo = barberModel.address;
  }

  @override
  State<BarberScreen> createState() => _BarberScreenState();
}

class _BarberScreenState extends State<BarberScreen> {
  double profileHeigt = 300;

  String phoneNumber = "0 (850) 442 15 22";

  String shopTime = "08.00 - 17.00";

  PageController pageController = PageController(initialPage: 0);

  final panelController = PanelController();

  late final ScrollController  controller;

  final double right1=211, right2=115, right3=0, left1=0, left2 = 111, left3=205;

  double left = 0, right = 211;

  Color serviceColor = Colors.white, infosColor = primaryColor, commentsColor = primaryColor;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Sira Var Mi"),
        ),
        body: frontBody(context));
  }

  frontBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // BURAYA FONKSİYON EKLENİCEK
            },
            padding: EdgeInsets.only(
                left: screenWidth! * (378 / 412),
                bottom: screenWidth! * (265 / 412)),
            iconSize: screenWidth! * (30 / 412),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.profileURL), fit: BoxFit.cover)),
          height: profileHeigt,
          width: screenWidth,
        ),
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(screenWidth! * (100 / 412)),
                topLeft: Radius.circular(screenWidth! * (100 / 412))),
          ),
          child: SizedBox(
            width: screenWidth! * (220 / 412),
            child: Text(
              widget.barberName,
              style: TextStyle(
                fontSize: screenWidth! * (35 / 412),
              ),
            ),
          ),
          margin: EdgeInsets.only(
              top: screenWidth! * (275 / 412), left: screenWidth! * (66 / 412)),
          padding: EdgeInsets.only(left: screenWidth! * (60 / 412)),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenWidth! * (265 / 412),
              left: screenWidth! * (323 / 412)),
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  height: screenWidth! * (20 / 412),
                  width: screenWidth! * (20 / 412),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth! * (5 / 412),
                        top: screenWidth! * (5 / 412)),
                    child: SvgPicture.string(
                      '<svg viewBox="194.0 149.0 35.0 35.0" ><path transform="translate(194.0, 149.0)" d="M 16.55211448669434 2.820034503936768 C 16.85749244689941 1.911513090133667 18.14250755310059 1.911513090133667 18.4478874206543 2.820034503936768 L 21.65240097045898 12.35370826721191 C 21.78610229492188 12.75147819519043 22.1539249420166 13.02346038818359 22.57341384887695 13.03473949432373 L 32.28314971923828 13.2957706451416 C 33.21295166015625 13.32076740264893 33.60798263549805 14.49047565460205 32.88371658325195 15.07407760620117 L 25.09336853027344 21.35141181945801 C 24.78136444091797 21.60282135009766 24.6495532989502 22.01619529724121 24.75843238830566 22.40180778503418 L 27.53403663635254 32.23200225830078 C 27.79165267944336 33.14437866210938 26.75349426269531 33.86965179443359 25.98543548583984 33.31387710571289 L 18.08622741699219 27.59795761108398 C 17.73640060424805 27.34482002258301 17.26360130310059 27.34482002258301 16.91377258300781 27.59795761108398 L 9.014564514160156 33.31387710571289 C 8.246504783630371 33.86965179443359 7.208349227905273 33.14437866210938 7.465964317321777 32.23200225830078 L 10.24156761169434 22.40180778503418 C 10.35044765472412 22.01619529724121 10.21863651275635 21.60282135009766 9.906631469726562 21.35141181945801 L 2.116285085678101 15.0740795135498 C 1.392019271850586 14.49047660827637 1.787049174308777 13.32076835632324 2.716848611831665 13.29577255249023 L 12.42658805847168 13.03474140167236 C 12.84607601165771 13.02346420288086 13.21389961242676 12.75148105621338 13.34760093688965 12.35371112823486 Z" fill="#002964" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),

                /*Pin(size: screenWidth!*50/designWidth, end: 4.0),
                        Pin(size: screenWidth!*15/designWidth, start: 1.0),*/
                Container(
                  padding: EdgeInsets.only(
                      top: screenWidth! * (1.0 / 412),
                      right: screenWidth! * (4.0 / 412)),
                  height: screenWidth! * 20 / designWidth,
                  width: screenWidth! * 66 / designWidth,
                  margin: EdgeInsets.only(
                      top: screenWidth! * (12 / 412),
                      left: screenWidth! * (3 / 412)),
                  child: Text(
                    widget.assessmentTxt,
                    style: TextStyle(
                      fontSize: screenWidth! * (13 / 412),
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
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenWidth! * (335 / 412),
              left: screenWidth! * (45 / 412),
              right: screenWidth! * (45 / 412)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth! * (25 / 412))),
                border: Border.all(color: Colors.transparent)),
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  right: right,
                  child: Container(
                    decoration: BoxDecoration(
                      color:  secondaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenWidth! * (25 / 412))),
                    ),
                    height: 48,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:  Colors.transparent,
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenWidth! * (25 / 412))),
                      ),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth! * (18 / 412))),
                            )),
                        child: Text(
                          "HİZMETLER",
                          style: TextStyle(
                              color: serviceColor,
                              fontSize: screenWidth! * (13 / 412)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleFirst();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth! * (18 / 412))),
                          ),
                        ),
                        child: Text(
                          "BİLGİLER",
                          style: TextStyle(
                              color: infosColor,
                              fontSize: screenWidth! * (13 / 412)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleSecond();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color:  Colors.transparent),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth! * (18 / 412))),
                            )),
                        child: Text(
                          "YORUMLAR",
                          style: TextStyle(
                              color: commentsColor,
                              fontSize: screenWidth! * (13 / 412)),
                        ),
                        onPressed: () {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease);
                          _toggleThird();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenWidth! * (410 / 412),
              left: screenWidth! * (40 / 412),
              right: screenWidth! * (40 / 412),
              bottom: screenWidth! * (60 / 412)),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Container(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: screenWidth! * (15 / 412)),
                    child: Container(
                      padding: EdgeInsets.only(),
                      decoration: BoxDecoration(border: Border.all()),
                      child: EntryItem(
                        data[index],
                      ),
                    ),
                  ),
                ),
                height: screenWidth! * (50 / 412),
                width: screenWidth! * (50 / 412),
              ),
              Container(

                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 24,
                        width: 332,
                        decoration:
                        BoxDecoration(color: bgColor),
                        child: Text(
                          "Adres Bilgisi",
                          style: TextStyle(fontSize: 18, color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white),
                          padding: EdgeInsets.only(bottom: 153),
                          margin: EdgeInsets.only(top: 24),
                          child: SizedBox(
                            child: Icon(Icons.map,
                                size: screenWidth! * (30 / 412)),
                            height: 40,
                            width: 42,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white),
                        padding: EdgeInsets.only(
                            top: screenWidth! * (2 / 412),
                            left: screenWidth! * (10 / 412)),
                        child: Text(
                          widget.adressInfo,
                          maxLines: 4,
                          style: TextStyle(fontSize: screenWidth! * (14 / 412)),
                        ),
                        margin: EdgeInsets.only(top: 24, left: 42),
                        width: 292,
                        height: 195,
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        margin: EdgeInsets.only(top: 112, left: 41),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              side: BorderSide(color: Colors.transparent)),
                          child: Text(
                            "Haritada Göster",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        margin: EdgeInsets.only(top: 165, left: 41),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              side: BorderSide(color: Colors.transparent)),
                          child: Text(
                            phoneNumber,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: 24,
                        alignment: Alignment.centerLeft,
                        decoration:
                        BoxDecoration(color: bgColor),
                        child: Text(
                          "Çalışma Saatleri",
                          style: TextStyle(fontSize: 18, color: primaryColor),
                        ),
                        margin: EdgeInsets.only(top: 219),
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 243),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueGrey
                              ),
                            ),
                            child: Text(
                              "Pazartesi:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 243, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),Container(
                            margin: EdgeInsets.only(top: 273),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey
                                )),
                            child: Text(
                              "Salı:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 273, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 303),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey)
                            ),
                            child: Text(
                              "Çarşamba:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 303, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 333),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey
                                )),
                            child: Text(
                              "Perşembe:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 333, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 363),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey
                                )),
                            child: Text(
                              "Cuma:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 363, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 393),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey
                                )),
                            child: Text(
                              "Cumartesi:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 393, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 423),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey
                                )),
                            child: Text(
                              "Pazar:",
                              style: TextStyle(fontSize: 16),
                            ),
                            height: 30,
                            width: 332,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 423, left: 232),
                            alignment: Alignment.center,

                            child: Text(
                              shopTime,
                              style: TextStyle(fontSize: 14),
                            ),
                            height: 30,
                            width: 120,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                height: screenWidth! * (50 / 412),
                width: screenWidth! * (50 / 412),
              ),
              Container(
                height: screenWidth! * (50 / 412),
                width: screenWidth! * (50 / 412),
              )
            ],
          ),
        ),
        Container(
          color: primaryColor,
          width: screenWidth,
          height: 50,
          margin: EdgeInsets.only(
              top: screenWidth! * ((screenHeight! - 130) / 412)),
          child: Row(
            children: [
              Hero(
                tag: _heroselectedService,
                createRectTween: (begin, end) {
                  return CustomRectTween(begin: begin!, end: end!);
                },
                child: Container(
                    color: primaryColor,
                    margin: EdgeInsets.only(left: screenWidth! * (22 / 412)),
                    child: TextButton(
                      child: Text(
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: screenWidth! * (16 / 412)),
                          "x Hizmet Seçili"),
                      onPressed: () {
                        selectedServiceBtnClicked(context);
                      },
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: screenWidth! * (104 / 412)),
                child: TextButton(
                    child: Text(
                      "Randevu Al >",
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: screenWidth! * (16 / 412)),
                    ),
                    onPressed: () {
                      appointmentBtnClicked();
                    }),
              )
            ],
          ),
        ),
        SlidingUpPanel(
          backdropEnabled: true,
          minHeight: 0,
          maxHeight: 250,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 5,
              blurRadius: 10,
            )
          ],
          controller: panelController,
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          panelBuilder: (builder) => BarberSlidingUpPanel(),
          footer: Padding(
            padding: EdgeInsets.only(left: 180),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
                  overlayColor: MaterialStateColor.resolveWith((states) => secondaryColor.withOpacity(0.2))
              ),
              onPressed: (){},
              child: Text(
                "Randevu olustur",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: secondaryFontFamily,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void appointmentBtnClicked() {
    if(panelController.isPanelClosed){
      panelController.open();
    }
  }

  Future<void> selectedServiceBtnClicked(BuildContext context) async {
    final result = await Navigator.push(context,HeroDialogRoute(builder: (context){
      return SelectedServicePopupScreen();
    }));
  }

  void _toggleFirst() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left=left1;
      right=right1;
      serviceColor = Colors.white;
      infosColor = primaryColor;
      commentsColor = primaryColor;
      timer.cancel();
      setState(() {});
    });
  }

  void _toggleSecond() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left=left2;
      right=right2;
      serviceColor = primaryColor;
      infosColor = Colors.white;
      commentsColor = primaryColor;
      timer.cancel();
      setState(() {});
    });
  }

  void _toggleThird() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      left=left3;
      right=right3;
      serviceColor = primaryColor;
      infosColor = primaryColor;
      commentsColor = Colors.white;
      timer.cancel();
      setState(() {});
    });
  }
}

final String _heroselectedService = "selected-service-hero";


class Entry {
  late final String title;
  late final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = <Entry>[
  Entry(
    'Cilt Bakım (KADIN)',
    <Entry>[
      Entry('Test 1'),
      Entry('Test 2'),
      Entry('Test 3'),
    ],
  ),
  // Second Bar
  Entry(
    'Saç (ERKEK)',
    <Entry>[
      Entry('Test 1'),
      Entry('Test 2'),
    ],
  ),
  //  Third Bar
  Entry(
    'Tırnak (ERKEK)',
    <Entry>[Entry('Test 1'), Entry('Test 2'), Entry('Test 3')],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
