class FavoriteModel{
  int? id;
  int? userId;
  int? barberId;
  int? employeeId;

  FavoriteModel({
    required this.id,
    required this.barberId,
    required this.userId,
    required this.employeeId,
});

  FavoriteModel.fromJson(Map json) {
    id = json['id'];
    userId = json['userId'];
    barberId = json['barberId'];
    employeeId = json['employeeId'];
  }
}