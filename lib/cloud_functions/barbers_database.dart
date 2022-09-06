import 'package:path/path.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/models/barber_model.dart';
import 'package:sqflite/sqflite.dart';

class BarbersDatabase {
  final String id = "id";
  final String name = "name";
  final String location = "location";
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
      "CREATE TABLE $barbersTableName (id INTEGER PRIMARY KEY,$name VARCHAR(20) ,$location TEXT NOT NULL,$minPrice INTEGER NOT NULL, $phoneNumber VARCHAR(10), $isOpen INTEGER(1) NOT NULL, $profileUrl TEXT NOT NULL, $averageStars REAL NOT NULL, $assessmentCount INTEGER NOT NULL)",
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

  Future<BarberModel> getBarberById(int id) async{
    if(database==null) await open();
    String sql = "SELECT * FROM barbers WHERE id=$id";
    var result = await database!.rawQuery(sql);

    if(result.isNotEmpty){
      BarberModel barber = BarberModel.fromJson(result[0]);
      return barber;
    }

    return BarberModel(id: 0, name: "", address: "", minPrice: 0, profileURL: "", open: false, averageStars: 0, assessmentCount: 0);
  }

  Future<List<BarberModel>> getBarberByRawQuery(String sql) async{
    if(database==null) await open();
    var result = await database!.rawQuery(sql);
    List<BarberModel> barbers = [];
    for(var r in result){
      barbers.add(BarberModel.fromJson(r));
    }
    return barbers;
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
          'location' : element['location'],
          'minPrice' : element['minPrice'],
          'phoneNumber' : element?['phoneNumber'],
          'open' : element['open'],
          'profileUrl' : element['profileUrl'],
          'averageStars' : element['averageStars'],
          'assessmentCount' : element['assessmentCount'],
        });
      }
      /*else{
        Map<String, Object> updateMap = {};
        if(isExistingData[0]['name']!=element['name']){
          updateMap['name'] = element['name'];
        }
        if(isExistingData[0]['location']!=element['location']){
          updateMap['location'] = element['location'];
        }
        if(isExistingData[0]['minPrice']!=element['minPrice']){
          updateMap['minPrice'] = element['minPrice'];
        }
        if(isExistingData[0]['profileUrl']!=element['profileUrl']){
          updateMap['profileUrl'] = element['profileUrl'];
        }
        if(isExistingData[0]['open']!=element['open']){
          updateMap['open'] = element['open'];
        }
        if(isExistingData[0]['phoneNumber']!=element['phoneNumber']){
          updateMap['phoneNumber'] = element['phoneNumber'];
        }
        if(isExistingData[0]['averageStars']!=element['averageStars']){
          updateMap['averageStars'] = element['averageStars'];
        }
        if(isExistingData[0]['assessmentCount']!=element['assessmentCount']){
          updateMap['assessmentCount'] = element['assessmentCount'];
        }
        var res = await database!.update(barbersTableName, updateMap);
        updateMap.clear();
      }*/

    }

    /*var sqliteResult = await getBarbers();

    for(var d in sqliteResult){
      print(d.id!);
      var res = await dbHelper.isThereBarberWithId(d.id!);
      if(!res){
        String sql = "DELETE FROM $barbersTableName WHERE $id=${d.id!}";
        database!.rawDelete(sql);
      }
    }*/
  }

  /*Future<void> deleteDatabase() =>
      databaseFactory.deleteDatabase(barbersDatabaseName);*/

  deleteTables() async {
    if(database==null)await open();
    await database!.delete(barbersTableName);
  }

}