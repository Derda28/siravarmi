import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siravarmi/utilities/consts.dart';

class SortPopupBtn extends StatefulWidget{

  String value,title;

  SortPopupBtn({Key? key, required this.value, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SortPopupState(value, title);
  }

  /*Widget build2({required String value, required String title, required String sortType, required BuildContext context}) {

    return  InkWell(
            onTap: (){

            },
            child: Row(
              children: [
                Radio(
                  value: value,
                  groupValue: sortType,
                  onChanged: (String? value) {
                    setState((){
                      sortType=value!;
                    });
                  },
                  activeColor: primaryColor,

                ),

                Text(title, style: TextStyle(fontSize: 10),),
              ],
            ),
          );
  }*/


  
}

class _SortPopupState extends State{
  String value, title;
  late Future<String> _sortType;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _SortPopupState(this.value, this.title);

  @override
  void initState() async{
    super.initState();
    final SharedPreferences prefs = await _prefs;
    final String sortType = prefs.getString('counter') ?? 0 as String;

    setState(() {
      _sortType = prefs.setString('sortType', sortType).then((bool success) {
        return sortType;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()async{
        saveData(value);
        Navigator.of(context).pop;
      },
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: _sortType,
            onChanged: (Object) async{
              final SharedPreferences prefs = await _prefs;
              final String sortType = value;
              setState((){

                _sortType = prefs.setString('sortType', sortType).then((bool success) {
                  return sortType;
                });
              });
            },
            activeColor: primaryColor,

          ),

          Text(title, style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }

  void saveData (String value)async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('sortType', value);
  }
}