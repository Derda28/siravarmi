import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siravarmi/cloud_functions/dbHelperHttp.dart';
import 'package:siravarmi/models/user_model.dart';
import 'package:siravarmi/screens/register_screen.dart';

import '../utilities/consts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final title = "Giris Ekrani";

  final String imagePath = "assets/images/GoogleIcon.svg";

  final String buttonName = "Google ile devam et";

  final double size = 25;

  DbHelperHttp dbHelperHttp = DbHelperHttp();

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool mailError = false;
  bool passwordError = false;
  String mailErrorText = "";
  String passwordErrorText = "";




  bool showPassword = false;
  bool rememberMe = false;

  void onTap() {}

  @override
  void initState() {
    mailController.addListener(() => mailControllerFunction(),);
    passwordController.addListener(() => passwordControllerFunction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getSize(250),
            height: getSize(50),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide.none),
                elevation: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    height: size,
                    width: size,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    buttonName,
                    style: const TextStyle(
                      color: fontColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ), //GoogleBtn
          Padding(
            padding: EdgeInsets.only(top: getSize(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ya Da",
                  style: TextStyle(
                      color: fontColor,
                      fontFamily: secondaryFontFamily,
                      fontSize: 14),
                )
              ],
            ),
          ), //OR
          Padding(
            padding: EdgeInsets.only(top: getSize(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.center,
                  height: getSize(getSize(50)),
                  width: getSize(250),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: mailError
                        ? Border.all(color: Colors.red, width: 1.0)
                        : Border.all(width: 0, color: Colors.black),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: getSize(12), top: getSize(12)),
                      child: Icon(
                        Icons.mail,
                        color: fontColor,
                      ),
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
                            hintStyle: TextStyle(color: fontColor)),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ), //Mail
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
          ), //MailErrorText
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
                    border: passwordError ? Border.all(color: Colors.red, width: 1.0) : Border.all(color: Colors.black, width: 0),
                  ),
                  child: Stack(
                      children: [
                    Padding(
                      padding: EdgeInsets.only(top: getSize(12), left: getSize(12)),
                      child: Icon(
                        Icons.lock,
                        color: fontColor,
                      ),
                    ),
                    Container(
                      width: getSize(200),
                      padding: EdgeInsets.only(top: getSize(2), left: getSize(40)),
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
                            hintStyle: TextStyle(color: fontColor)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: getSize(2), left: getSize(200)),
                      child: IconButton(
                        icon: Icon(
                            showPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                            color: showPassword ? primaryColor : fontColor,
                          size: 16,
                        ),
                        onPressed: (){
                          setState((){
                            showPassword = !showPassword;
                          });
                        },
                        splashRadius: getSize(25),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ), //Password
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
          ), //PasswordErrorText
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 250,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(getSize(25)))
                  )
                ),
                onPressed: (){
                  setState((){
                    rememberMe = !rememberMe;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      rememberMe ? FontAwesomeIcons.circleCheck :FontAwesomeIcons.circle,
                      color: rememberMe ? primaryColor : fontColor,
                    ),
                    SizedBox(width: 15,),
                    Text(
                      "Beni Hatirla",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: secondaryFontFamily,
                          color: rememberMe ? primaryColor : fontColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                      "Giris",
                      style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: getSize(18),
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      loginBtnClicked(context);
                    },
                    style: OutlinedButton.styleFrom(
                      animationDuration: Duration(milliseconds: 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getSize(25))),
                      backgroundColor: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ), //ConfirmBtn
          Padding(
              padding: EdgeInsets.only(top: getSize(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabin yok mu?",
                      style: TextStyle(
                          color: fontColor,
                          fontFamily: secondaryFontFamily,
                          fontSize: 14)),
                  TextButton(
                      onPressed: () {
                        registerIsClicked(context);
                      },
                      child: Text(
                        "Kayit Ol!",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: primaryFontFamily,
                          color: fontColor,
                        ),
                      ))
                ],
              )), //RegisterBtn
        ],
      ),
    );
  }

  Future<void> registerIsClicked(BuildContext context) async {
    bool registeredNew = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    if(registeredNew){
      _showSuccessDialog();
    }
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tebrikler!'),
          content: Text(
              "Basariyla Kayit oldunuz.\nSimdi giris yapin."
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loginBtnClicked(BuildContext context) async {
    mailControllerFunction();
    passwordControllerFunction();
    if(!mailError&&!passwordError){
      final responseData = dbHelperHttp.tryLogin(mailController.text,passwordController.text);
      LinkedHashMap<String, dynamic> response;
      response = await responseData;

      print(response);

      if(response['success']){
        isLoggedIn = true;
        user = UserModel(
            id: int.parse(response['id']),
            name: response['name'],
            surname: response['surname'],
            mail: response['email'],
            password: response['password'],
            isMan: response['isMan']=="1"?true:false,
        );
        Navigator.pop(context, true);
      }else if(response['message']=='invalidMail'){
        setState((){
          mailError=true;
          mailErrorText="Böyle bir Mail kayitta yok.";
        });
      }else if(response['message']=='invalidPassword'){
        setState(() {
          passwordError=true;
          passwordErrorText="Sifre yanlis";
        });
      }
    }
  }

  void mailControllerFunction() {
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

  void passwordControllerFunction() {
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

}
