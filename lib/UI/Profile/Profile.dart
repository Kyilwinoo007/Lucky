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
import 'package:lucky/UI/PrinterSettings/PrinterSetting.dart';
import 'package:lucky/UI/PrinterSettings/PrinterSetting.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:lucky/main.dart';
import 'package:provider/provider.dart';
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
                              "Shop Name : ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 250,
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
            ],
          ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                        child:ElevatedButton(
                          onPressed: (){
                            getAllBalanceByDate();

                          },
                          style:ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 5.0,
                          shadowColor: Colors.grey,
                          padding: EdgeInsets.only(top: 16,bottom: 16,left: 18,right: 18),
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children :[
                              Text(
                                "Close Balance",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 22,
                              ),
                            ],
                          ),
                        ),

                      ),)

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                        child:ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => PrinterSetting()));                          },
                          style:ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 5.0,
                          shadowColor: Colors.grey,
                          padding: EdgeInsets.only(top: 16,bottom: 16,left: 18,right: 18),
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children :[
                              Text(
                                "Printer Settings",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 22,
                              ),
                            ],
                          ),
                        ),

                      ),)

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                        child:ElevatedButton(
                          onPressed: (){
                            Utils.checkInternetConnection(context).then((value) => {
                              if(!value){
                                ScaffoldMessenger.of(context).showSnackBar(Utils.showSnackBar()),
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

                                    }),
                                  }
                                }),
                              }
                            });
                          },
                          style:ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 5.0,
                          shadowColor: Colors.grey,
                          padding: EdgeInsets.only(top: 16,bottom: 16,left: 18,right: 18),
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children :[
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 22,
                              ),
                            ],
                          ),
                        ),

                      ),)

                    ],
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
    if(balanceList.length == 0){
      Utils.errorDialog(context, "There is no balance today!");
    }else{
      getAllOpeningBalanceByDate();
    }
  }

  void getAllOpeningBalanceByDate() async{
    openingBalanceList = await model.getAllOpeningBalanceByDate(context,Utils.getCurrentDate());
    var result ;
    if(openingBalanceList.length > 0 ){
     result = await updateClosingBalance();
     result = await updateBalance();
    }
    if(result){
      Utils.successDialog(context, "Success", "Successful!");
    }else{
      Utils.errorDialog(context, "Something went wrong!");
    }
  }

  Future<bool> updateClosingBalance() async{
    var result ;
    for(int i = 0 ; i< balanceList.length ; i ++){
      for(int ii = 0 ; ii< openingBalanceList.length ; ii ++){
        if(balanceList[i].agent == openingBalanceList[ii].agent){
          BalanceData balanceData = balanceList[i];
          OpeningClosingData data = openingBalanceList[ii];
       result =  await  model.updateOpenClosingBalance(OpeningClosingData(
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
    return result;
  }

  Future<bool> updateBalance() async{
    var result;
    for(int i = 0 ; i< balanceList.length ; i ++ ){
      BalanceData balanceData = balanceList[i];
    result = await  model.updateBalance(BalanceData(id:balanceData.id,cash: 0.0, eMoney: 0.0, date: balanceData.date, agent: balanceData.agent));
    }
    return result;
  }
}
