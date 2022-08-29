import 'package:siravarmi/models/working_hours_model.dart';
import 'package:sqflite/sqflite.dart';

import 'dbHelperHttp.dart';

class WorkingHoursDatabase{
  final String type = "type";
  final String _open = "open";
  final String close = "close";
  final String date = "date";
  final String day = "day";
  final String barberId = "barberId";

  final workingHoursDatabaseName = "workingHours.db";
  final workingHoursTableName = "workingHours";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(workingHoursDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $workingHoursTableName (id INTEGER PRIMARY KEY, $type VARCHAR(3) NOT NULL, $_open TIME NOT NULL, $close TIME NOT NULL, $date DATE, $day VARCHAR(3) NOT NULL, $barberId INTEGER NOT NULL)",
    );
  }

  Future<List<WorkingHoursModel>> getWorkingHourByBarberId(int id) async{
    if(database==null) await open();
    String sql = "SELECT * FROM workingHours WHERE barberId=$id";
    var result = await database!.rawQuery(sql);
    List<WorkingHoursModel> workingHours = [];

    if(result.isNotEmpty){
      for(var r in result){
        workingHours.add(WorkingHoursModel.fromJson(r));
      }
      return workingHours;
    }

    return workingHours;
  }

  Future<void> getWorkingHoursFromMysql() async{
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getWorkingHours();

    for(var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $workingHoursTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(workingHoursTableName, <String, Object?> {
          'id' : element['id'],
          'type' : element['type'],
          'open' : element['open'],
          'close' : element['close'],
          'date' : element?['date'],
          'day' : element['day'],
          'barberId' : element['barberId'],
        });
      }
    }
  }
}