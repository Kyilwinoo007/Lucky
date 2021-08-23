import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Utils/Colors.dart';

class LuckyFloatingActionButton extends StatelessWidget{
  final VoidCallback onTap;
  LuckyFloatingActionButton(
  {required this.onTap});
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: FloatingActionButton(
        backgroundColor: LuckyColors.splashScreenColors,
        onPressed: this.onTap,
        child: Icon(Icons.add_sharp,size: 30,color: Colors.white,),
      ),
    );

  }

}