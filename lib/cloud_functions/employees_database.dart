import 'package:path/path.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:sqflite/sqflite.dart';

import '../models/employee_model.dart';

class EmployeesDatabase {
  final String id = "id";
  final String name = "name";
  final String working = "working";
  final String barberId = "barberId";
  final String surname = "surname";
  final String gender = "gender";
  final String type = "type";

  final employeesDatabaseName = "employees.db";
  final employeesTableName = "employees";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(employeesDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $employeesTableName (id INTEGER NOT NULL,$name VARCHAR(20),$surname VARCHAR(20),$working INTEGER NOT NULL, barberId INTEGER NOT NULL, $gender INTEGER NOT NULL, $type INTEGER NOT NULL)",
    );
  }

  Future<List<EmployeeModel>> getEmployeesFromBarber(int barberId) async {
    if (database == null) await open();
    var selectResult = await database!
        .rawQuery("SELECT * FROM $employeesTableName where id=$barberId");

    List<EmployeeModel> employees = [];
    for (var element in selectResult) {
      employees.add(EmployeeModel.fromJson(element));
    }

    return employees;
  }

  getEmployeesFromMysql() async{
    if (database == null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getEmployees();

    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $employeesTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(employeesTableName, <String, Object?>{
          'id' : element['id'],
          'name' : element['name'],
          'surname' : element['surname'],
          'barberId' : element['barberId'],
          'gender' : element['gender'],
          'working' : element['working'],
          'type' : element['type'],
        });
      }

    }
  }
}