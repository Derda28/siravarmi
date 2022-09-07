import 'package:intl/intl.dart';
import 'package:siravarmi/cloud_functions/assessment_database.dart';
import 'package:siravarmi/cloud_functions/services_database.dart';
import 'package:siravarmi/models/appointment_model.dart';
import 'package:siravarmi/models/assessment_model.dart';
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
  final String serviceId = "serviceId";

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
      "CREATE TABLE $appointmentsTableName (id INTEGER PRIMARY KEY,$dateTime DATETIME,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL, $employeeId INTEGER NOT NULL, $assessmentId INTEGER NOT NULL, $totalPrice INTEGER NOT NULL, $serviceId INTEGER NOT NULL)",
    );
  }

   Future<List<AppointmentModel>> getLastAppointments(int userId) async{
    if(database==null) await open();

    var selectResult = await database!.rawQuery("SELECT * FROM $appointmentsTableName where userId=$userId AND $dateTime<CURRENT_DATE ORDER BY date($dateTime) DESC");

    ServicesDatabase servicesDb = ServicesDatabase();
    AssessmentDatabase assDb = AssessmentDatabase();
    int lastAppId=0;
    List<AppointmentModel> appointments = [];
    for(var i = 0; i<selectResult.length; i++){
      if(i==0){
        lastAppId=i;
        List<ServiceModel> services = [];
        services.add(await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!));
        AppointmentModel appointmentModel = AppointmentModel.fromJson(selectResult[i]);
        appointmentModel.services = services;
        AssessmentModel assessmentModel = await assDb.getAssessmentById(appointmentModel.assessmentId!);
        if(assessmentModel.id!!=0){
          appointmentModel.assessmentModel = assessmentModel;
        }
        appointments.add(appointmentModel);

      }else{
        if(selectResult[i][barberId]==appointments[lastAppId].barberId&&
            selectResult[i][employeeId]==appointments[lastAppId].employeeId&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.year == appointments[lastAppId].dateTime!.year&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.month == appointments[lastAppId].dateTime!.month&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.day == appointments[lastAppId].dateTime!.day&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.hour == appointments[lastAppId].dateTime!.hour&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.minute == appointments[lastAppId].dateTime!.minute)
        {

          ServiceModel serviceModel = await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!);
          if(serviceModel.id!=0){
            appointments[lastAppId].services!.add(serviceModel);
            appointments[lastAppId].totalPrice = appointments[lastAppId].totalPrice! + serviceModel.price!;
          }
        }else{
          lastAppId++;
          List<ServiceModel> services = [];
          services.add(await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!));
          AppointmentModel appointmentModel = AppointmentModel.fromJson(selectResult[i]);
          appointmentModel.services = services;
          AssessmentModel assessmentModel = await assDb.getAssessmentById(appointmentModel.assessmentId!);
          if(assessmentModel.id!!=0){
            appointmentModel.assessmentModel = assessmentModel;
          }
          appointments.add(appointmentModel);

          if(appointments[lastAppId].assessmentModel!=null){
            print("AppointmentId And DAteTime : ${appointments[lastAppId].id} ${appointments[lastAppId].dateTime}, id: ${appointments[lastAppId].assessmentModel!.id}, stars: ${appointments[lastAppId].assessmentModel!.stars}\n\n");
          }
        }
      }
    }
    return appointments;
  }

  Future<List<AppointmentModel>> getComingAppointments(int userId) async{
    if(database==null) await open();

    var selectResult = await database!.rawQuery("SELECT * FROM $appointmentsTableName where userId=$userId AND $dateTime>CURRENT_DATE ORDER BY date($dateTime) ASC");

    ServicesDatabase servicesDb = ServicesDatabase();
    AssessmentDatabase assDb = AssessmentDatabase();
    int lastAppId=0;
    List<AppointmentModel> appointments = [];
    for(var i=0; i<selectResult.length; i++){
      if(i==0){
        lastAppId=i;
        List<ServiceModel> services = [];
        services.add(await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!));
        AppointmentModel appointmentModel = AppointmentModel.fromJson(selectResult[i]);
        appointmentModel.services = services;
        AssessmentModel assessmentModel = await assDb.getAssessmentById(appointmentModel.assessmentId!);
        if(assessmentModel.id!!=0){
          appointmentModel.assessmentModel = assessmentModel;
        }
        appointments.add(appointmentModel);


      }else{
        if(selectResult[i][barberId]==selectResult[lastAppId][barberId]&&
            selectResult[i][employeeId]==selectResult[lastAppId][employeeId]&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.year == appointments[lastAppId].dateTime!.year&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.month == appointments[lastAppId].dateTime!.month&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.day == appointments[lastAppId].dateTime!.day&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.hour == appointments[lastAppId].dateTime!.hour&&
            DateTime.tryParse(selectResult[i][dateTime].toString())?.minute == appointments[lastAppId].dateTime!.minute){


          ServiceModel serviceModel = await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!);
          if(serviceModel.id!=0){
            appointments[lastAppId].services!.add(serviceModel);
            appointments[lastAppId].totalPrice = appointments[lastAppId].totalPrice! + serviceModel.price!;
          }
        }else{
          lastAppId++;
          List<ServiceModel> services = [];
          services.add(await servicesDb.getServiceById(int.tryParse(selectResult[i][serviceId].toString())!));
          AppointmentModel appointmentModel = AppointmentModel.fromJson(selectResult[i]);
          appointmentModel.services = services;
          AssessmentModel assessmentModel = await assDb.getAssessmentById(appointmentModel.assessmentId!);
          if(assessmentModel.id!!=0){
            appointmentModel.assessmentModel = assessmentModel;
          }
          appointments.add(appointmentModel);
        }
      }
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
       var isExistingData = await database!.rawQuery("SELECT * FROM $appointmentsTableName where id=${element['id']}");
       if(isExistingData.isEmpty){
         database!.insert(appointmentsTableName, <String, Object>{
           'id' : element['id'],
           'dateTime' : element['dateTime'],
           'userId' : element['userId'],
           'barberId' : element['barberId'],
           'employeeId' : element['employeeId'],
           'assessmentId' : element['assessmentId'],
           'totalPrice' : element['totalPrice'],
           'serviceId' : element['serviceId']
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