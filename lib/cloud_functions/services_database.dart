import 'package:path/path.dart';
import 'package:siravarmi/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

import 'dbHelperHttp.dart';

class ServicesDatabase {
  final String name = "name";
  final String barberId = "barberId";
  final String price = "price";
  final String gender = "gender";
  final String category = "category";

  final servicesDatabaseName = "services.db";
  final servicesTableName = "services";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(servicesDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $servicesTableName (id INTEGER NOT NULL,$name VARCHAR(50),$barberId INTEGER NOT NULL,$price INTEGER NOT NULL, $gender INTEGER NOT NULL, $category VARCHAR(25) NOT NULL)",
    );
  }

  Future<List<ServiceModel>> getServices() async {
    if (database == null) await open();
    var selectResult = await database!
        .rawQuery("SELECT * FROM $servicesTableName");

    List<ServiceModel> services = [];
    for (var element in selectResult) {
      services.add(ServiceModel.fromJson(element));
    }

    return services;
  }

  getEmployeesFromMysql() async{
    if (database == null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getServices();

    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $servicesTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(servicesTableName, <String, Object?>{
          'id' : element['id'],
          'barberId' : element['barberId'],
          'price' : element['price'],
          'name' : element['name'],
          'gender' : element['gender'],
          'category' : element['category'],
        });
      }

    }
  }

  Future close() async {

  }
}