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
  final String date = "date";

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
      "CREATE TABLE $assessmentTableName (id INTEGER NOT NULL,$stars INTEGER ,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL, $employeeId INTEGER NOT NULL, $comment VARCHAR(100) NOT NULL, $date DATETIME NOT NULL)",
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

  Future<AssessmentModel> getAssessmentById(int id) async{
    if(database==null) await open();
    String sql = "SELECT * FROM assessments WHERE id=$id";
    var result = await database!.rawQuery(sql);

    if(result.isNotEmpty){
      AssessmentModel ass = AssessmentModel.fromJson(result[0]);
      return ass;
    }

    return AssessmentModel(id: 0, employeeId: 0, barberId: 0, userId: 0, comment: "", stars: 0);
  }

  Future<void> getAssessmentsFromMySql() async {
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getAssessmentList();


    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $assessmentTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        print(element['date']);
        database!.insert(assessmentTableName, <String, Object>{
          'id' : element['id'],
          'stars' : element['star'],
          'userId' : element['userId'],
          'barberId' : element['barberId'],
          'employeeId' : element['employeeId'],
          'comment' : element['comment'],
          'date' : element['date'],
        });
      }

    }
  }


  Future close() async {
    if(database==null) await open();
    database!.close();
  }
}