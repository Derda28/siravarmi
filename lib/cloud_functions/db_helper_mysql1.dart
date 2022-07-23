/*
import 'package:mysql1/mysql1.dart';

class DbHelper {
  String host = 'localhost',
      user = 'root',
      password = '',
      db = 'testdb';
  int port = 3306;
  late MySqlConnection conn;

  DbHelper(){
    connect();
  }

  Future<void> connect() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: host,
        port: port,
        user: user,
        db: db,
        password: password));
  }

  Future getdata() async {
    connect().then((value) => null);
  }
}*/
