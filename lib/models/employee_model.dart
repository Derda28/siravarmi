class EmployeeModel{
  int? id;
  int? barberId;
  String? name;
  String? surname;
  bool? gender;
  bool? working;

  EmployeeModel({
    required this.barberId,
    required this.id,
    required this.name,
    required this.gender,
    required this.working,
    this.surname,
  });

  EmployeeModel.fromJson(Map json) {
    id = json['id'];
    barberId = json['barberId'];
    name = json['name'];
    surname = json['surname'];
    gender = json['gender']==1?true:false;
    working = json['working']==1?true:false;
  }
}