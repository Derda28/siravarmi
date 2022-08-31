import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/widgets/list_items/list_item.dart';

import '../../models/employee_model.dart';
import '../../utilities/consts.dart';


class SelectBarberPopupScreen extends StatelessWidget {
  List<EmployeeModel> employees = [];
  EmployeeModel? selectedEmployee;
  SelectBarberPopupScreen({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            height: 300,
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) => OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
                    overlayColor: MaterialStateColor.resolveWith((states) => secondaryColor),
                  ),
                  onPressed: (){
                    selectedEmployee = employees[index];
                    Navigator.pop(context, selectedEmployee);
                  },
                  child: ListTile(
                    title: Text(
                      (index+1).toString()+". ${employees[index].name}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: secondaryFontFamily,
                          color: Colors.white
                      ),
                    ),
                    trailing: Text(
                      "${employees[index].working}",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: secondaryFontFamily,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
