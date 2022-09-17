import 'package:siravarmi/models/address_model.dart';
import 'package:siravarmi/models/employee_model.dart';

class BarberModel{
  int? id;
  String? name;
  int? minPrice;
  String? profileURL;
  String? phoneNumber;
  bool? open;
  double? averageStars;
  int? assessmentCount;
  AddressModel? addressModel;
  List<EmployeeModel>? employees;

  BarberModel({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.profileURL,
    this.phoneNumber,
    required this.open,
    required this.averageStars,
    required this.assessmentCount,
    this.addressModel,
    this.employees,
  });

  BarberModel.fromJson(Map json){
    id = json['id'];
    name = json['name'];
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

  setAddress(AddressModel addressModel){
    this.addressModel = addressModel;
  }
}