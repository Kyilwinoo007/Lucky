import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class HomeScreenTopWidget extends StatelessWidget{
  final double cash;
  final double eMoney;
  const HomeScreenTopWidget({
    Key? key,
    required this.cash,
    required this.eMoney,
}):super(key: key);
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

    return Padding(
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? EdgeInsets.only(
        top: 60,
        bottom: 20,
        right: 15.0,
        left: 15.0,
      )
          : EdgeInsets.only(bottom: 10,top: 5 ,right: 32,left: 32),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 20.0
                    : 10.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 15.0)
            ]),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? buildPortraitView()
            : buildLandscapeView(),
      ),
    );
  }

  buildPortraitView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Cash",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 12),
                ),
                Text(
                  this.cash.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "E-money",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 12),
                ),
                Text(
                  this.eMoney.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildLandscapeView() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Cash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    padding: EdgeInsets.only(right: 32),
                  ),
                  Text(
                    this.cash.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "E-money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    padding: EdgeInsets.only(right: 32),
                  ),
                  Text(
                    this.eMoney.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}