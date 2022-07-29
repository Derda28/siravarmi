import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siravarmi/utilities/consts.dart';

import '../cloud_functions/dbHelperHttp.dart';
import '../models/assessment_model.dart';
import '../models/user_model.dart';

class CommentsListItem extends StatefulWidget {
  AssessmentModel assessment;

  CommentsListItem({required this.assessment, Key? key}) : super(key: key);

  @override
  State<CommentsListItem> createState() => _CommentsListItemState();
}

class _CommentsListItemState extends State<CommentsListItem> {
  UserModel? commentUser;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commentUser!=null?Container(
      padding: EdgeInsets.only(bottom: getSize(10), top: getSize(10), left: getSize(10)),
      /*height: getSize(150),*/
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: fontColor, width: 1.0))),
      child: Stack(
        children: [/*
          //UserProfile
          Container(
            height: getSize(50),
            width: getSize(50),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.all(
                  Radius.elliptical(getSize(50) / 2, getSize(50) / 2)),
              border: Border.all(width: 1.0, color: fontColor),
            ),
          ),*/
          //UserName
          Container(
            margin: EdgeInsets.only(left: getSize(60)),
            child: Text(
              commentUser!.surname != null ? commentUser!.name!+commentUser!.surname!: commentUser!.name!,
              style: TextStyle(
                color: primaryColor,
                fontSize: getSize(14),
                fontFamily: primaryFontFamily,
              ),
            ),
          ),
          //AssessmentStar
          Container(
            margin: EdgeInsets.only(left: getSize(53), top: getSize(10)),
            width: 100,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color:widget.assessment.stars>=1?secondaryColor:fontColor, size: 15,),
                Icon(Icons.star, color:widget.assessment.stars>=2?secondaryColor:fontColor, size: 15,),
                Icon(Icons.star, color:widget.assessment.stars>=3?secondaryColor:fontColor, size: 15,),
                Icon(Icons.star, color:widget.assessment.stars>=4?secondaryColor:fontColor, size: 15,),
                Icon(Icons.star, color:widget.assessment.stars>=5?secondaryColor:fontColor, size: 15,),
              ],
            ),
          ),
          //AssessmentComment
          Container(
            margin: EdgeInsets.only( top: getSize(55)),
            child: Text(
              widget.assessment.command,
              style: TextStyle(
                fontFamily: secondaryFontFamily,
                fontSize: getSize(14),
                color: fontColor
              ),
            )
          )
        ],
      ),
    ):Text("Yükleniyor...");
  }

  Future<void> loadUser() async{
    DbHelperHttp dbHelper = DbHelperHttp();
    final assessmentUserData = dbHelper.getUserFromAssessment(widget.assessment.userId);
    var assUser = await assessmentUserData;

    commentUser = UserModel(
        id: int.parse(assUser["id"]),
        isMan: assUser["isMan"]=='1'?true:false,
      mail: assUser["email"],
      name: assUser["name"],
      password: assUser["password"],
      surname: assUser["surname"]
    );

    setState((){
      commentUser=commentUser;
    });

  }
}
