library splashscreen;

import 'dart:core';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class CustomSplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final dynamic navigateAfterSeconds;
  final Text loadingText;

  CustomSplashScreen({
    required this.seconds,
    this.navigateAfterSeconds,
    this.title = const Text(''),
    this.backgroundColor = Colors.white,
    required this.loadingText,
  });


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: widget.seconds),
    ()
    {
      if (widget.navigateAfterSeconds is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateAfterSeconds));
      }else {
    throw new ArgumentError(
    'widget.navigateAfterSeconds must either be a String or Widget'
    );
    }
  }

  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: new InkWell(
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: widget.backgroundColor,
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex:3,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children :<Widget>[
                    SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontFamily: "Horizon"
                       ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          // WavyAnimatedText('Lucky'),
                          RotateAnimatedText('Lucky',
                          duration: Duration(milliseconds: 3000),
                          textStyle: TextStyle(
                            fontSize: 60.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          )),
                          RotateAnimatedText('Be Your Friend',
                          duration: Duration(milliseconds: 3000),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40.0
                          )),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ),
                  ]
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}}
