import 'package:adobe_xd/pinned.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppointmentListItem extends StatelessWidget {
  String date, time;
  Future<void> Function() itemClicked;
  BarberModel barberModel;

  AppointmentListItem({
    Key? key,
    required this.date,
    required this.time,
    required this.itemClicked,
    required this.barberModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: getSize(139),
          width: getSize(350),
          child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.2))),
            onPressed: itemClicked,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Profile
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: getSize(10)),
                          height: getSize(80),
                          width: getSize(80),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(barberModel.profileURL!),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.all(Radius.elliptical(
                                getSize(80) / 2, getSize(80) / 2)),
                            border: Border.all(
                                width: 1.0, color: const Color(0xff707070)),
                          ),
                        ),
                      ],
                    ),
                    //Name, Assessment and Location
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: getSize(10), top: getSize(10)),
                          child: Row(
                            children: [
                              Container(
                                width: getSize(110),
                                child: Text(
                                  barberModel.name!,
                                  style: TextStyle(
                                    fontSize: getSize(22),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  softWrap: false,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /*SvgPicture.string(
                            '<svg viewBox="4.2 0.0 13.0 14.0" ><path transform="translate(4.19, 0.04)" d="M 5.545415878295898 3.058419704437256 C 5.837581157684326 2.122341632843018 7.162418365478516 2.122341394424438 7.454583644866943 3.058419466018677 L 7.912450790405273 4.525391578674316 C 8.039627075195312 4.932857990264893 8.411420822143555 5.214677810668945 8.838094711303711 5.227030754089355 L 10.43678283691406 5.2733154296875 C 11.34757041931152 5.299683570861816 11.75143527984619 6.430988311767578 11.06324768066406 7.028173446655273 L 9.598885536193848 8.29889965057373 C 9.31135368347168 8.54841136932373 9.190435409545898 8.939540863037109 9.286985397338867 9.307791709899902 L 9.767523765563965 11.14060211181641 C 10.01010799407959 12.06583595275879 8.940021514892578 12.7709379196167 8.185545921325684 12.18299865722656 L 7.114673614501953 11.34850120544434 C 6.753277778625488 11.06687641143799 6.246722221374512 11.06687641143799 5.885326862335205 11.34850120544434 L 4.814454078674316 12.18299865722656 C 4.059978485107422 12.77093887329102 2.989891529083252 12.06583690643311 3.232475757598877 11.14060211181641 L 3.713014364242554 9.307791709899902 C 3.809564828872681 8.939540863037109 3.688646793365479 8.54841136932373 3.401114225387573 8.29889965057373 L 1.936752438545227 7.028174877166748 C 1.248566150665283 6.430989265441895 1.652429819107056 5.299684524536133 2.563218116760254 5.273315906524658 L 4.161904811859131 5.22703218460083 C 4.588578224182129 5.21467924118042 4.960371971130371 4.932858943939209 5.087549209594727 4.525392055511475 Z" fill="#002964" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),*/
                                  Icon(
                                    Icons.star,
                                    size: getSize(18),
                                    color: primaryColor,
                                  ),

                                  /*Pin(size: screenWidth!*50/designWidth, end: 4.0),
                    Pin(size: screenWidth!*15/designWidth, start: 1.0),*/
                                  Container(
                                    height: getSize(16),
                                    width: getSize(55),
                                    child: Text(
                                      "${barberModel.averageStars} (+${barberModel.assessmentCount})",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.center,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: getSize(5)),
                          width: getSize(150),
                          child: AutoSizeText(
                            //maxLines: 2,
                            barberModel.addressModel!.getHalfAddress(),
                            style: TextStyle(
                              fontSize: getSize(10),
                              color: fontColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                //Price and DateTime
                Padding(
                  padding: EdgeInsets.only(bottom: getSize(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Total Price
                      Padding(
                        padding: EdgeInsets.only(left: getSize(5)),
                        child: Column(
                          children: [
                            Text(
                              'Topl. ₺${barberModel.minPrice}',
                              style: TextStyle(
                                fontSize: getSize(12),
                                color: primaryColor,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                      //Date and Time
                      Column(
                        children: [
                          Text(
                            '$date\nSaat $time',
                            style: TextStyle(
                              fontSize: getSize(12),
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /*void itemClicked(BuildContext context) {


    if(panelController.isPanelClosed){
      panelController.open();
    }else{
      panelController.close();
    }
  }*/

}
