import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:siravarmi/models/assessment_model.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/popups/assessment_popup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/appointment_model.dart';

class AppointmentSlidingUpPanel extends StatefulWidget {
  final ScrollController scrollController;
  final AppointmentModel? appointment;
  final BarberModel? barber;
  final EmployeeModel? employee;
  final AssessmentModel? assessment;
  final bool isLastAppointment;

  AppointmentSlidingUpPanel(
      {Key? key, required this.scrollController,
      this.appointment,
      required this.isLastAppointment,
      required this.barber,
      required this.employee,
      required this.assessment}) : super(key: key);

  @override
  State<AppointmentSlidingUpPanel> createState() =>
      _AppointmentSlidingUpPanelState();
}

class _AppointmentSlidingUpPanelState extends State<AppointmentSlidingUpPanel> {
  Icon ratingBarIcon = Icon(Icons.star);

  double ratingIconSize = getSize(55);

  final panelController = PanelController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.appointment != null
        ? Padding(
          padding: EdgeInsets.only(top: getSize(50)),
          child: SingleChildScrollView(
              child: Stack(
                children: [
                  /*Container(
                    width: screenWidth,
                    height: getSize(300),
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    margin: EdgeInsets.only(top: getSize(180)),
                  ),*/
                  //PROFILE
                  Container(
                    margin: EdgeInsets.only(top: getSize(0)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(getSize(0))),
                        image: widget.barber != null
                            ? DecorationImage(
                                image: NetworkImage(widget.barber!.profileURL!),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(
                                    "https://st2.depositphotos.com/22942720/44248/i/1600/depositphotos_442487056-stock-photo-hairdressers-cut-clients-barbershop-advertising.jpg"),
                                fit: BoxFit.cover)),
                    height: getSize(180),
                    width: screenWidth,
                  ),
                  //BARBER NAME
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(getSize(50)),
                            bottomLeft: Radius.circular(getSize(50))),
                      ),
                      margin: EdgeInsets.only(top: getSize(180)),
                      padding: EdgeInsets.only(left: getSize(60), ),
                      child: widget.barber != null
                          ? Text(
                              widget.barber!.name!, //MUST BE CHANGED!!!
                              style: TextStyle(fontSize: getSize(36), color: Colors.white),
                            )
                          : Text("LOADING..."),
                    ),
                  ),
                  //ASSESSMENT
                  Padding(
                    padding:
                        EdgeInsets.only(left: getSize(250), top: getSize(200)),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: getSize(20),
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: widget.barber != null
                              ? Text(
                                  "${widget.barber!.averageStars} (${widget.barber!.assessmentCount})", //MUST BE CHANGED!!!
                                  style: TextStyle(
                                    fontSize: getSize(13),
                                    color: Colors.white,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                )
                              : Text("LOADING..."),
                        ),
                      ],
                    ),
                  ),
                  //EMPLOYEE
                  Padding(
                    padding: EdgeInsets.only(top: getSize(255), left: getSize(40), right: getSize(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Berber :",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: getSize(18),
                          ),
                        ),
                        Container(
                          height: getSize(30),
                          width: getSize(200),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(getSize(10)))),
                          alignment: Alignment.center,
                          child: widget.employee != null
                              ? Text(
                                  widget.employee!.surname != null
                                      ? "${widget.employee!.name} ${widget.employee!.surname}"
                                      : widget.employee!.name!, //MUST BE CHANGED!!!
                                  style: TextStyle(fontSize: getSize(getSize(22))),
                                )
                              : Text("LOADING..."),
                        )
                      ],
                    ),
                  ),
                  //SERVICES
                  Padding(
                    padding: EdgeInsets.only(top: getSize(305), left: getSize(40), right: getSize(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hizmetler :",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: getSize(18),
                          ),
                        ),
                        Container(
                          height: getSize(80),
                          width: getSize(200),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                              BorderRadius.all(Radius.circular(getSize(10)))),
                          padding: EdgeInsets.only(left: getSize(5)),
                          child: widget.appointment != null
                              ? widget.appointment!.services !=null ? ListView.builder(
                            itemCount: widget.appointment!.services!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "${widget.appointment!.services![index].name} ${widget.appointment!.services![index].price} ₺", //MUST BE CHANGED!!!
                                style: TextStyle(fontSize: getSize(getSize(22))),
                              );
                            },
                          )
                              : Text("Secili Hizmet Yok") : Text("LOADING..."),
                        )
                      ],
                    ),
                  ),
                  //TOTAL PRICE
                  Padding(
                    padding: EdgeInsets.only(top: getSize(405), left: getSize(40), right: getSize(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Toplam :",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: getSize(18),
                          ),
                        ),
                        Container(
                          height: getSize(30),
                          width: getSize(200),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                              BorderRadius.all(Radius.circular(getSize(10)))),
                          alignment: Alignment.center,
                          child: Text(
                            widget.appointment != null ? widget.appointment!.totalPrice!=null?"${widget.appointment!.totalPrice} ₺":"":"Loading...", //MUST BE CHANGED!!!
                            style: TextStyle(fontSize: getSize(22)),
                          ),
                        )
                      ],
                    ),
                  ),
                  //DATE
                  Padding(
                    padding: EdgeInsets.only(top: getSize(455), left: getSize(40), right: getSize(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tarih :",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: getSize(18),
                          ),
                        ),
                        Container(
                          height: getSize(30),
                          width: getSize(200),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(getSize(10)))),
                          alignment: Alignment.center,
                          child: Text(
                            formateDate(
                                widget.appointment!.dateTime!), //MUST BE CHANGED!!!
                            style: TextStyle(fontSize: getSize(22)),
                          ),
                        )
                      ],
                    ),
                  ),
                  //TIME
                  Padding(
                    padding: EdgeInsets.only(top: getSize(505), left: getSize(40), right: getSize(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saat :",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: getSize(18),
                          ),
                        ),
                        Container(
                          height: getSize(30),
                          width: getSize(200),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(getSize(10)))),
                          alignment: Alignment.center,
                          child: Text(
                            formateTimeFromDateTime(
                                widget.appointment!.dateTime!), //MUST BE CHANGED!!!
                            style: TextStyle(fontSize: getSize(22)),
                          ),
                        )
                      ],
                    ),
                  ),
                  //FEEDBACK SECTION
                  widget.isLastAppointment?Container(
                    height: getSize(30),
                    width: getSize(200),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: getSize(30),
                      top: getSize(550),
                    ),
                    child: Text(
                      "Değerlendirme",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey,
                          fontSize: getSize(20),
                          color: Colors.grey),
                    ),
                  ):SizedBox(),
                  //Edit Button
                  widget.isLastAppointment?Container(
                    margin: EdgeInsets.only(left: getSize(350), top: getSize(545)),
                    height: getSize(40),
                    width: getSize(40),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(getSize(50)))),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(getSize(50)))),
                        padding: EdgeInsets.only(right: getSize(0)),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: getSize(25),
                        color: fontColor,
                      ),
                      onPressed: () {
                        editIconIsPressed();
                      },
                    ),
                  ):SizedBox(),
                  //STARS
                  //double.tryParse(widget.appointment!.assessmentModel!.stars!.toString())!
                  widget.isLastAppointment?Container(
                    margin: EdgeInsets.only(top: getSize(600), bottom: getSize(20)),
                    alignment: Alignment.center,
                    child: widget.appointment!=null?RatingBar.builder(
                      minRating: 1,
                      maxRating: 5,
                      initialRating: widget.appointment!.assessmentModel!=null? double.tryParse(widget.appointment!.assessmentModel!.stars!.toString())!:0,
                      ignoreGestures: widget.appointment!.assessmentModel!=null?true:false,
                      glowColor: secondaryColor,
                      glow: widget.appointment!.assessmentModel!=null?true:false,
                      itemSize: getSize(50),
                      unratedColor: fontColor,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: getSize(4.0)),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: secondaryColor),
                      onRatingUpdate: (rating) {
                        starIsClicked(rating, context);
                      },
                    ):Text("LOADING..."),
                  ):SizedBox(),
                  widget.appointment!.assessmentModel!=null?
                      Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: getSize(660), bottom: getSize(10)),
                      width: getSize(250),
                      height: getSize(150),
                      decoration: BoxDecoration(
                        border: Border.all(color: fontColor)
                      ),
                      child: AutoSizeText(
                        widget.appointment!.assessmentModel!.comment!,
                      ),
                    ),
                  ):SizedBox(width: 0,),
                ],
              ),
            ),
        )
        : Text("WAIT...");
  }

  Future<void> starIsClicked(double i, BuildContext context) async {
    List? returnVar = await Navigator.push(
        context,
        HeroDialogRoute(
            builder: (context) => AssessmentPopUpScreen(
              initialStars: i,
            )));
  }

  editIconIsPressed() {}
}
