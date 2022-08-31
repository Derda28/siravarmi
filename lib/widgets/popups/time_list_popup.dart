import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siravarmi/utilities/consts.dart';

import '../../models/time_of_day_model.dart';

class TimeListPopup extends StatefulWidget {
  List<TimeOfDayModel> selectableTimes = [];
  TimeListPopup({Key? key, required this.selectableTimes}) : super(key: key);

  @override
  State<TimeListPopup> createState() => _TimeListPopupState();
}

class _TimeListPopupState extends State<TimeListPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        elevation: 10,
        child: Container(
            padding: EdgeInsets.only(
                top: getSize(5),
                bottom: getSize(5),
                left: getSize(10),
                right: getSize(10)),
            height: getSize(350),
            child: ListView.builder(
                itemCount: widget.selectableTimes.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: getSize(5)),
                      child: OutlinedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          buttonIsClicked(widget.selectableTimes[index], context);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: getSize(75),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${formateTime(widget.selectableTimes[index].timeOfDay!.hour, widget.selectableTimes[index].timeOfDay!.minute, null)}",
                              style: TextStyle(
                                color:
                                    widget.selectableTimes[index].available ==
                                            true
                                        ? Colors.green
                                        : Colors.red,
                                fontFamily:
                                    widget.selectableTimes[index].available ==
                                            true
                                        ? primaryFontFamily
                                        : secondaryFontFamily,
                                fontSize: getSize(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))),
      ),
    );
  }

  void buttonIsClicked(TimeOfDayModel time, BuildContext context) {
    if(time.available!){
      Navigator.pop(context, time.timeOfDay);
    }
  }
}
