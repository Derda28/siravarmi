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
      "CREATE TABLE $favoritesTableName (id INTEGER PRIMARY KEY,$userId INTEGER NOT NULL,$barberId INTEGER NOT NULL,$employeeId INTEGER)",
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

  isFavorite(int barberId) async {
    if (database == null) await open();

    var selectResult = await database!
        .rawQuery("SELECT * FROM $favoritesTableName where barberId=$barberId AND userId=${user.id} AND employeeId is null");
    if(selectResult.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  void negateIt(int barberId) async {
    if(database == null) await open();
    
    bool isItPresent = await isFavorite(barberId);
    String sql;

    if(isItPresent){
      sql = "DELETE FROM $favoritesTableName WHERE barberId=$barberId AND userId=${user.id} AND employeeId is null";
      await database!.rawQuery(sql);
    }else{
      sql = "INSERT INTO $favoritesTableName (userId, barberId) VALUES (${user.id}, $barberId)";
      await database!.rawQuery(sql);
    }

    negateItInMysqlToo(sql);
  }

  void negateItInMysqlToo(String sql) {
    DbHelperHttp dbHelper = DbHelperHttp();
    dbHelper.insertRawQuery(sql);
  }

  getFavoritesFromMysql() async{
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