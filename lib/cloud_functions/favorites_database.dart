import 'package:path/path.dart';
import 'package:siravarmi/models/favorite_model.dart';
import 'package:sqflite/sqflite.dart';

import '../utilities/consts.dart';
import 'dbHelperHttp.dart';

class FavoritesDatabase {
  final String id = "id";
  final String userId = "userId";
  final String barberId = "barberId";
  final String employeeId = "employeeId";

  final favoritesDatabaseName = "favorites.db";
  final favoritesTableName = "favorites";

  int version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(favoritesDatabaseName, version: version,
        onCreate: (db, version) async {
          await createTable(db);
        });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE $favoritesTableName (id INTEGER NOT NULL,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL,$employeeId INTEGER NOT NULL)",
    );
  }

  Future<List<FavoriteModel>> getFavorites() async {
    if (database == null) await open();
    var selectResult = await database!
        .rawQuery("SELECT * FROM $favoritesTableName");

    List<FavoriteModel> favorites = [];
    for (var element in selectResult) {
      favorites.add(FavoriteModel.fromJson(element));
    }

    return favorites;
  }

  getEmployeesFromMysql() async{
    if (database == null) await open();
    DbHelperHttp dbHelper = DbHelperHttp();
    var result = await dbHelper.getFavorites(user.id!);

    for (var element in result) {
      var isExistingData = await database!.rawQuery("SELECT * FROM $favoritesTableName where id="+element['id']);
      if(isExistingData.isEmpty){
        await database!.insert(favoritesTableName, <String, Object?>{
          'id' : element['id'],
          'barberId' : element['barberId'],
          'userId' : element['userId'],
          'employeeId' : element['employeeId'],
        });
      }

    }
  }

  Future close() async {

  }
}