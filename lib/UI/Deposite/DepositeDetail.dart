import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class DepositeDetail extends StatefulWidget{
  Transaction transaction;
  DepositeDetail(this.transaction);

  @override
  State<StatefulWidget> createState() => _DepositeDetailState();

}

class _DepositeDetailState extends State<DepositeDetail> {
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
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Name : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Phone No. : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Text(this.widget.transaction.fromPhone,
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
            Card(
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Amount : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Commission : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
            Card(
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Agent : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
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
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Date : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
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
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }

  buildLandscapeView() {
    return ListView(
        children :[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Name : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child: Text(this.widget.transaction.fromCustomerName.isEmpty ? "Unknown" : this.widget.transaction.fromCustomerName,
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
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Phone No. : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child: Text(this.widget.transaction.fromPhone,
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
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Amount : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Commission : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Agent : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Date : " , style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
    );
  }
}