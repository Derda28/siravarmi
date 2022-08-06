class UserModel{
  int? id;
  String? name;
  String? surname;
  String? mail;
  String? password;
  bool? isMan;
  UserModel({ this.id, this.name, this.surname, this.mail, this.password, this.isMan});

  UserModel.fromJson(Map json){
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    isMan = json['isMan']==1?true:false;
  }
}