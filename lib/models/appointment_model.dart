class AppointmentModel{
  int id;
  DateTime dateTime;
  int userId;
  int barberId;
  int employeeId;
  int assessmentId;
  int totalPrice;

  AppointmentModel({
    required this.userId,
    required this.dateTime,
    required this.assessmentId,
    required this.barberId,
    required this.employeeId,
    required this.id,
    required this.totalPrice
  });



}