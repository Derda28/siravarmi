import 'dart:convert';

import 'package:http/http.dart' as http;

class DbHelper {
  String host = 'localhost',
      user = 'root',
      password = '',
      db = 'testdb';
  int port = 3306;

  Future getdata() async {
    var url = 'http://192.168.1.105/database/getData.php';

    var response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }
}