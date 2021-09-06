import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/UI/Widgets/ListItem.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BluetoothDevices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BluetoothDeviceState();
}

class _BluetoothDeviceState extends State<BluetoothDevices> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  // List<BluetoothDevice> _devices = [];
  List<ListItem<BluetoothDevice>> _devices = [];
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void initState() {
    super.initState();
    getDevices();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bluetooth.disconnect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer Settings"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SmartRefresher(
          onRefresh: _refresh,
          controller: _refreshController,
          child: ListView.builder(
            itemCount: _devices.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _connect(_devices[index].data ,index);
              },
              child: Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.bluetooth,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text(_devices[index].data.name!),
                    subtitle: Text(_devices[index].isSelected
                        ? "Connected"
                        : "Tap to Connect"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _connect(BluetoothDevice device, int index) {
    try{
      bluetooth.isConnected.then((isConnected) => {
        if(!isConnected!){
          bluetooth.connect(device).then((value) => {
            setState(() {
              _devices[index].isSelected = true;
              Constants.lstDevices = _devices;
            }),
          }),
        }else{
          bluetooth.disconnect().then((value) => {
            if(value){
              setState(() {
                for(int i = 0 ; i < _devices.length ; i ++){
                  _devices[i].isSelected = false;
                }
                Constants.lstDevices = [];
              }),
            }
          }),
        }

      });

    }on PlatformException{

    }

    // bluetooth.connect(device).catchError((error) {
    //   Utils.errorDialog(context,"Already connected");
    //   return;
    // });


  }

  void getDevices() async {
    List<BluetoothDevice> devices = [];
    List<ListItem<BluetoothDevice>> lst = [];
    var isOn = await bluetooth.isOn;
    if (!isOn!) {
      Constants.lstDevices = [];
      Utils.confirmDialog(context, "Confirm", "Please open bluetooth!")
          .then((value) => {
        if (value)
          {
            bluetooth.openSettings,
          }
      });
    }
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    if (!mounted) return;
    for (int i = 0; i < devices.length; i++) {
      lst.add(ListItem<BluetoothDevice>(devices[i]));
    }
    setState(() {
      if(Constants.lstDevices.length > 0 ){
        _devices = Constants.lstDevices;
      }else{
        _devices = lst;
      }
    });
  }

  Future<void> _refresh() async {
    getDevices();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
