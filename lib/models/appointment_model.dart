import 'package:siravarmi/models/service_model.dart';

import 'assessment_model.dart';

class AppointmentModel {
  int? id;
  DateTime? dateTime;
  int? userId;
  int? barberId;
  int? employeeId;
  int? assessmentId;
  AssessmentModel? assessmentModel;
  int? totalPrice;
  List<ServiceModel>? services = [];

  AppointmentModel({
      required this.userId,
      required this.dateTime,
      this.assessmentId,
      required this.barberId,
      required this.employeeId,
      required this.id,
      required this.totalPrice,
      required this.services,
      this.assessmentModel,
  });

  AppointmentModel.fromJson(Map json) {
    id = json["id"]!;
    dateTime = DateTime.parse(json["dateTime"]!);
    userId = json["userId"]!;
    barberId = json["barberId"]!;
    employeeId = json["employeeId"]!;
    assessmentId = json["assessmentId"];
    totalPrice = json["totalPrice"]!;
  }

}
