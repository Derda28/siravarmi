class AddressModel{
  int? id;
  String? country;
  String? city;
  String? district;
  String? description;
  int? barberId;

  AddressModel({required this.id, required this.country, required this.city, required this.district, required this.description, required this.barberId});

  AddressModel.fromJson(Map json){
    id = json['id'];
    country = json['country'];
    city = json['city'];
    district = json['district'];
    description = json['description'];
    barberId = json['barberId'];
  }

  getFullAddress() {
    return "$description $district / $city $country";
  }

  getHalfAddress() {
    return "$district / $city";
  }
}