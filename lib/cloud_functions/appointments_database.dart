import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:siravarmi/models/appointment_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../models/service_model.dart';
import '../utilities/consts.dart';
import 'dbHelperHttp.dart';

class AppointmentDatabase {
  final String id = "id";
  final String dateTime = "dateTime";
  final String userId = "userId";
  final String barberId = "barberId";
  final String employeeId = "employeeId";
  final String assessmentId = "assessmentId";
  final String totalPrice = "totalPrice";

  final appointmentsDatabaseName = "appointments.db";
  final appointmentsTableName = "appointments";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(appointmentsDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $appointmentsTableName (id INTEGER PRIMARY KEY,$dateTime DATETIME,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL, $employeeId INTEGER NOT NULL, $assessmentId INTEGER NOT NULL, $totalPrice INTEGER NOT NULL)",
    );
  }

   Future<List<AppointmentModel>> getLastAppointments(int userId) async{
    if(database==null) await open();

    var selectResult = await database!.rawQuery("SELECT * FROM $appointmentsTableName where userId=$userId AND $dateTime<CURRENT_DATE ORDER BY date($dateTime) DESC");

    List<AppointmentModel> appointments = [];
    for(var element in selectResult){
      appointments.add(AppointmentModel.fromJson(element));
    }
    return appointments;
  }

  Future<List<AppointmentModel>> getCommingAppointments(int userId) async{
    if(database==null) await open();

    var selectResult = await database!.rawQuery("SELECT * FROM $appointmentsTableName where userId=$userId AND $dateTime>CURRENT_DATE ORDER BY date($dateTime) ASC");

    List<AppointmentModel> appointments = [];
    for(var element in selectResult){
      appointments.add(AppointmentModel.fromJson(element));
    }
    return appointments;
  }
  Future<List<AppointmentModel>> getAppointmentsOfDayAndEmployee(DateTime day, int id) async{
     if(database==null) await open();

     final DateFormat formatter = DateFormat('yyyy-MM-dd');
     final String formatted = formatter.format(day);
     /*day.subtract(Duration(milliseconds: day.microsecond, seconds: day.second, minutes: day.minute, hours: day.hour));*/
     day = day.add(const Duration(days: 1));
     final String formatted2 = formatter.format(day);

     String sql = "SELECT* FROM $appointmentsTableName where $dateTime < '$formatted2' and $dateTime >= '$formatted' AND $employeeId=$id";

     var selectResult = await database!.rawQuery(sql);

     List<AppointmentModel> appointments = [];
     for(var element in selectResult){
       appointments.add(AppointmentModel.fromJson(element));
     }
     return appointments;
  }

  Future<void> getAppointmentsFromMySql(int userId) async {
     if(database==null) await open();
     DbHelperHttp dbHelper = DbHelperHttp();
     var result = await dbHelper.getAppointmentList(userId);

     for (var element in result) {
       var isExistingData = await database!.rawQuery("SELECT * FROM $appointmentsTableName where id="+element['id']);
       if(isExistingData.isEmpty){
         database!.insert(appointmentsTableName, <String, Object>{
           'id' : element['id'],
           'dateTime' : element['dateTime'],
           'userId' : element['userId'],
           'barberId' : element['barberId'],
           'employeeId' : element['employeeId'],
           'assessmentId' : element['assessmentId'],
           'totalPrice' : element['totalPrice'],
         });
       }
     }
  }

  createAppointment(int barberId, int employeeId, List<ServiceModel> services, DateTime dateTime) async{
    if(database==null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();

    for(var s in services){
      await dbHelper.createAppointment(barberId, employeeId, dateTime, s);
    }

   getAppointmentsFromMySql(user.id!);
  }

  Future close() async {
     if(database==null) await open();
    database!.close();
  }

  deleteTables() async {
    if(database==null)await open();
    await database!.delete(appointmentsTableName);
  }
}