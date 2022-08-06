class AssessmentModel {
  int? id;
  int? stars;
  int? barberId;
  int? userId;
  int? employeeId;
  String? comment;
  String? userName;
  String? userSurname;

  AssessmentModel({
    required this.id,
    required this.employeeId,
    required this.barberId,
    required this.userId,
    required this.comment,
    required this.stars,
    this.userName,
    this.userSurname,
  });

  AssessmentModel.fromJson(Map json) {
    id = json["id"]!;
    stars = json["stars"]!;
    userId = json["userId"]!;
    barberId = json["barberId"]!;
    employeeId = json["employeeId"]!;
    comment = json["comment"]!;
  }

}
