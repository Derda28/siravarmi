import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:siravarmi/cloud_functions/address_database.dart';
import 'package:siravarmi/cloud_functions/appointments_database.dart';
import 'package:siravarmi/screens/main_screens/home_screen.dart';
import 'package:siravarmi/utilities/consts.dart';
import 'package:siravarmi/utilities/customeTheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cloud_functions/assessment_database.dart';
import 'cloud_functions/barbers_database.dart';
import 'cloud_functions/employees_database.dart';
import 'cloud_functions/favorites_database.dart';
import 'cloud_functions/services_database.dart';
import 'cloud_functions/users_database.dart';
import 'cloud_functions/working_hours_database.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('tr', ''),
        ],
      theme: customTheme,
      home: AnimatedSplashScreen(
          duration: 1500,
          splash: Icons.home,
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: primaryColor)
    );

  }

  Future<void> loadData() async {
    AddressDatabase addDb = AddressDatabase();
    AppointmentDatabase appDb = AppointmentDatabase();
    AssessmentDatabase assDb = AssessmentDatabase();
    BarbersDatabase barbersDb = BarbersDatabase();
    EmployeesDatabase empDb = EmployeesDatabase();
    FavoritesDatabase favDb = FavoritesDatabase();
    ServicesDatabase servicesDb = ServicesDatabase();
    UsersDatabase usersDb = UsersDatabase();
    WorkingHoursDatabase wHDb = WorkingHoursDatabase();

    await addDb.deleteTables();
    await appDb.deleteTables();
    await assDb.deleteTables();
    await barbersDb.deleteTables();
    await empDb.deleteTables();
    await favDb.deleteTables();
    await servicesDb.deleteTables();
    await usersDb.deleteTables();
    await wHDb.deleteTables();

    await addDb.getAddressFromMySql();
    await appDb.getAppointmentsFromMySql(user.id!);
    await assDb.getAssessmentsFromMySql();
    await barbersDb.getBarbersFromMysql();
    await empDb.getEmployeesFromMysql();
    await favDb.getFavoritesFromMysql();
    await servicesDb.getEmployeesFromMysql();
    await usersDb.getUsersFromMySql();
    await wHDb.getWorkingHoursFromMysql();

    favorites = await favDb.getFavorites();
    addresses = await addDb.getAddress();
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for thse state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 5;

  void getTheFuckingData() async {
    DbHelper dbHelper = DbHelper();
    List<dynamic> list = await dbHelper.getdata();
    _counter = list.length;
    _incrementCounter();
  }

  void _incrementCounter() {
    setState((){
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
      _counter = _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTheFuckingData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
