
import 'package:mysql1/mysql1.dart';

class DbHelperMySql {
  String host = 'localhost',
      user = 'yadetemi_root',
      password = 'YaS_DeR28',
      db = 'yadetemi_testDb';
  int port = 3306;
  late MySqlConnection conn;


  Future<void> connect() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: host,
        user: user,
        port: port,
        db: db,
        password: password));
  }

  Future saveData() async {
    await connect();
    var result = await conn.query(
        'insert into users (name, email, age) values (?, ?, ?)',
        ['Bob', 'bob@bob.com', 25]);
    print('Inserted row id=${result.insertId}');
  }
}
