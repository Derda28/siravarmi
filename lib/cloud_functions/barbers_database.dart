import 'package:path/path.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:sqflite/sqflite.dart';

class BarbersDatabase {
  final String id = "id";
  final String name = "name";
  final String address = "address";
  final String minPrice = "minPrice";
  final String phoneNumber = "phoneNumber";
  final String isOpen = "open";
  final String profileUrl = "profileUrl";
  final String averageStars = "averageStars";
  final String assessmentCount = "assessmentCount";

  final barbersDatabaseName = "barbers.db";
  final barbersTableName = "barbers";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(barbersDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $barbersTableName (id INTEGER NOT NULL,$name VARCHAR(20) ,$address TEXT NOT NULL,$minPrice INTEGER NOT NULL, $phoneNumber VARCHAR(10), $isOpen INTEGER(1) NOT NULL, $profileUrl TEXT NOT NULL, $averageStars REAL NOT NULL, $assessmentCount INTEGER NOT NULL)",
    );
  }

  Future<List<BarberModel>> getBarbers() async{
    if(database==null) await open();
    var result = await database!.rawQuery("SELECT * FROM $barbersTableName");

    List<BarberModel> barberList = [];
    for(var e in result){
      barberList.add(BarberModel.fromJson(e));
    }

    return barberList;
  }

  Future<void> getBarbersFromMysql() async{
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getBarberList();

    for(var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $barbersTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(barbersTableName, <String, Object> {
          'id' : element['id'],
          'name' : element['name'],
          'address' : element['location'],
          'minPrice' : element['minPrice'],
          'phoneNumber' : element?['phoneNumber'],
          'open' : element['open'],
          'profileUrl' : element['profileUrl'],
          'averageStars' : element['averageStars'],
          'assessmentCount' : element['assessmentCount'],
        });
      }

    }
  }

}