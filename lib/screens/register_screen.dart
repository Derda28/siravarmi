import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';

import '../utilities/consts.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final String title = "Kayit Ekrani";
  final String imagePath = "assets/images/GoogleIcon.svg";
  final String buttonName = "Google ile devam et";
  final double size = 25;
  bool isMan = true;
  bool showPassword = false;

  DbHelperHttp dbHelperHttp = DbHelperHttp();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  bool nameError=false, surnameError=false, mailError=false, passwordError=false, repeatPasswordError=false;
  String nameErrorText = "", surnameErrorText="",mailErrorText = "", passwordErrorText = "", repeatPasswordErrorText = "";

  void onTap() {

  }

  @override
  void initState() {
    nameController.addListener(()=> nameControllerFunction());
    surnameController.addListener(()=>surnameControllerFunction());
    mailController.addListener(()=> mailControllerFunction());
    passwordController.addListener(()=> passwordControllerFunction());
    repeatPasswordController.addListener(()=> repeatPasswordControllerFunction());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: getSize(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: getSize(getSize(50)),
                    width: getSize(120),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: nameError ? Border.all(color: Colors.red, width: 1.0): Border.all(color: Colors.black, width: 0),
                    ),
                    child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: getSize(12),top: getSize(12)),
                            child: Icon(FontAwesomeIcons.signature, color: fontColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: getSize(50)),
                            child: TextField(
                              controller: nameController,
                              style: TextStyle(
                                fontSize: getSize(15),
                                fontFamily: primaryFontFamily,
                                color: primaryColor,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Isim",
                                  hintStyle: TextStyle(
                                      color: fontColor
                                  )
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    alignment: Alignment.center,
                    height: getSize(getSize(50)),
                    width: getSize(120),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: surnameError ? Border.all(color: Colors.red, width: 1.0): Border.all(color: Colors.black, width: 0),
                    ),
                    child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: getSize(12),top: getSize(12)),
                            child: Icon(FontAwesomeIcons.signature, color: fontColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: getSize(50)),
                            child: TextField(
                              controller: surnameController,
                              style: TextStyle(
                                fontSize: getSize(15),
                                fontFamily: primaryFontFamily,
                                color: primaryColor,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Soyisim",
                                  hintStyle: TextStyle(
                                      color: fontColor
                                  )
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                ],
              ),
            ),//Name//Surname
            SizedBox(
              width: getSize(250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: nameError,
                    child: Text(
                      nameErrorText,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: secondaryFontFamily,
                          fontSize: 12),
                    ),
                  ),
                  Visibility(
                    visible: surnameError,
                    child: Text(
                      surnameErrorText,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: secondaryFontFamily,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),// NameErrorText
            Padding(
              padding: EdgeInsets.only(top: getSize(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getSize(getSize(50)),
                    width: getSize(250),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none
                      ),
                      onPressed: (){genderBtnClicked();},
                      child: Row(
                          children: [
                            Icon(
                              isMan ? FontAwesomeIcons.person : FontAwesomeIcons.personDress,
                              color: isMan ? primaryColor : secondaryColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: getSize(10)),
                              child: Text(
                                isMan?"Erkek":"Kadin",
                                style: TextStyle(
                                  fontSize: getSize(15),
                                  fontFamily: primaryFontFamily,
                                  color: isMan ? primaryColor : secondaryColor,
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),//Gender
            Padding(
              padding: EdgeInsets.only(top: getSize(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: getSize(20)),
                    alignment: Alignment.center,
                    height: getSize(getSize(50)),
                    width: getSize(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: mailError ? Border.all(color: Colors.red, width: 1.0): Border.all(color: Colors.black, width: 0),
                    ),
                    child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: getSize(12),top: getSize(12)),
                            child: Icon(Icons.mail, color: fontColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: getSize(50)),
                            child: TextField(
                              controller: mailController,
                              style: TextStyle(
                                fontSize: getSize(15),
                                fontFamily: primaryFontFamily,
                                color: primaryColor,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mail",
                                  hintStyle: TextStyle(
                                      color: fontColor
                                  )
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),//Mail
            Visibility(
              visible: mailError,
              child: Padding(
                padding: EdgeInsets.only(top: getSize(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mailErrorText,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: secondaryFontFamily,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),//MailErrorText
            Padding(
              padding: EdgeInsets.only(top: getSize(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: getSize(getSize(50)),
                    width: getSize(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: passwordError ? Border.all(color: Colors.red, width: 1.0): Border.all(color: Colors.black, width: 0),
                    ),
                    child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: getSize(12),top: getSize(12)),
                            child: Icon(Icons.lock, color: fontColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: getSize(50)),
                            child: TextField(
                              obscureText: !showPassword,
                              controller: passwordController,
                              style: TextStyle(
                                fontSize: getSize(15),
                                fontFamily: primaryFontFamily,
                                color: primaryColor,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Sifre",
                                  hintStyle: TextStyle(
                                      color: fontColor
                                  )
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),//Password
            Visibility(
              visible: passwordError,
              child: Padding(
                padding: EdgeInsets.only(top: getSize(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      passwordErrorText,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: secondaryFontFamily,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),//PasswordErrorText
            Padding(
              padding: EdgeInsets.only(top: getSize(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: getSize(getSize(50)),
                    width: getSize(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: repeatPasswordError ? Border.all(color: Colors.red, width: 1.0): Border.all(color: Colors.black, width: 0),
                    ),
                    child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: getSize(12),top: getSize(12)),
                            child: Icon(Icons.lock, color: fontColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: getSize(50)),
                            child: TextField(
                              obscureText: !showPassword,
                              controller: repeatPasswordController,
                              style: TextStyle(
                                fontSize: getSize(15),
                                fontFamily: primaryFontFamily,
                                color: primaryColor,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Sifreyi Tekrarla",
                                  hintStyle: TextStyle(
                                      color: fontColor
                                  )
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),//Repeat Password
            Visibility(
              visible: repeatPasswordError,
              child: Padding(
                padding: EdgeInsets.only(top: getSize(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      repeatPasswordErrorText,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: secondaryFontFamily,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),//RepeatPasswordErrorText
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getSize(250),
                    height: getSize(50),
                    child: CheckboxListTile(
                      title: Text(
                        "Sifreyi Göster",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: secondaryFontFamily,
                          color: showPassword ? primaryColor : fontColor,
                        ),
                      ),
                      secondary: showPassword ? Icon(FontAwesomeIcons.eye, color: primaryColor,) : Icon(FontAwesomeIcons.eyeSlash),

                      value: showPassword,
                      onChanged: (bool? value){
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
            ),//ShowPassword
            Padding(
              padding: EdgeInsets.only(top: getSize(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getSize(50),
                    width: getSize(250),
                    child: ElevatedButton(
                      child: Text(
                        "Kayit ol",
                        style: TextStyle(
                          fontFamily: primaryFontFamily,
                          fontSize: getSize(18),
                          color: Colors.white,
                        ),
                      ),
                      onPressed: ()=>registerBtnClicked(context),
                      style: OutlinedButton.styleFrom(
                        animationDuration: Duration(milliseconds: 100),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(25))),
                        backgroundColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),//Register Button
          ],
        ),
      ),
    );
  }

  void genderBtnClicked() {
    setState((){
      isMan = !isMan;
    });
  }

  nameControllerFunction() {
    if (nameController.text == "") {
      setState(() {
        nameError = true;
        nameErrorText = "Isim giriniz.";
      });
    }else{
      setState((){
        nameError = false;
      });
    }
  }

  surnameControllerFunction() {
    if (surnameController.text == "") {
      setState(() {
        surnameError = true;
        surnameErrorText = "Soyisim giriniz.";
      });
    }else{
      setState((){
        surnameError = false;
      });
    }
  }

  mailControllerFunction() {
    if (!mailController.text.contains("@")) {
      setState(() {
        mailError = true;
        mailErrorText = "Mail 'xxx@xxx.com' formatinda olmali";
      });
    }else{
      setState((){
        mailError = false;
      });
    }
  }

  passwordControllerFunction() {
    if(passwordController.text.length<8){
      setState((){
        passwordError = true;
        passwordErrorText = "Sifre en az 8 Karakter uzun olmali.";
      });
    }else{
      setState((){
        passwordError = false;
      });
    }
  }

  repeatPasswordControllerFunction() {
    if(repeatPasswordController.text!=passwordController.text){
      setState((){
        repeatPasswordError = true;
        repeatPasswordErrorText = "Sifreyi yanlis tekrarladiniz.";
      });
    }else{
      setState((){
        repeatPasswordError = false;
      });
    }
  }

  registerBtnClicked(BuildContext context) async{
    nameControllerFunction();
    surnameControllerFunction();
    mailControllerFunction();
    passwordControllerFunction();
    repeatPasswordControllerFunction();

    if(!nameError&&!mailError&&!passwordError&&!repeatPasswordError){
      final responseData = dbHelperHttp.tryRegister(mailController.text,passwordController.text, nameController.text, surnameController.text, isMan);
      String response;
      response = await responseData;
      print(response);

      if(response=='"Success"'){
        Navigator.pop(context, true);
      }else if(response=='"alreadyRegistered"'){
        setState((){
          mailError=true;
          mailErrorText="Böyle bir Mail kayitta zaten var.";
        });
      }else if(response=='"Failure"'){
        _showErrorDialog();

      }
    }
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bir Hata olustu.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tekrar dene.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
