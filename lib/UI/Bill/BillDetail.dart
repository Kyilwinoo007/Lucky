import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:lucky/UI/PrinterSettings/BluetoothDevice.dart' as userBt;
import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';

class BillDetail extends StatefulWidget{
  Transaction transaction;
  BillDetail(this.transaction);

  @override
  State<StatefulWidget> createState() => _BillDetailState();

}

class _BillDetailState extends State<BillDetail> {
  ScreenshotController screenshotController = ScreenshotController();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  UserInfo? userInfo;
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
    return SingleChildScrollView(
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.green[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 3,
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(children: [
                  Padding(
                    padding:
                    EdgeInsets.only(top: 8.0, left: 90, bottom: 8.0),
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
                  padding: EdgeInsets.only(left:4,top: 4,bottom: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Bill Name :" , style: TextStyle(
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
                              ),
                          ],
                        ) ,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Phone No. " , style: TextStyle(
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
                                child: Text(this.widget.transaction.fromPhone.isEmpty ? "-" : this.widget.transaction.fromPhone,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            )
                          ],
                        ) ,
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
                  padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Amount :" , style: TextStyle(
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
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
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
                            Text("Charges :" , style: TextStyle(
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
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                child: Text(this.widget.transaction.commission.toString() ,
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
                  padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
                  child:
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Total :" , style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
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
                                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
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
                  padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
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
                           Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 4),
                                child: Text(this.widget.transaction.agent ,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
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
                          Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32,vertical: 4),
                                child: Text(this.widget.transaction.date,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
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
    return ListView(
        children :[
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.green[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 3,
                    shadowColor: Colors.grey,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Row(children: [
                      Padding(
                        padding:
                        EdgeInsets.only(top: 8.0, left: 90, bottom: 8.0),
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
                      padding: EdgeInsets.only(left:4,top: 4,bottom: 4),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Text("Bill Name :" , style: TextStyle(
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
                                ),
                              ],
                            ) ,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Text("Phone No. " , style: TextStyle(
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
                                    child: Text(this.widget.transaction.fromPhone.isEmpty ? "-" : this.widget.transaction.fromPhone,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                )
                              ],
                            ) ,
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
                      padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Text("Amount :" , style: TextStyle(
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
                                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
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
                                Text("Charges :" , style: TextStyle(
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
                                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                    child: Text(this.widget.transaction.commission.toString() ,
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
                      padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
                      child:
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text("Total :" , style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
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
                                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
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
                      padding: EdgeInsets.only(left: 4,top: 4,bottom: 4),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 4),
                                  child: Text(this.widget.transaction.agent ,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 4),
                                  child: Text(this.widget.transaction.date,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),),
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

        ]
    );
  }

  void getUserInfo() {
    basicInfo.getUserInfo().then((value) {
      setState(() {
        userInfo = value;
      });
    });
  }

  _connect() {
    try {
      basicInfo.getPrinterDevice().then((value) {
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
      });
    } on PlatformException {}
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
          bluetooth.printCustom("--------------------------------", 1, 1);
          bluetooth.printNewLine();
          bluetooth.paperCut();
          bluetooth.disconnect();
        }
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}