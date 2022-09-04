import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/screens/barberList_screen.dart';

import '../../utilities/consts.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getSize(50),
        width: getSize(350),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
            overlayColor: MaterialStateColor.resolveWith((states) => fontColor.withOpacity(0.1))
          ),
          onPressed: (){btnIsClicked(context);},
          child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Icon(
                        Icons.search_rounded,
                        color: fontColor,
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Berber bul",
                    style: TextStyle(
                      fontSize: getSize(14),
                      color: fontColor,
                    ),
                  ),
                ),
          ]),
        ));
  }

  void btnIsClicked(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BarberListScreen(whichBtn: "search",)));
  }
}
