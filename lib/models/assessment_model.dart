class AssessmentModel {
  int id;
  int stars;
  int barberId;
  int userId;
  int employeeId;
  String command;

  AssessmentModel(
      {required this.id,
      required this.employeeId,
      required this.barberId,
      required this.userId,
      required this.command,
      required this.stars});
  }