import 'package:flutter/material.dart';
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
  final String employeeId = "employeeId";

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
      "CREATE TABLE $workingHoursTableName (id INTEGER PRIMARY KEY, $type VARCHAR(3) NOT NULL, $_open TIME NOT NULL, $close TIME NOT NULL, $date DATE, $day VARCHAR(3) NOT NULL, $barberId INTEGER NOT NULL, $employeeId INTEGER)",
    );
  }

  Future<List<WorkingHoursModel>> getWorkingHourByBarberId(int id) async{
    if(database==null) await open();
    String sql = "SELECT * FROM workingHours WHERE barberId=$id AND employeeId is null";
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

  Future<WorkingHoursModel> getWorkingHoursByEmployeeId(int employeeId) async{
    if(database==null) await open();
    String sql = "SELECT * FROM $workingHoursTableName WHERE employeeId=$employeeId";
    var result = await database!.rawQuery(sql);

    if(result.isNotEmpty){
      String openTime = result[0]['open'].toString();
      String close = result[0]['close'].toString();
      WorkingHoursModel workingHours = WorkingHoursModel(
        id: result[0]['id'] as int,
        date: result[0]['date'] as DateTime?,
        barberId: result[0]['barberId'] as int,
        day: result[0]['day'] as String,
        type: result[0]['type'] as String,
        open: TimeOfDay(hour: int.parse(openTime.split(":")[0]), minute: int.parse(openTime.split(":")[1])),
        close: TimeOfDay(hour: int.parse(close.split(":")[0]), minute: int.parse(close.split(":")[1])),
        employeeId: result[0]['employeeId'] as int,
      );
      return workingHours;
    }
    return WorkingHoursModel(id: 0, employeeId: 0, close: TimeOfDay.now(), open: TimeOfDay.now(), type: "", day: "", barberId: 0, date: DateTime.now());

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
          'employeeId' : element['employeeId'],
        });
      }
    }
  }
}