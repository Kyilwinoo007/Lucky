import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/Repository/MoneyInputViewModel.dart';
import 'package:lucky/UI/Home/home.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:lucky/main.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserInfo userInfo;
  final MoneyInputViewModel model = serviceLocator<MoneyInputViewModel>();
  List<BalanceData> balanceList = [];
  List<OpeningClosingData> openingBalanceList = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      ResponsiveWidgets.init(
        context,
        height: 800,
        width: 480,
        allowFontScaling: true,
      );
    } else {
      ResponsiveWidgets.init(
        context,
        width: 800,
        height: 480,
        allowFontScaling: true,
      );
    }
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: luckyAppbar(
        context: context,
        title: "Profile",
      ),
      body: orientation == Orientation.portrait
          ? buildPortraitView()
          : buildPortraitView(),
    );
  }

  buildPortraitView() {
    return SingleChildScrollView(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          Stack(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  userInfo.name.isEmpty ? "-" : userInfo.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Phone No. : ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  userInfo.phone.isEmpty ? "-" : userInfo.phone,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Email : ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  userInfo.email.isEmpty ? "-" : userInfo.email,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      //todo edit
                    },
                    child: Icon(
                      Icons.edit,
                      color: LuckyColors.splashScreenColors,
                      size: 22,
                    ),
                  ))
            ],
          ),
          InkWell(
            onTap: (){
              getAllBalanceByDate();

            },
            child: Stack(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Close Balance",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 22,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Setting",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    //todo go to setting
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: (){
              Utils.checkInternetConnection(context).then((value) => {
              if(!value){
              _scaffoldKey.currentState!.showSnackBar(Utils.showSnackBar())
              }else{
                Utils.confirmDialog(context, "Confirm!", "Are you sure you want to log out?").then((value) => {
                  if(value){
                  FirebaseFirestore.instance
                  .collection(Constants.firestore_collection)
                  .doc(userInfo.id)
                  .update({
                "isActive": false,
              }).then((_) {
                basicInfo.signOutClearData().then((value) {
                  if(value){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "splashScreen", (Route<dynamic> route) => false);
                  }
                });
                // Navigator.of(context).pushReplacement(new MaterialPageRoute(
                // builder: (BuildContext context) => Home()));
              }),
                  }
                }),
              }
              });

            },
            child: Stack(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Log Out",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }

  void getUserInfo() async{
   UserInfo userInfo = await basicInfo.getUserInfo();
   if(userInfo != null){
     setState(() {
       this.userInfo = userInfo;
     });
   }

  }

  void getAllBalanceByDate() async{
    balanceList = await model.getBalanceByDate(context,Utils.getCurrentDate());
    print("balanceList"+ jsonEncode(balanceList));
    if(balanceList.length == 0){
      Utils.errorDialog(context, "There is no balance today!");
    }else{
      getAllOpeningBalanceByDate();
    }
  }

  void getAllOpeningBalanceByDate() async{
    openingBalanceList = await model.getAllOpeningBalanceByDate(context,Utils.getCurrentDate());
    if(openingBalanceList.length > 0 ){
      updateClosingBalance();
      updateBalance();
    }
  }

  void updateClosingBalance() {
    for(int i = 0 ; i< balanceList.length ; i ++){
      for(int ii = 0 ; ii< openingBalanceList.length ; ii ++){
        if(balanceList[i].agent == openingBalanceList[ii].agent){
          BalanceData balanceData = balanceList[i];
          OpeningClosingData data = openingBalanceList[ii];
          model.updateOpenClosingBalance(OpeningClosingData(
              id: data.id,
              openingCash: data.openingCash,
              openingEMoney: data.openingEMoney,
              date: data.date,
              agent: data.agent,
              closingCash: balanceData.cash,
              closingEMoney: balanceData.eMoney));
          break;
        }
      }
    }
  }

  void updateBalance() {
    for(int i = 0 ; i< balanceList.length ; i ++ ){
      BalanceData balanceData = balanceList[i];
      model.updateBalance(BalanceData(id:balanceData.id,cash: 0.0, eMoney: 0.0, date: balanceData.date, agent: balanceData.agent));
    }
  }
}
