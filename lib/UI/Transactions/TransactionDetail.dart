import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:lucky/UI/PrinterSettings/BluetoothDevice.dart' as userBt;
import 'package:image/image.dart' as img;


class TransactionDetail extends StatefulWidget{
  Transaction transaction;
  TransactionDetail( this.transaction);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();

}

class _TransactionDetailState extends State<TransactionDetail> {
  BlueThermalPrinter bluetooth  = BlueThermalPrinter.instance;
  ScreenshotController screenshotController = ScreenshotController();
  UserInfo? userInfo;
  var isTransfer;

  @override
  void initState() {
    super.initState();
    isTransfer = this.widget.transaction.transactionsType == Constants.TRANSFER_TYPE;
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
        title: "${this.widget.transaction.transactionsType} Detail",
        actions: [
          IconButton(
            onPressed: () {
              Utils.isEnableBT(bluetooth).then((value) => {
                if (value)
                  {
                    _connect(),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        Utils.showSnackBar(
                            text: "Please enable bluetooth!")),
                  }
              });
            },
            icon: Icon(Icons.print),
          ),
          SizedBox(
            width: 16,
          )
        ]
      ),
      body: orientation == Orientation.portrait
          ? buildPortraitView(
      )
          : buildLandscapeView(

      ),
    );
  }

  buildPortraitView() {
    var length = userInfo!.name.length > 15 ? userInfo!.name.length : 0.0;
    return SingleChildScrollView(
      child: Screenshot(
        controller: screenshotController,
        child: Container(
            color: Colors.green[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                userInfo!.url.isNotEmpty ? Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left:90.0,top: 2.0,bottom: 1.0),
                        child:  Container(
                          decoration: BoxDecoration(
                            color: Colors.green[50],),
                          height: 80,
                          child: Image.network(
                            userInfo!.url,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ]):
                SizedBox.shrink(),
                Card(
                  elevation: 1,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(children: [
                    Container(
                      width:260,
                      padding:
                      EdgeInsets.only(top: 1.0, left: (80.0 - length), bottom: 2.0),
                      child: Text(
                        userInfo!.name,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ]),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 1,bottom: 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: isTransfer ?  Row(
                            children: <Widget>[
                              Text("Transferor Name :" , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                             Container(
                               width: 150,
                                  decoration: BoxDecoration(
                                    // color: Colors.green[50],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                    child: Text(this.widget.transaction.fromCustomerName.isEmpty ? "Unknown" : this.widget.transaction.fromCustomerName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                            ],
                          ) :
                          Row(
                            children: <Widget>[
                              Text("Withdrawer Name : " , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                width: 150,
                                  decoration: BoxDecoration(
                                    // color: Colors.green[50],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                    child: Text(this.widget.transaction.toCustomerName.isEmpty ? "Unknown" : this.widget.transaction.toCustomerName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                        fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      Padding(
                            padding: EdgeInsets.all(2.0),
                            child: isTransfer ?
                            Row(
                              children: <Widget>[
                                Text("Recipient Name : " , style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                ),),
                                Container(
                                  width: 150,
                                    decoration: BoxDecoration(
                                      // color: Colors.green[50],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      child: Text(this.widget.transaction.toCustomerName.isEmpty ? "Unknown": this.widget.transaction.toCustomerName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                  ),
                              ],
                            ) :
                            Row(
                              children: <Widget>[
                                Text("Transferor Name : " , style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                ),),
                                Container(
                                  width: 150,
                                    decoration: BoxDecoration(
                                      // color: Colors.green[50],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      child: Text(this.widget.transaction.fromCustomerName.isEmpty ? "Unknown" : this.widget.transaction.fromCustomerName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),

                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 1,bottom: 2),
                    child: Column(
                      children :[
                        Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Recipient Phone :" , style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold
                            ),),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                                child: Text(this.widget.transaction.toPhone ,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            )
                          ],
                        ),
                      ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Transferor Phone :" , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                                  child: Text(this.widget.transaction.fromPhone ,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Card(
                  elevation: 3,
                    shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4,bottom: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Amount : " , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                  child: Text(this.widget.transaction.amount.toString() ,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Charges : " , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(this.widget.transaction.charges.toString() ,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Text("Total :" , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text((this.widget.transaction.charges + this.widget.transaction.amount).toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ]),
                ),

                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4,bottom: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Agent :" , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(this.widget.transaction.agent ,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Date :" , style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(this.widget.transaction.date,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "#1-" + (this.widget.transaction.id! + 1000).toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55,),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.green[50],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      Utils.formatTime(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
      ),
    );

  }

  buildLandscapeView() {
    var length = userInfo!.name.length > 15 ? userInfo!.name.length : 0.0;
    return ListView(
      children: [
        Screenshot(
          controller: screenshotController,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2,vertical: 4),
            color: Colors.green[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                userInfo!.url.isNotEmpty ? Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left:90.0,top: 8.0,bottom: 4.0),
                        child:  Container(
                          decoration: BoxDecoration(
                            color: Colors.green[50],),
                          height: 80,
                          child: Image.network(
                            userInfo!.url,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ]):
                SizedBox.shrink(),
                Card(
                  elevation: 1,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(children: [
                    Container(
                      width:260,
                      padding:
                      EdgeInsets.only(top: 1.0, left: (80.0 - length), bottom: 2.0),
                      child: Text(
                        userInfo!.name,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ]),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2,top: 4,bottom: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: isTransfer ?  Row(
                            children: <Widget>[
                              Text("Transferor Name : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  child: Text(this.widget.transaction.fromCustomerName.isEmpty ? "Unknown" : this.widget.transaction.fromCustomerName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ) :
                          Row(
                            children: <Widget>[
                              Text("Withdrawer Name : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  child: Text(this.widget.transaction.toCustomerName.isEmpty ? "Unknown" : this.widget.transaction.toCustomerName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: isTransfer ?
                          Row(
                            children: <Widget>[
                              Text("Recipient Name : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,),
                                  child: Text(this.widget.transaction.toCustomerName.isEmpty ? "Unknown": this.widget.transaction.toCustomerName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ) :
                          Row(
                            children: <Widget>[
                              Text("Transferor Name : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),

                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,),
                                  child: Text(this.widget.transaction.fromCustomerName.isEmpty ? "Unknown" : this.widget.transaction.fromCustomerName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black87,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2,top: 4,bottom: 4),
                    child: Column(
                      children :[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Recipient Phone : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(this.widget.transaction.toPhone ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Transferor Phone : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(this.widget.transaction.fromPhone ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black87,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2,top: 4,bottom: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Amount : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  child: Text(this.widget.transaction.amount.toString() ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Charges : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(this.widget.transaction.charges.toString() ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Text("Total :" , style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text((this.widget.transaction.charges + this.widget.transaction.amount).toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ]),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2,top: 4,bottom: 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Agent : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(this.widget.transaction.agent ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text("Date : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15,top: 4,bottom: 4),
                                  child: Text(this.widget.transaction.date,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "#1-" + (this.widget.transaction.id! + 1000).toString(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55,),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.green[50],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      Utils.formatTime(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),


      ],
    );
  }

  _connect() {
    try {
      basicInfo.getPrinterDevice().then((value) {
        if(value != null){
          userBt.BluetoothDevice bt = value;
          BluetoothDevice device = BluetoothDevice(bt.name, bt.address);
          bluetooth.isConnected.then((isConnected) => {
            if (!isConnected!)
              {
                bluetooth.connect(device).then((value) => {
                  printVoucher(),
                }),
              }
          });
        }else{
          Utils.errorDialog(context, "No connected printer found!");

        }

      });
    } on PlatformException {}

  }

  void getUserInfo() {
    basicInfo.getUserInfo().then((value) {
      setState(() {
        userInfo = value;
      });
    });
  }

  printVoucher() {
    screenshotController
        .capture(pixelRatio: 1.5, delay: Duration(milliseconds: 200))
        .then((Uint8List? capturedImage) async {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected!) {

          List<Uint8List> imgList = [];

          img.Image receiptImg = img.decodePng(capturedImage);
          for (var i = 0; i <= receiptImg.height; i += 200) {
            img.Image cropedReceiptImg =
            img.copyCrop(receiptImg, 0, i, receiptImg.width, 200);

            var bytes = img.encodePng(cropedReceiptImg);

            imgList.add(bytes as Uint8List);
          }
          imgList.forEach((element) {
            bluetooth.printImageBytes(element.buffer
                .asUint8List(element.offsetInBytes, element.lengthInBytes));
          });
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.printCustom("--------------------------------", 1, 1);
          bluetooth.paperCut();
          bluetooth.disconnect();
        }
      });
    }).catchError((onError) {
      print(onError);
    });
  }

}