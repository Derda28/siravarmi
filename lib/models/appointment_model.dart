class AppointmentModel {
  int? id;
  DateTime? dateTime;
  int? userId;
  int? barberId;
  int? employeeId;
  int? assessmentId;
  int? totalPrice;

  AppointmentModel(
      {required this.userId,
      required this.dateTime,
      required this.assessmentId,
      required this.barberId,
      required this.employeeId,
      required this.id,
      required this.totalPrice});

  AppointmentModel.fromJson(Map json) {
    id = json["id"]!;
    dateTime = DateTime.parse(json["dateTime"]!);
    userId = json["userId"]!;
    barberId = json["barberId"]!;
    employeeId = json["employeeId"]!;
    assessmentId = json["assessmentId"]!;
    totalPrice = json["totalPrice"]!;
  }
}
