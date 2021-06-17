import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget{
  final String text;
  final VoidCallback? onTap;
  final Icon icon;

  ButtonWidgets({
    required this.icon,
    this.onTap,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.1),
          child: IconButton(
            padding: EdgeInsets.all(15.0),
            icon: icon,
            color: Colors.black,
            iconSize: 30.0,
            onPressed: this.onTap,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          this.text,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }

}