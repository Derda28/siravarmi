import 'package:path/path.dart';
import 'package:siravarmi/models/appointment_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:sqflite/sqflite.dart';

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

  /*AppointmentDatabase._init();
  static final AppointmentDatabase instance = AppointmentDatabase._init();

  static Database? _database;*/

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


  /*Future<Database> get database async{

    if(_database!=null){
      return _database!;
    }

    _database = await _initDb('appointments.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE $appointmentsTableName(
        $id INTEGER NOT NULL,
        $dateTime DATETIME NOT NULL,
        $userId INTEGER NOT NULL,
        $barberId INTEGER NOT NULL,
        $employeeId INTEGER NOT NULL,
        $assessmentId INTEGER,
        $totalPrice INTEGER NOT NULL
      )
    ''');
    });
  }*/

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

  Future close() async {
     if(database==null) await open();
    database!.close();
  }
}