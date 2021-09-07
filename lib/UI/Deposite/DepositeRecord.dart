import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Deposite/CreateDeposite.dart';
import 'package:lucky/UI/Deposite/DepositeDetail.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/UI/Widgets/LuckyFloatingActionButton.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class DepositeRecord extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DepositeRecordState();

}

class _DepositeRecordState extends State<DepositeRecord>{
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
          title: "Deposite",
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
            stream: model.getTransactionByType(context, Constants.DEPOSITE_TYPE),
            builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
              transactionList = snapshot.data ?? [];
              return buildBody(transactionList);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: LuckyFloatingActionButton(
          onTap: () async{
            var result = await  Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreateDeposite()));
          },
        ),
    );

  }

  buildBody(List<Transaction> transactionList) {
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
        title: "Empty Deposite");
  }

  buildLandscapeLayout(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => DepositeDetail(transactionList[index])));        },
        child: Container(
          width: 20,
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(transactionList[index]),
                },
              ),
            ],
            child: DepositeItem(
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
                builder: (context) => DepositeDetail(transactionList[index])));
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(transactionList[index]),
                },
              ),
            ],
            child: DepositeItem(
              transaction: transactionList[index],
            ),
          ),
        ),
      ),
    );

  }
  deleteTransaction(Transaction transaction) {
    Utils.confirmDialog(
        context, "Confirm", "Are you sure want to delete.")
        .then((value) {
      if (value) {
        model.deleteTransaction(context, transaction);
      }
    });
  }
}

class DepositeItem extends StatelessWidget {
  final Transaction transaction;

  const DepositeItem({Key? key, required this.transaction}) : super(key: key);

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
    return Card(
      elevation: 5,
      child: Container(
//        height: 80.sp,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green[50],
            child: Icon(
              Icons.arrow_forward,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          title: Text(
            this.transaction.fromCustomerName.isEmpty
                ? "Unknown"
                : this.transaction.fromCustomerName,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          subtitle: Text(
            '${transaction.date}',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "+" + " \$${this.transaction.amount}",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                  builder: (context) => DepositeDetail(suggestionList[index])));
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
            builder: (context) => DepositeDetail(suggestionList[index])));

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