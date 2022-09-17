import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:siravarmi/screens/menu_about_screen.dart';
import 'package:siravarmi/screens/menu_account_info_screen.dart';
import 'package:siravarmi/screens/menu_barbers_screen.dart';
import 'package:siravarmi/screens/menu_favorite_screen.dart';
import 'package:siravarmi/screens/menu_setting_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/widgets/navbar.dart';
import 'package:siravarmi/widgets/button/setting_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilities/custom_screen_route.dart';
import '../../widgets/appbar.dart';
import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State {
  String profileUrl =
      "https://icdn.ensonhaber.com/crop/250x141-85/resimler/diger/esh_54955.jpg";
  String customerName = "Mustafa Savaş";
  double textFont = getSize(18);
  double iconFont = getSize(22);
  double containerHSize = getSize(80);
  double containerWSize = getSize(166);
  double elevationSize = getSize(4);
  double borderSize = getSize(10);

  final Uri toPrivacyLaunch = Uri(scheme: 'https', host: 'www.google.com');
  final Uri toTermsOfUseLaunch = Uri(scheme: 'https', host: 'www.youtube.com');

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
        await onBackPressed(context);
        return true;
      },
        child: Scaffold(
          appBar: Appbar(label: "Menü", labelHome: "", fromHome: false),
          body: Column(
            children: [avatarBody()],
          ),
          bottomNavigationBar: Navbar(3, context),
        )
    );
  }

  avatarBody() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
              image: NetworkImage(profileUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(getSize(50)),
            ),
          ),
          height: getSize(85),
          width: getSize(85),
          margin: EdgeInsets.only(top: getSize(40), left: getSize(40)),
        ),
        Container(
          margin: EdgeInsets.only(
              top: getSize(66), left: getSize(140), right: getSize(40)),
          alignment: Alignment.center,
          child: AutoSizeText(
            maxLines: 1,
            customerName,
            style: TextStyle(
              color: primaryColor,
              fontSize: getSize(28),
            ),
          ),
        ),
        Divider(
          height: getSize(293),
          color: Colors.black,
          thickness: getSize(1),
          indent: getSize(40),
          endIndent: getSize(40),
        ),
        Padding(
          padding: EdgeInsets.only(top: getSize(180), bottom: getSize(10)),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                        selectedIcon: Icons.favorite,
                        buttonTitle: "Favoriler",
                        itemClicked: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuFavoriteScreen())),
                      ),
                    ),
                    SizedBox(width: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                          selectedIcon: Icons.settings,
                          buttonTitle: "Ayarlar",
                        itemClicked: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuSettingScreen())),
                      ),
                    ),
                    SizedBox(width: getSize(300),height: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                          selectedIcon: Icons.account_circle_outlined,
                          buttonTitle: " Hesap \n Bilgileri",
                        itemClicked: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuAccountInfoScreen())),
                      ),
                    ),
                    SizedBox(width: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                          assetImage: "assets/images/BarberIcon2.png",
                          buttonTitle: "Berberler",
                        itemClicked: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuBarbersScreen())),
                      ),
                    ),
                    SizedBox(width: getSize(300),height: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                          selectedIcon: Icons.text_snippet_outlined,
                          buttonTitle: "Hakkında",
                        itemClicked: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MenuAboutScreen())),
                      ),
                    ),
                    SizedBox(width: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                        selectedIcon: Icons.format_align_center,
                        buttonTitle: " Kullanım\n Koşulları",
                        itemClicked: () => setState(() {
                          _launched = _launchInBrowser(toTermsOfUseLaunch);
                        }),
                      ),
                    ),
                    SizedBox(width: getSize(300),height: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                        selectedIcon: Icons.security,
                        buttonTitle: "Gizlilik",
                        itemClicked: () => setState(() {
                          _launched = _launchInBrowser(toPrivacyLaunch);
                        }),
                      ),
                    ),
                    SizedBox(width: getSize(5),),
                    Container(
                      height: containerHSize,
                      width: containerWSize,
                      child: SettingButtons(
                        selectedIcon: Icons.exit_to_app,
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        buttonTitle: "Çıkış",
                        itemClicked: () {
                          setState(() {
                            isLoggedIn = false;
                          });
                          Navigator.pushReplacement(
                              context, CustomScreenRoute(child: HomeScreen()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  onBackPressed(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, CustomScreenRoute(child: HomeScreen()));
    });
  }
}
