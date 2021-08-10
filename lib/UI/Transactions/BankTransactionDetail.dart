import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class BankTransactionDetail extends StatefulWidget{
  String transferorType;
  Transaction transaction;
  BankTransactionDetail(this.transferorType, this.transaction);

  @override
  State<StatefulWidget> createState() => _BankTransactionDetailState();

}

class _BankTransactionDetailState extends State<BankTransactionDetail> {
  var isTransfer,isBank;
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
    if(this.widget.transferorType == Constants.BankType){
      isBank = true;
      isTransfer = this.widget.transaction.transactionsType == Constants.BANK_TRANSFER_TYPE;
    }else if(this.widget.transferorType == Constants.PartnerType){
      isBank = false;
      isTransfer = this.widget.transaction.transactionsType == Constants.PARTNER_TRANSFER_TYPE;
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
        height: MediaQuery.of(context).size.height * 0.75,
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
                      child: isBank ?  Row(
                        children: <Widget>[
                          Text("Bank Name : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Text(this.widget.transaction.bank.isEmpty ? "Unknown" : this.widget.transaction.bank,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          )
                        ],
                      ) :
                      Row(
                        children: <Widget>[
                          Text("Partner Name : " , style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Text(this.widget.transaction.partner.isEmpty ? "Unknown" : this.widget.transaction.partner,
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
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Type : " , style: TextStyle(
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
                              child: Text(this.widget.transaction.transactionsType,
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
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                child: Column(
                  children :[
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
                              padding: EdgeInsets.all(10),
                              child: Text(this.widget.transaction.phone.isEmpty ? "-": this.widget.transaction.phone ,
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
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Charges : " , style: TextStyle(
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
                      child: isBank ?  Row(
                        children: <Widget>[
                          Text("Bank Name : " , style: TextStyle(
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
                              child: Text(this.widget.transaction.bank.isEmpty ? "Unknown" : this.widget.transaction.bank,
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
                          Text("Partner Name : " , style: TextStyle(
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
                              child: Text(this.widget.transaction.partner.isEmpty ? "Unknown" : this.widget.transaction.partner,
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
                          Text("Type : " , style: TextStyle(
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
                              child: Text(this.widget.transaction.transactionsType,
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
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                child: Column(
                  children :[
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
                              padding: EdgeInsets.all(10),
                              child: Text(this.widget.transaction.phone.isEmpty ? "-": this.widget.transaction.phone ,
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
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Charges : " , style: TextStyle(
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

          ],
        ),
      ),
    ]
    );
  }
}