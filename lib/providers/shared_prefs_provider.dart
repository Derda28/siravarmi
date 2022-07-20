

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProvider {

  late SharedPreferences prefs;
  static const String sortTypeKey = "sortType";



  Future<void> createSharedPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSortType(String sortType) async {
    await createSharedPrefs();
    prefs.setString(sortTypeKey, sortType);
    print("OkeeySaved");
  }

  Future<String?> loadSortType() async {
    await createSharedPrefs();
    if(prefs.getString(sortTypeKey)==null){
      saveSortType("gelismis");
      return "gelismis";
    }else{
      return prefs.getString(sortTypeKey);
    }
  }

}