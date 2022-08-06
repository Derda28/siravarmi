import 'package:path/path.dart';
import 'package:siravarmi/models/user_model.dart';
import 'package:siravarmi/screens/barber_screen.dart';
import 'package:sqflite/sqflite.dart';

import 'dbHelperHttp.dart';

class UsersDatabase {
  final String id = "id";
  final String name = "name";
  final String surname = "surname";
  final String isMan = "isMan";

  final usersDatabaseName = "users.db";
  final usersTableName = "users";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(usersDatabaseName, version: version,
        onCreate: (db, version) async {
      await createTable(db);
    });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $usersTableName (id INTEGER NOT NULL,$name VARCHAR(20),$surname VARCHAR(20),$isMan INTEGER )",
    );
  }

  /*UsersDatabase._init();
  static final UsersDatabase instance = UsersDatabase._init();

  static Database? _database;



  Future<Database> get database async{
    if(_database!=null){
      return _database!;
    }
    _database = await _initDb('users.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: (db, version){
      db.execute('''
      CREATE TABLE $usersTableName(
        $id INTEGER NOT NULL,
        $name TEXT NOT NULL,
        $surname TEXT,
        $isMan INTEGER NOT NULL,
      )
    ''');
    });
  }*/

  Future<UserModel> getUsers(int userId) async {
    if (database == null) await open();
    var selectResult = await database!
        .rawQuery("SELECT * FROM $usersTableName where id=$userId");

    UserModel userResult = UserModel.fromJson(selectResult[0]);
    return userResult;
  }

  Future<void> getUsersFromMySql() async {
    if (database == null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getUsersList();

    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $usersTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(usersTableName, <String, Object>{
          'id' : element['id'],
          'name' : element['name'],
          'surname' : element['surname'],
          'isMan' : element['isMan'],
        });
      }

    }
  }

  Future close() async {
    database!.close();
  }
}
