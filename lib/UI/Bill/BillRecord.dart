import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/Result.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Bill/CreateBill.dart';
import 'package:lucky/UI/Widgets/CustomFloatingButton.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/UI/Widgets/LuckyFloatingActionButton.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

import 'BillDetail.dart';
import 'BillItem.dart';

class BillRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BillRecordState();

}

class _BillRecordState extends State<BillRecord> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  List<Transaction> transactionList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: luckyAppbar(
        context: context,
        title: "Bill Top Up",
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    showSearch(context: context, delegate: DataSearch(transactionList));
                  });
                },
                icon: Icon(
                  Icons.search,
                  size: 25.0,
                  color: Colors.white,
                )),
          ]

      ),
      body: StreamBuilder(
          stream: model.getTransactionByType(context, Constants.BILL_TOP_UP),
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            // if (!snapshot.hasData) return Utils.buildLoading();
            transactionList = snapshot.data ?? [];
            return buildBody(transactionList);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LuckyFloatingActionButton(
        onTap: () async{
          var result = await  Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateBill()));
        }
      ),
    );

  }

  Widget buildBody(List<Transaction> transactionList) {
    final Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    return transactionList.length > 0
        ? (orientation == Orientation.landscape
        ? buildLandscapeLayout(
      transactionList,
    )
        : buildPortraitLayout(
      transactionList,
    ))
        : Utils.buildEmptyView(
        context: context,
        icon: LineAwesomeIcons.crying_face,
        title: "Empty Bill Top Up");
  }

  buildLandscapeLayout(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => BillDetail(transactionList[index])));        },
        child: Container(
          width: 20,
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Print',
                color: Colors.green,
                icon: Icons.print,
                onTap: () => {},
              ),
            ],
            secondaryActions: <Widget>[

              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(transactionList[index]),
                },
              ),
            ],
            child: BillItem(
              transaction: transactionList[index],
            ),
          ),
        ),
      ),
    );

  }

  buildPortraitLayout(List<Transaction> transactionList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BillDetail(transactionList[index])));
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Print',
                color: Colors.green,
                icon: Icons.print,
                onTap: () => {},
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(transactionList[index]),
                },
              ),
            ],
            child: BillItem(
              transaction: transactionList[index],
            ),
          ),
        ),
      ),
    );

  }

  deleteTransaction(Transaction transactionList) {
    Utils.confirmDialog(
        context, "Confirm", "Are you sure want to delete.")
        .then((value) {
      if (value) {
        model.deleteTransaction(context, transactionList);
      }
    });
  }
}
class DataSearch extends SearchDelegate<String> {

  final List<Transaction> transactionList;

  DataSearch(this.transactionList);

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     primaryColor: LuckyColors.splashScreenColors,
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = query.isEmpty
        ? transactionList
        : transactionList.where((p) => p.fromCustomerName.startsWith(RegExp(query, caseSensitive: false))).toList();

    if(suggestionList.length > 0 ) {
      return ListView.builder(itemBuilder: (context, index) =>
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BillDetail(suggestionList[index])));
            },
            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 18.0,),
            title: Text(
              suggestionList[index].fromCustomerName, style: TextStyle(
                fontSize: 15.0
            ),),
          ),
        itemCount: suggestionList.length,
      );
    }else{
      return Center(
        child: Text("No result found!"),
      );
    }

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? transactionList
        : transactionList.where((p) => p.fromCustomerName.startsWith(RegExp(query, caseSensitive: false))).toList();


    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => BillDetail(suggestionList[index])));


      },
      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 18.0,),
      title: RichText(
        text: TextSpan(
            text: suggestionList[index].fromCustomerName.substring(0, query.length),
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].fromCustomerName.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
}

