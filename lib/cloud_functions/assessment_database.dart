import 'package:path/path.dart';
import 'package:siravarmi/models/assessment_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:sqflite/sqflite.dart';

import 'dbHelperHttp.dart';

class AssessmentDatabase {
  final String id = "id";
  final String stars = "stars";
  final String userId = "userId";
  final String barberId = "barberId";
  final String employeeId = "employeeId";
  final String comment = "comment";

  final assessmentDatabaseName = "assessment.db";
  final assessmentTableName = "assessments";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(assessmentDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $assessmentTableName (id INTEGER NOT NULL,$stars INTEGER ,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL, $employeeId INTEGER NOT NULL, $comment VARCHAR(100) NOT NULL)",
    );
  }

  Future<List<AssessmentModel>> getAssessments() async{
    if(database==null) await open();

    var selectResult = await database!.rawQuery("SELECT * FROM $assessmentTableName");

    List<AssessmentModel> appointments = [];
    for(var element in selectResult){
      appointments.add(AssessmentModel.fromJson(element));
    }
    return appointments;
  }

  Future<void> getAssessmentsFromMySql() async {
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getAssessmentList();


    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $assessmentTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        database!.insert(assessmentTableName, <String, Object>{
          'id' : element['id'],
          'stars' : element['star'],
          'userId' : element['userId'],
          'barberId' : element['barberId'],
          'employeeId' : element['employeeId'],
          'comment' : element['comment'],
        });
      }

    }
  }


  Future close() async {
    if(database==null) await open();
    database!.close();
  }
}