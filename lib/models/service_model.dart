class ServiceModel{
  int id;
  String name;
  int price;
  bool gender;
  int barberId;

  ServiceModel({
    required this.barberId,
    required this.id,
    required this.gender,
    required this.name,
    required this.price,
});
}