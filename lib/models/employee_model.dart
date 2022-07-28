class EmployeeModel{
  int id;
  int barberId;
  String name;
  String? surname;
  bool gender;
  bool working;

  EmployeeModel({
    required this.barberId,
    required this.id,
    required this.name,
    required this.gender,
    required this.working,
    this.surname,
  });
}