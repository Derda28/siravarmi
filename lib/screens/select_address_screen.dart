import 'package:flutter/material.dart';
import 'package:siravarmi/utilities/consts.dart';

import '../widgets/filter_btn.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectAddressState();
  }
}

class _SelectAddressState extends State {
  IconData iconData = Icons.arrow_drop_down;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomSheet: buildConfirmBtn(),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(
        "KONUM SECIMI",
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontFamily: primaryFontFamily),
      ),
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      height: 250,
      child: Column(children: [
        FilterBtn(title: "Türkiye", subtitle: "", icon: iconData),
        FilterBtn(title: "Sehir", subtitle: "Tüm Sehirler", icon: iconData),
        FilterBtn(title: "Ilce", subtitle: "Beykoz", icon: iconData),
        FilterBtn(
            title: "Semt/Mahalle", subtitle: "Yaliköy Mh.", icon: iconData),
      ]),
    );
  }

  buildConfirmBtn() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
            overlayColor: MaterialStateColor.resolveWith((states) => secondaryColor.withOpacity(0.5))
        ),
        onPressed: () {  },
        child: Container(
          width: 404,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Uygula",
            style: TextStyle(
              fontSize: 16,
              fontFamily: primaryFontFamily,
              color: Colors.white,
            ),
          ),
        ),

      ),
    );
  }
}
