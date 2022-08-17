import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';

class WorkingHoursModel{
  int? id;
  String? type;
  TimeOfDay? open;
  TimeOfDay? close;
  DateTime? date;
  String? day;
  int? barberId;

  WorkingHoursModel({
    this.id,
    this.type,
    this.open,
    this.close,
    this.day,
    this.date,
    this.barberId
  });

  WorkingHoursModel.fromJson(Map json){
    id = json['id'];
    type = json['type'];
    open = TimeOfDay(hour: int.parse(json['open'].toString().substring(0,2)), minute: int.parse(json['open'].toString().substring(3,5)));
    close = TimeOfDay(hour: int.parse(json['close'].toString().substring(0,2)), minute: int.parse(json['close'].toString().substring(3,5)));
    date = json['date'];
    day = json['day'];
    barberId = json['barberId'];


    /*open = TimeOfDay(hour: int.parse(formateTime(open!.hour, open!.minute, null).substring(0,2)), minute: int.parse(formateTime(open!.hour, open!.minute, null).substring(3,5)));
    close = TimeOfDay(hour: int.parse(formateTime(close!.hour, close!.minute, null).substring(0,2)), minute: int.parse(formateTime(close!.hour, close!.minute, null).substring(3,5)));*/
  }

}