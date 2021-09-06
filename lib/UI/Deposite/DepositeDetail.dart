import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/UI/Widgets/CustomButton.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:lucky/UI/PrinterSettings/BluetoothDevice.dart' as userBt;




class DepositeDetail extends StatefulWidget {
  Transaction transaction;

  DepositeDetail(this.transaction);

  @override
  State<StatefulWidget> createState() => _DepositeDetailState();
}

class _DepositeDetailState extends State<DepositeDetail> {
  ScreenshotController screenshotController = ScreenshotController();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  String pathImage = "";
  var bytesData;

  @override
  void initState() {
    super.initState();
    //initSavetoPath();
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
            onPressed: (){
              Utils.isEnableBT(bluetooth).then((value) => {
                if(value){
                  _connect(),
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(Utils.showSnackBar(text: "Please enable bluetooth!")),
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
          ? buildPortraitView()
          : buildLandscapeView(),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Image capturedImage,String pathImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.file(File(pathImage))
                : Container()),
      ),
    );
  }

  buildPortraitView() {
    final submitButton = SolidGreenButton(
      title: "Print",
      clickHandler: () async {
        Utils.isEnableBT(bluetooth).then((value) => {
          if(value){
            _connect(),
      }else{
            ScaffoldMessenger.of(context).showSnackBar(Utils.showSnackBar(text: "Please enable bluetooth!")),
          }
        });
      },
    );

    return SingleChildScrollView(
      child:  Center(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
              width: 250, //250
              // margin: EdgeInsets.symmetric(horizontal: 80),
            color: Colors.green[50],
              child: Column(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Name  ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      this.widget.transaction.fromCustomerName.isEmpty
                                          ? "Unknown"
                                          : this.widget.transaction.fromCustomerName,
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Phone No. ",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    this.widget.transaction.fromPhone,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Amount  ",
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
                                      vertical: 8, horizontal: 8),
                                  child: Text(
                                    this.widget.transaction.amount.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Commission  ",
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
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    this.widget.transaction.commission.toString(),
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
                    Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Agent  ",
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
                                      horizontal: 8, vertical: 8),
                                  child: Text(
                                    this.widget.transaction.agent,
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
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Date  ",
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
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    this.widget.transaction.date,
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
                    // Divider(
                    //   color: Colors.black,
                    //   height: 1,
                    // ),
                  ],
                ),
              ]),
            ),
        ),
      ),
    );
  }

  buildLandscapeView() {
    return ListView(children: [
      Screenshot(
        controller: screenshotController,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.green[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                                  this.widget.transaction.fromCustomerName.isEmpty
                                      ? "Unknown"
                                      : this.widget.transaction.fromCustomerName,
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
                                  this.widget.transaction.fromPhone,
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
              Card(
                elevation: 5,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Amount : ",
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
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  this.widget.transaction.amount.toString(),
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
                              "Commission : ",
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
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  this.widget.transaction.commission.toString(),
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
              Card(
                elevation: 5,
                shadowColor: Colors.grey,
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
                              "Agent : ",
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
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  this.widget.transaction.agent,
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
                              "Date : ",
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
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  this.widget.transaction.date,
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
        ),
      ),
    ]);
  }

  writeToFile(Uint8List? image, String dir) async{
    // return await new File(dir).writeAsBytes(
    //     image!.buffer.asUint8List(image.offsetInBytes,image.lengthInBytes));
    return await new File(dir).writeAsBytes(image!);
  }
  void initSavetoPath() async{
    String filename = DateTime.now().microsecondsSinceEpoch.toString() + ".jpg";
    screenshotController
        .capture(pixelRatio: 1.5, delay: Duration(milliseconds: 2000))
        .then((Uint8List? image) async {
      // ShowCapturedWidget(context, image!);
      String dir = (await getApplicationDocumentsDirectory()).path;
     var result =  await writeToFile(image, '$dir/$filename');
      // final readImg = img.decodeImage(File('').readAsBytesSync())!;
      // img.Image imageresize = img.copyResize(readImg,width: )
      setState(() {
        bytesData = image!;
        pathImage = '$dir/$filename';
        print("path => "+ pathImage);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> writeToFileBytes(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void _connect() {
    try{
      basicInfo.getPrinterDevice().then((value){
        userBt.BluetoothDevice bt = value;
       BluetoothDevice device = BluetoothDevice(bt.name,bt.address);
        bluetooth.isConnected.then((isConnected) => {
          if(!isConnected!){
            bluetooth.connect(device).then((value) => {
              printVoucher(),
            }),
          }

        });
      });

    }on PlatformException{

    }
  }

  void printVoucher() {

    String filename = DateTime.now().microsecondsSinceEpoch.toString() + ".jpg";
    screenshotController
        .capture(pixelRatio: 1.5, delay: Duration(milliseconds: 200))
        .then((Uint8List? capturedImage) async {

      bluetooth.isConnected.then((isConnected) {
        if (isConnected!) {

          bluetooth.printCustom("Lucky", 2, 1);
          bluetooth.printNewLine();
          bluetooth.printNewLine();

          // var image = img.decodeImage(capturedImage!);
          // image = img.copyResize(image, width: 380);
          // Uint8List imageByte = img.encodePng(image) as Uint8List;
          //
          // bluetooth.printImageBytes(imageByte.buffer
          //     .asUint8List(imageByte.offsetInBytes, imageByte.lengthInBytes));

          List<Uint8List> imgList = [];

          img.Image receiptImg = img.decodePng(capturedImage);
          print("image width => "+ receiptImg.width.toString()); //360
          for (var i = 0; i <= receiptImg.height; i += 200) {
            img.Image cropedReceiptImg = img.copyCrop(receiptImg, 0, i, receiptImg.width, 200);

            var bytes = img.encodePng(cropedReceiptImg);

            imgList.add(bytes as Uint8List);
          }
          imgList.forEach((element) {
            bluetooth.printImageBytes(element.buffer.asUint8List(element.offsetInBytes,element.lengthInBytes));
          });


          // bluetooth.printImage(pathImage);

          // bluetooth.printLeftRight("Name:",this.widget.transaction.fromCustomerName, 1,charset: "Unicode");
          // bluetooth.printLeftRight("Phone", this.widget.transaction.fromPhone, 1);
          // bluetooth.printLeftRight("Agent", this.widget.transaction.agent, 1);
          // bluetooth.printLeftRight(
          //     "Amount", this.widget.transaction.amount.toString(), 1);
          // bluetooth.printLeftRight(
          //     "Charges", this.widget.transaction.charges.toString(), 1);
          // bluetooth.printNewLine();
          // bluetooth.printNewLine();
          // bluetooth.printNewLine();
          bluetooth.printCustom("--------------------------------", 1, 1);
          bluetooth.paperCut();
          bluetooth.disconnect();
        }
      });

    }).catchError((onError) {
      print(onError);
    });


  }

  // void _testPrint() async{
  //   bt.BluetoothDevice bluetoothDevice = bt.BluetoothDevice();
  //   bluetoothDevice.name = Constants.lstDevices[0].data.name;
  //   bluetoothDevice.type = Constants.lstDevices[0].data.type;
  //   bluetoothDevice.address = Constants.lstDevices[0].data.address;
  //   bluetoothDevice.connected = Constants.lstDevices[0].data.connected;
  //
  //   printerManager.selectPrinter(PrinterBluetooth(bluetoothDevice));
  //
  //   // TODO Don't forget to choose printer's paper
  //   const PaperSize paper = PaperSize.mm58;
  //
  //   // TEST PRINT
  //   // final PosPrintResult res =
  //   // await printerManager.printTicket(await testTicket(paper));
  //
  //   // DEMO RECEIPT
  //   final PosPrintResult res =
  //       await printerManager.printTicket(await demoReceipt(paper),queueSleepTimeMs: 50000);
  // }

  // Future<Ticket> demoReceipt(PaperSize paper) async {
  //   final Ticket ticket = Ticket(paper);
  //
  //   // Print image
  //   // final ByteData data = await rootBundle.load("assets/images/truemoney.jpg");
  //   // final Uint8List bytes = data.buffer.asUint8List();
  //   final img.Image image = img.decodeImage(bytes);
  //   print("image => " + image.width.toString() + image.height.toString());
  //    ticket.image(image);
  //   // ticket.imageRaster(image);
  //   // ticket.imageRaster(image, imageFn: PosImageFn.graphics);
  //
  //
  //   // ticket.text('GROCERYLY',
  //   //     styles: PosStyles(
  //   //       align: PosAlign.center,
  //   //       height: PosTextSize.size2,
  //   //       width: PosTextSize.size2,
  //   //     ),
  //   //     linesAfter: 1);
  //
  //   // ticket.text('889  Watson Lane', styles: PosStyles(align: PosAlign.center));
  //   // ticket.text('New Braunfels, TX', styles: PosStyles(align: PosAlign.center));
  //   // ticket.text('Tel: 830-221-1234', styles: PosStyles(align: PosAlign.center));
  //   // ticket.text('Web: www.example.com',
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //   //
  //   // ticket.hr();
  //   // ticket.row([
  //   //   PosColumn(text: 'Qty', width: 1),
  //   //   PosColumn(text: 'Item', width: 7),
  //   //   PosColumn(
  //   //       text: 'Price', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: 'Total', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   //
  //   // ticket.row([
  //   //   PosColumn(text: '2', width: 1),
  //   //   PosColumn(text: 'ONION RINGS', width: 7),
  //   //   PosColumn(
  //   //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   //
  //   // ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(text: 'PIZZA', width: 7),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(text: 'SPRING ROLLS', width: 7),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // ticket.row([
  //   //   PosColumn(text: '3', width: 1),
  //   //   PosColumn(text: 'CRUNCHY STICKS', width: 7),
  //   //   PosColumn(
  //   //       text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // ticket.hr();
  //   //
  //   // ticket.row([
  //   //   PosColumn(
  //   //       text: 'TOTAL',
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   //   PosColumn(
  //   //       text: '\$10.97',
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         align: PosAlign.right,
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   // ]);
  //   //
  //   // ticket.hr(ch: '=', linesAfter: 1);
  //   //
  //   // ticket.row([
  //   //   PosColumn(
  //   //       text: 'Cash',
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$15.00',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   // ticket.row([
  //   //   PosColumn(
  //   //       text: 'Change',
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$4.03',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //
  //
  //   ticket.feed(2);
  //   ticket.text('Thank you!',
  //       styles: PosStyles(align: PosAlign.center, bold: true));
  //
  //   final now = DateTime.now();
  //   final formatter = DateFormat('MM/dd/yyyy H:m');
  //   final String timestamp = formatter.format(now);
  //   ticket.text(timestamp,
  //       styles: PosStyles(align: PosAlign.center), linesAfter: 2);
  //
  //   // Print QR Code from image
  //   // try {
  //   //   const String qrData = 'example.com';
  //   //   const double qrSize = 200;
  //   //   final uiImg = await QrPainter(
  //   //     data: qrData,
  //   //     version: QrVersions.auto,
  //   //     gapless: false,
  //   //   ).toImageData(qrSize);
  //   //   final dir = await getTemporaryDirectory();
  //   //   final pathName = '${dir.path}/qr_tmp.png';
  //   //   final qrFile = File(pathName);
  //   //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
  //   //   final img = decodeImage(imgFile.readAsBytesSync());
  //
  //   //   ticket.image(img);
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //
  //   // Print QR Code using native function
  //   // ticket.qrcode('example.com');
  //
  //   ticket.feed(2);
  //   ticket.cut();
  //   return ticket;
  // }

  // Future<Ticket> testTicket(PaperSize paper) async {
  //   final Ticket ticket = Ticket(paper);
  //
  //   ticket.text(
  //       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //       styles: PosStyles(codeTable: PosCodeTable.westEur));
  //   ticket.text('Special 2: blåbærgrød',
  //       styles: PosStyles(codeTable: PosCodeTable.westEur));
  //
  //   ticket.text('Bold text', styles: PosStyles(bold: true));
  //   ticket.text('Reverse text', styles: PosStyles(reverse: true));
  //   ticket.text('Underlined text',
  //       styles: PosStyles(underline: true), linesAfter: 1);
  //   ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
  //   ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
  //   ticket.text('Align right',
  //       styles: PosStyles(align: PosAlign.right), linesAfter: 1);
  //
  //   ticket.row([
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col6',
  //       width: 6,
  //       styles: PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //   ]);
  //
  //   ticket.text('Text size 200%',
  //       styles: PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ));
  //
  //   // Print image
  //   // final ByteData data = await rootBundle.load('assets/logo.png');
  //   // final Uint8List bytes = data.buffer.asUint8List();
  //   // final Image image = decodeImage(bytes);
  //   // ticket.image(image);
  //   // Print image using alternative commands
  //   // ticket.imageRaster(image);
  //   // ticket.imageRaster(image, imageFn: PosImageFn.graphics);
  //
  //   // Print barcode
  //   final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  //   ticket.barcode(Barcode.upcA(barData));
  //
  //   // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
  //   // ticket.text(
  //   //   'hello ! 中文字 # world @ éphémère &',
  //   //   styles: PosStyles(codeTable: PosCodeTable.westEur),
  //   //   containsChinese: true,
  //   // );
  //
  //   ticket.feed(2);
  //
  //   ticket.cut();
  //   return ticket;
  // }


}
