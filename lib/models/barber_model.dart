class BarberModel{
  int id;
  String name;
  String address;
  int minPrice;
  String profileURL;
  String? phoneNumber;
  bool open;
  double averageStars;
  int assessmentCount;
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
  });


}