import 'package:siravarmi/models/employee_model.dart';

class BarberModel{
  int? id;
  String? name;
  String? address;
  int? minPrice;
  String? profileURL;
  String? phoneNumber;
  bool? open;
  double? averageStars;
  int? assessmentCount;
  List<EmployeeModel>? employees;

  BarberModel({
    required this.id,
    required this.name,
    required this.address,
    required this.minPrice,
    required this.profileURL,
    this.phoneNumber,
    required this.open,
    required this.averageStars,
    required this.assessmentCount,
    this.employees,
  });

  BarberModel.fromJson(Map json){
    id = json['id'];
    name = json['name'];
    address = json['address'];
    minPrice = json['minPrice'];
    profileURL = json['profileUrl'];
    phoneNumber = json['phoneNumber'];
    open = json['open']==1?true:false;
    averageStars = double.tryParse(json['averageStars'].toStringAsFixed(2));
    assessmentCount = json['assessmentCount'];
  }

  setEmployees(List<EmployeeModel> employees){
    this.employees = employees;
  }
}