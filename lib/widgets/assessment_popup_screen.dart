import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/consts.dart';

final String _heroAssessment = "assessment-hero";

class AssessmentPopUpScreen extends StatelessWidget {
  const AssessmentPopUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 300,top: 200),
        child: Hero(
          tag: _heroAssessment,
          child: Material(
            elevation: 2,
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Değerlendirme",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        fontSize: getSize(18),
                        color: Colors.grey),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.star_border_rounded),
                          color: primaryColor,
                          iconSize: getSize(60),
                          onPressed: () {}),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.star_border_rounded),
                          color: primaryColor,
                          iconSize: getSize(60),
                          onPressed: () {}),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.star_border_rounded),
                          color: primaryColor,
                          iconSize: getSize(60),
                          onPressed: () {}),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.star_border_rounded),
                          color: primaryColor,
                          iconSize: getSize(60),
                          onPressed: () {}),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.star_border_rounded),
                          color: primaryColor,
                          iconSize: getSize(60),
                          onPressed: () {}),
                    )
                  ],
                ),
                Container(

                  child: SizedBox(
                    width: getSize(332),
                    height: getSize(100),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      minLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Yorum",
                          hintStyle: TextStyle(
                              fontSize: getSize(12)
                          )
                      ),

                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent
                    ),
                    child: Text(
                      "Gönder",
                      style: TextStyle(
                          fontSize: getSize(16),
                          color: primaryColor
                      ),
                    ),
                    onPressed: (){},
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
