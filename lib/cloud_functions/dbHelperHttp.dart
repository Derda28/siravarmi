import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:siravarmi/models/favorite_model.dart';
import 'package:siravarmi/models/working_hours_model.dart';

class DbHelperHttp {
  Future<List<dynamic>> getBarberList() async {
    var url =
        Uri.parse('https://yadetemizlik.com/getBarbers.php');
    http.Response response = await http.get(url);

    var data = jsonDecode(response.body);

    return data;
  }

  Future<LinkedHashMap<String, dynamic>> tryLogin(
      String mail, String pass) async {
    String url = 'https://yadetemizlik.com/login.php';
    var response = await http.post(Uri.parse(url), body: {
      'mail': mail, //get the username text
      'password': pass //get password text
    });
    var data = jsonDecode(response.body);
    return data;
  }

  Future tryRegister(String mail, String pass, String name, String surname,
      bool gender) async {
    String url = 'https://yadetemizlik.com/register.php';
    String genderInput = "";
    if (gender) {
      genderInput = "1";
    } else {
      genderInput = "0";
    }

    var response = await http.post(Uri.parse(url), body: {
      'mail': mail, //get the username text
      'password': pass, //get password text
      'name': name,
      'surname': surname,
      'gender': genderInput,
    });
    var data = response.body;

    return data;
  }

  Future<List<dynamic>> getAppointmentList(int userId) async {
    var url = Uri.parse(
        'https://yadetemizlik.com/getAppointmentsFromUser.php');
    http.Response response =
        await http.post(url, body: {'userId': userId.toString()});

    var data = jsonDecode(response.body);
    return data;
  }

  /*Future<LinkedHashMap<String,dynamic>> getUserFromAssessment(int userId) async {
    var url = Uri.parse(
        'https://testforsiravarmi.000webhostapp.com/getUserFromAssessment.php');
    http.Response response =
        await http.post(url, body: {'userId': userId.toString()});


    var data = jsonDecode(response.body);
    return data;
  }*/

  Future<List<dynamic>> getAssessmentListFromBarber(int barberId) async {
    var url = Uri.parse(
        'https://yadetemizlik.com/getAssessmentsFromBarber.php');
    http.Response response =
    await http.post(url, body: {'barberId': barberId.toString()});


    var data = jsonDecode(response.body);
    return data;
  }

  Future<List<dynamic>> getAssessmentList() async{
    var url = Uri.parse(
        'https://yadetemizlik.com/getAssessments.php');
    http.Response response =
    await http.get(url);

    var data = jsonDecode(response.body);
    return data;
  }

  Future<List<dynamic>> getUsersList() async{
    var url = Uri.parse(
        'https://yadetemizlik.com/getUsers.php');
    http.Response response =
    await http.get(url);


    var data = jsonDecode(response.body);
    return data;
  }

  Future<List<dynamic>> getEmployees() async{
    var url = Uri.parse(
        'https://yadetemizlik.com/getEmployees.php');
    http.Response response = await http.get(url);

    var data = jsonDecode(response.body);

    return data;
  }

  Future<List<dynamic>> getFavorites(int userId) async{
    var url = Uri.parse(
        'https://yadetemizlik.com/getFavoritesFromUser.php');
    http.Response response =
    await http.post(url, body: {'userId': userId.toString()});

    var data = jsonDecode(response.body);

    return data;
  }

  Future<List<dynamic>> getServices() async{
    var url = Uri.parse('https://yadetemizlik.com/getServices.php');
    http.Response response = await http.get(url);

    var data  = jsonDecode(response.body);

    return data;
  }

  Future<List<dynamic>> getWorkingHours() async{
    var url = Uri.parse('https://yadetemizlik.com/getWorkingHours.php');
    http.Response response = await http.get(url);

    var data  = jsonDecode(response.body);

    return data;
  }

}
