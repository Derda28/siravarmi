

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/popups/sort_popup_btn.dart';

import '../providers/shared_prefs_provider.dart';
import '../utilities/custom_rect_tween.dart';

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

              //SIKINTII!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

              RadioListTile(
                value: "gelismis",
                title: Text("Gelismis", style: TextStyle(fontSize: 12),),
                groupValue: sortType,
                activeColor: primaryColor,
                onChanged: (val) {
                  Navigator.pop(context, val);
                },

              ),
              RadioListTile(
                  value: "Fiyata göre>",
                  groupValue: sortType,
                  title: Text("A", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Fiyata göre<",
                  groupValue: sortType,
                  title: Text("B", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Tarihe göre>",
                  groupValue: sortType,
                  title: Text("C", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  }),
              RadioListTile(
                  value: "Tarihe göre<",
                  groupValue: sortType,
                  title: Text("D", style: TextStyle(fontSize: 12),),
                  activeColor: primaryColor,
                  onChanged: (val){
                    Navigator.pop(context, val);
                  })
              /*SortPopupBtn(value: "gelismis", title: "Gelismis"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "fiyatY", title: "Fiyata göre (Önce en yüksek)"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "fiyatD", title: "Fiyata göre (Önce en düsük)"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "tarihE", title: "Tarihe göre (Önce en erken)"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "tarihG", title: "Tarihe göre (Önce en gec)"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "a-z", title: "Isime göre (A-Z)"),
              const Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              SortPopupBtn(value: "z-a", title: "Isime göre (Z-A)"),*/
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
