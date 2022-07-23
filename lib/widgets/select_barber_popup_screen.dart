import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/widgets/list_item.dart';

import '../utilities/consts.dart';

final String _heroSelectBarber = "select-barber-hero";

class SelectBarberPopupScreen extends StatelessWidget {
  const SelectBarberPopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: _heroSelectBarber,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              height: 300,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    color: primaryColor,
                    child: Text(
                      "Samet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
