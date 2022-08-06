import 'dart:developer';

class ServiceModel{
  int? id;
  String? name;
  int? price;
  bool? gender;
  int? barberId;

  ServiceModel({
    required this.barberId,
    required this.id,
    required this.gender,
    required this.name,
    required this.price,
});

  ServiceModel.fromJson(Map json) {
    id = json['id'];
    barberId = json['barberId'];
    name = json['name'];
    price = json['price'];
    gender = json['gender']==1?true:false;
  }
}