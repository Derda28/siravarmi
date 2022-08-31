import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/barbers_database.dart';
import 'package:siravarmi/cloud_functions/employees_database.dart';
import 'package:siravarmi/models/assessment_model.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/models/employee_model.dart';
import 'package:siravarmi/routes/hero_dialog_route.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/popups/assessment_popup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/appointment_model.dart';

final String _heroAssessment = "assessment-hero";

class AppointmentSlidingUpPanel extends StatefulWidget {
  final ScrollController scrollController;
  AppointmentModel? appointment;
  BarberModel? barber;
  EmployeeModel? employee;
  AssessmentModel? assessment;
  bool isLastAppointment;

  AppointmentSlidingUpPanel({required this.scrollController, this.appointment, required this.isLastAppointment, required this.barber,required this.employee, required this.assessment});

  @override
  State<AppointmentSlidingUpPanel> createState() => _AppointmentSlidingUpPanelState();
}

class _AppointmentSlidingUpPanelState extends State<AppointmentSlidingUpPanel> {
  /*String barberName = "Salon AS";

  String assessmentTxt = "3.1 (+200)";

  String workerName = "Mustafa";

  String workDate = "16.07.2022";

  String workTime = "22.00";*/

  Icon ratingBarIcon = Icon(Icons.star);

  double ratingIconSize = getSize(55);

  final panelController = PanelController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return widget.appointment!=null?Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: 35,
          margin: EdgeInsets.only(
              left: getSize(80), right: getSize(80), top: getSize(15)),
          child: Text(
            "Geçmiş Randevu",
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: primaryColor,
                fontSize: getSize(28),
                color: primaryColor),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: getSize(60)),
          padding: EdgeInsets.only(),
          decoration: BoxDecoration(
              image: widget.barber!=null?DecorationImage(
                  image: NetworkImage(widget.barber!.profileURL!),
                  fit: BoxFit.cover):DecorationImage(image: NetworkImage("https://st2.depositphotos.com/22942720/44248/i/1600/depositphotos_442487056-stock-photo-hairdressers-cut-clients-barbershop-advertising.jpg"), fit: BoxFit.cover)),
          height: getSize(220),
          width: screenWidth,
        ),
        Container(
          margin: EdgeInsets.only(
              left: getSize(40), right: getSize(200), top: getSize(290)),
          child: widget.barber!=null?Text(
            widget.barber!.name!,//MUST BE CHANGED!!!
            style: TextStyle(fontSize: getSize(36)),
          ):Text("LOADING..."),
          height: getSize(40),
        ),
        Container(
          margin: EdgeInsets.only(
              left: getSize(250), right: getSize(30), top: getSize(291)),
          padding: EdgeInsets.only(left: getSize(20)),
          child: Row(
            children: [
              SizedBox(
                height: getSize(25),
                width: getSize(25),
                child: Padding(
                  padding: EdgeInsets.only(left: getSize(5), top: getSize(5)),
                  child: SvgPicture.string(
                    '<svg viewBox="194.0 149.0 35.0 35.0" ><path transform="translate(194.0, 149.0)" d="M 16.55211448669434 2.820034503936768 C 16.85749244689941 1.911513090133667 18.14250755310059 1.911513090133667 18.4478874206543 2.820034503936768 L 21.65240097045898 12.35370826721191 C 21.78610229492188 12.75147819519043 22.1539249420166 13.02346038818359 22.57341384887695 13.03473949432373 L 32.28314971923828 13.2957706451416 C 33.21295166015625 13.32076740264893 33.60798263549805 14.49047565460205 32.88371658325195 15.07407760620117 L 25.09336853027344 21.35141181945801 C 24.78136444091797 21.60282135009766 24.6495532989502 22.01619529724121 24.75843238830566 22.40180778503418 L 27.53403663635254 32.23200225830078 C 27.79165267944336 33.14437866210938 26.75349426269531 33.86965179443359 25.98543548583984 33.31387710571289 L 18.08622741699219 27.59795761108398 C 17.73640060424805 27.34482002258301 17.26360130310059 27.34482002258301 16.91377258300781 27.59795761108398 L 9.014564514160156 33.31387710571289 C 8.246504783630371 33.86965179443359 7.208349227905273 33.14437866210938 7.465964317321777 32.23200225830078 L 10.24156761169434 22.40180778503418 C 10.35044765472412 22.01619529724121 10.21863651275635 21.60282135009766 9.906631469726562 21.35141181945801 L 2.116285085678101 15.0740795135498 C 1.392019271850586 14.49047660827637 1.787049174308777 13.32076835632324 2.716848611831665 13.29577255249023 L 12.42658805847168 13.03474140167236 C 12.84607601165771 13.02346420288086 13.21389961242676 12.75148105621338 13.34760093688965 12.35371112823486 Z" fill="#002964" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),

              /*Pin(size: screenWidth!*50/designWidth, end: 4.0),
                        Pin(size: screenWidth!*15/designWidth, start: 1.0),*/
              Container(
                padding:
                EdgeInsets.only(top: getSize(1.0), right: getSize(4.0)),
                height: screenWidth! * 20 / designWidth,
                width: screenWidth! * 66 / designWidth,
                margin: EdgeInsets.only(
                    top: screenWidth! * (12 / 412), left: getSize(3)),
                child: widget.barber!=null?Text(
                  "${widget.barber!.averageStars} (${widget.barber!.assessmentCount})",//MUST BE CHANGED!!!
                  style: TextStyle(
                    fontSize: getSize(13),
                    color: primaryColor,
                  ),
                  textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ):Text("LOADING..."),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: getSize(355), left: getSize(40)),
              child: Text(
                "Berber:",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: getSize(24),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(getSize(10)))),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: getSize(220),
                  top: getSize(360),
                  bottom: getSize(265),
                  right: getSize(20)),
              child: widget.employee!=null?Text(
                widget.employee!.surname!=null?"${widget.employee!.name} ${widget.employee!.surname}":widget.employee!.name!,//MUST BE CHANGED!!!
                style: TextStyle(fontSize: getSize(getSize(22))),
              ): Text("LOADING..."),
            )
          ],
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: getSize(405), left: getSize(40)),
              child: Text(
                "Tarih:",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: getSize(24),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(getSize(10)))),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: getSize(220),
                  top: getSize(410),
                  bottom: getSize(215),
                  right: getSize(20)),
              child: Text(
                getDate(widget.appointment!.dateTime!),//MUST BE CHANGED!!!
                style: TextStyle(fontSize: getSize(22)),
              ),
            )
          ],
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: getSize(455), left: getSize(40)),
              child: Text(
                "Saat:",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: getSize(24),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(getSize(10)))),
              margin: EdgeInsets.only(
                  left: getSize(220),
                  top: getSize(460),
                  bottom: getSize(165),
                  right: getSize(20)),
              alignment: Alignment.center,
              child: Text(
                getTime(widget.appointment!.dateTime!),//MUST BE CHANGED!!!
                style: TextStyle(fontSize: getSize(22)),
              ),
            )
          ],
        ),
        Container(
          height: getSize(30),
          width: getSize(200),
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            left: getSize(30),
            top: getSize(520),
          ),
          child: Text(
            "Değerlendirme",
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
                fontSize: getSize(20),
                color: Colors.grey),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: getSize(550), left: getSize(30), right: getSize(30)),
          alignment: Alignment.center,
          child: RatingBar.builder(
            minRating: 1,
            maxRating: 5,
            initialRating: 0,
            itemSize: getSize(50),
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: getSize(4.0)),
            itemBuilder: (context, _) =>
                Icon(Icons.star, color: secondaryColor),
            onRatingUpdate: (rating) {
              starIsClicked(rating, context);
            },
          ),
        )
      ],
    ):Text("WAIT...");
  }

  Future<void> starIsClicked(double i, BuildContext context) async {
    List? returnVar = await Navigator.push(context,
        HeroDialogRoute(builder: (context) => AssessmentPopUpScreen(initialStars: i,)));

  }


}
