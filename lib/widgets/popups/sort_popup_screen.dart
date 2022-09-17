

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/popups/sort_popup_btn.dart';

import '../../providers/shared_prefs_provider.dart';
import '../../utilities/custom_rect_tween.dart';

class SortPopupScreen extends StatelessWidget{
  String sortType;

  SortPopupScreen({Key? key, required this.sortType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Material(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.sort, color: primaryColor),
                  Text("Sirala")
                ],
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),

              RadioListTile(
                  value: "Fiyata göre>",
                  groupValue: sortType,
                  title: Text("Fiyata göre (önce en pahalisi)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Fiyata göre<",
                  groupValue: sortType,
                  title: Text("Fiyata göre (önce en ucuzu)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Tarihe göre>",
                  groupValue: sortType,
                  title: Text("Tarihe Göre (önce en eskisi)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Tarihe göre<",
                  groupValue: sortType,
                  title: Text("Tarihe Göre (önce en yenisi)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Degerlendirmeye göre>",
                  groupValue: sortType,
                  title: Text("Degerlendirmeye Göre (önce en yüksek)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Degerlendirmeye göre<",
                  groupValue: sortType,
                  title: Text("Degerlendirmeye Göre (önce en düsük)", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void saveSortType(String val,  BuildContext context){
    SharedPrefsProvider().saveSortType(val).then((value) {

    });
  }


}
