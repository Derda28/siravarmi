import 'package:siravarmi/models/address_model.dart';
import 'package:sqflite/sqflite.dart';

import 'dbHelperHttp.dart';

class AddressDatabase {
  final String country = "country";
  final String city = "city";
  final String district = "district";
  final String description = "description";
  final String barberId = "barberId";

  final addressDatabaseName = "address.db";
  final addressTableName = "address";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(addressDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $addressTableName (id INTEGER PRIMARY KEY,$country VARCHAR(255),$city VARCHAR(20),$district VARCHAR(20), $description VARCHAR(255), $barberId INTEGER)",
    );
  }

  Future<List<AddressModel>> getAddress() async {
    if(database==null) await open();

    String sql = "SELECT * FROM $addressTableName";
    var result = await database!.rawQuery(sql);

    List<AddressModel> addresses = [];

    for(var r in result){
      addresses.add(AddressModel.fromJson(r));
    }

    return addresses;
  }

  Future<AddressModel> getAddressFromBarber(int barberId) async {
    if(database==null) await open();

    String sql = "SELECT * FROM $addressTableName WHERE barberId=$barberId";
    var result = await database!.rawQuery(sql);

    if(result.isNotEmpty){
      return AddressModel.fromJson(result[0]);
    }

    return AddressModel(id: 0, country: "", city: city, district: "district", description: "description", barberId: 0);
  }

  Future<void> getAddressFromMySql() async {
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getAddress();

    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $addressTableName where id=${element['id']}");
      if(isExistingData.isEmpty){
        database!.insert(addressTableName, <String, Object?>{
          'id' : element['id'],
          'country' : element['country'],
          'city' : element['city'],
          'district' : element['district'],
          'description' : element['description'],
          'barberId' : element['barberId'],
        });
      }
    }
  }

  Future close() async {
    if(database==null) await open();
    database!.close();
  }

  deleteTables() async {
    if(database==null)await open();
    await database!.delete(addressTableName);
  }
}