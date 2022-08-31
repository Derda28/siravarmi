import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';

import '../../utilities/consts.dart';
import '../dismiss_keyboard.dart';


class AssessmentPopUpScreen extends StatelessWidget {
  AssessmentPopUpScreen({Key? key , required this.initialStars}) : super(key: key);

  double initialStars;

  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Padding(
        padding: EdgeInsets.only(
            left: getSize(10),
            right: getSize(10),
            bottom: getSize(250),
            top: getSize(250)),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(getSize(10))),
              elevation: 2,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: getSize(30)),
                    child: Text(
                      "Değerlendirme",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey,
                          fontSize: getSize(24),
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: getSize(30), left: getSize(30), right: getSize(30)),
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      minRating: 1,
                      maxRating: 5,
                      initialRating: initialStars,
                      itemSize: getSize(50),
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: getSize(4.0)),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: secondaryColor),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: getSize(30), left: getSize(30), right: getSize(30)),
                    child: SizedBox(
                      width: getSize(332),
                      height: getSize(70),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.left,
                        maxLines: 4,
                        minLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Yorum",
                            hintStyle: TextStyle(fontSize: getSize(16))),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: getSize(20)),
                    alignment: Alignment.center,
                    width: getSize(100),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Gönder",
                        style:
                        TextStyle(fontSize: getSize(16), color: primaryColor),
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
