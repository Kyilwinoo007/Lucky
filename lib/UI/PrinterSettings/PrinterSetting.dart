// import 'dart:io';
//
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
//
// class PrinterSetting extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _PrinterSettingState();
//
// }
//
// class _PrinterSettingState extends State<PrinterSetting> {
//   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//
//   List<BluetoothDevice> _devices = [];
//   late BluetoothDevice? _device = null;
//   bool _connected = false;
//   bool _pressed = false;
//   late String pathImage;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     // initSavetoPath();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     bluetooth.disconnect();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blue Thermal Printer'),
//       ),
//       body: Container(
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Device:',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   DropdownButton<BluetoothDevice>(
//                     items: _getDeviceItems(),
//                     onChanged: (value) => setState(() => _device = value!),
//                     value: _device,
//                   ),
//                   RaisedButton(
//                     onPressed:
//                     _pressed ? null : _connected ? _disconnect : _connect,
//                     child: Text(_connected ? 'Disconnect' : 'Connect'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
//               child:  RaisedButton(
//                 onPressed: _connected ? _tesPrint : null,
//                 child: Text('TesPrint'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//   Future<void> initPlatformState() async {
//     List<BluetoothDevice> devices = [];
//
//     try {
//       devices = await bluetooth.getBondedDevices();
//     } on PlatformException {
//       // TODO - Error
//     }
//
//     bluetooth.onStateChanged().listen((state) {
//       switch (state) {
//         case BlueThermalPrinter.CONNECTED:
//           setState(() {
//             _connected = true;
//             _pressed = false;
//           });
//           break;
//         case BlueThermalPrinter.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             _pressed = false;
//           });
//           break;
//         default:
//           print(state);
//           break;
//       }
//     });
//
//     if (!mounted) return;
//     setState(() {
//       _devices = devices;
//     });
//   }
//   void initSavetoPath() async{
//     final filename = 'yourlogo.png';
//     var bytes = await rootBundle.load("assets/images/yourlogo.png");
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     writeToFile(bytes,'$dir/$filename');
//     setState(() {
//     pathImage='$dir/$filename';
//     });
//   }
//
//   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
//     List<DropdownMenuItem<BluetoothDevice>> items = [];
//     if (_devices.isEmpty) {
//       items.add(DropdownMenuItem(
//         child: Text('NONE'),
//       ));
//     } else {
//       _devices.forEach((device) {
//         items.add(DropdownMenuItem(
//           child: Text(device.name!),
//           value: device,
//         ));
//       });
//     }
//     return items;
//   }
//   void _connect() {
//     if (_device == null) {
//       show('No device selected.');
//     } else {
//       bluetooth.isConnected.then((isConnected) {
//         if (!isConnected!) {
//           bluetooth.connect(_device!).catchError((error) {
//             setState(() => _pressed = false);
//           });
//           setState(() => _pressed = true);
//         }
//       });
//     }
//   }
//   void _disconnect() {
//     bluetooth.disconnect();
//     setState(() => _pressed = true);
//   }
//
// //write to app path
//   Future<void> writeToFile(ByteData data, String path) {
//     final buffer = data.buffer;
//     return new File(path).writeAsBytes(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//   }
//
//   void _tesPrint() async {
//     //SIZE
//     // 0- normal size text
//     // 1- only bold text
//     // 2- bold with medium text
//     // 3- bold with large text
//     //ALIGN
//     // 0- ESC_ALIGN_LEFT
//     // 1- ESC_ALIGN_CENTER
//     // 2- ESC_ALIGN_RIGHT
//     bluetooth.isConnected.then((isConnected) {
//       if (isConnected!) {
//         bluetooth.printCustom("HEADER",3,1);
//         bluetooth.printNewLine();
//         // bluetooth.printImage(pathImage);
//         bluetooth.printNewLine();
//         bluetooth.printLeftRight("LEFT", "RIGHT",0);
//         bluetooth.printLeftRight("LEFT", "RIGHT",1);
//         bluetooth.printNewLine();
//         bluetooth.printLeftRight("LEFT", "RIGHT",2);
//         bluetooth.printCustom("Body left",1,0);
//         bluetooth.printCustom("Body right",0,2);
//         bluetooth.printNewLine();
//         bluetooth.printCustom("Terimakasih",2,1);
//         bluetooth.printNewLine();
//         bluetooth.printQRcode("Insert Your Own Text to Generate",20,20,1);
//         bluetooth.printNewLine();
//         bluetooth.printNewLine();
//         bluetooth.printCustom("---------------------------------",1,1);
//         bluetooth.paperCut();
//       }
//     });
//   }
//
//   Future show(
//       String message, {
//         Duration duration: const Duration(seconds: 3),
//       }) async {
//     await new Future.delayed(new Duration(milliseconds: 100));
//     Scaffold.of(context).showSnackBar(
//       new SnackBar(
//         content: new Text(
//           message,
//           style: new TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         duration: duration,
//       ),
//     );
//   }
// }