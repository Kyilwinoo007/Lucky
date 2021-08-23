//@dart = 2.9
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/UI/Home/home.dart';
import 'package:lucky/UI/Login/CustomSplashScreen.dart';
import 'package:lucky/UI/Login/Login.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:provider/provider.dart';

import 'common/serviceLocator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

  }

class _MyAppState extends State<MyApp> {
   MyDatabase _myDatabase;

  @override
  void initState() {
    super.initState();
    if (_myDatabase == null) {
      this._myDatabase = new MyDatabase();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BalanceDao>(
          create: (_) => this._myDatabase.balanceDao,
        ),
        Provider(create :(_) => this._myDatabase.transactionsDao),

        Provider(create :(_) => this._myDatabase.openingClosingDao),
        Provider(create :(_) => this._myDatabase.userDao),
        Provider(create :(_) => this._myDatabase.balanceInputRecordsDao),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: LuckyColors.splashScreenColors,
          accentColor: LuckyColors.splashScreenColors,
          iconTheme: IconThemeData(
            size: 30,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 12.5,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
            caption: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: 'Lucky',
        home: LuckySplashScreen(),
        routes: {
          'splashScreen': (context) => LuckySplashScreen(),
          'home':(context) => Home(),
        },
       ),
    );
  }
}


class LuckySplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LuckSplashScreenState();

}

class _LuckSplashScreenState extends State<LuckySplashScreen>{
   bool isAlreadyLogin = false;
  @override
  void initState() {
    super.initState();

    getUserInfo();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomSplashScreen(
        seconds: 6,
        navigateAfterSeconds: isAlreadyLogin ? Home() : Login(),
        title: new Text(
          '',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),

        loadingText: Text("Please wait...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),),
        backgroundColor: LuckyColors.splashScreenColors,
      ),
    );
  }

  void getUserInfo() async{
    UserInfo userInfo =await basicInfo.getUserInfo();
    if(userInfo != null){
      setState(() {
        isAlreadyLogin = true;
      });
    }else{
      setState(() {
        isAlreadyLogin = false;
      });
    }
  }


}
