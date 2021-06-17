import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/WithdrawViewModel.dart';
import 'package:lucky/UI/Transactions/TransactionItem.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';

class WithDrawRecord extends StatefulWidget{
  @override
  _WithdrawRecordState createState() => _WithdrawRecordState();
}

class _WithdrawRecordState extends State<WithDrawRecord> {
  final WithdrawViewModel model = serviceLocator<WithdrawViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: luckyAppbar(
          context: context,
          title: "Withdraw",
        ),
      body: StreamBuilder(
          stream: model.getTransactionByType(context, Constants.WITHDRAW_TYPE),
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            // if (!snapshot.hasData) return Utils.buildLoading();
            final transactionList = snapshot.data ?? [];
            return buildBody(transactionList);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 25,),
        backgroundColor: LuckyColors.splashScreenColors,
        onPressed: () {
          print("pressed");
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
        : buildTransferRecord(
      transactionList,
    ))
        : Utils.buildEmptyView(
        context: context,
        icon: LineAwesomeIcons.money_bill,
        title: "Empty Withdraw List");
  }

  buildLandscapeLayout(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/withdraw-create", arguments: {
            "transactionEntity": transactionList[index],
          });
        },
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
              // IconSlideAction(
              //   caption: 'Edit',
              //   color: Colors.indigo,
              //   icon: Icons.edit,
              //   onTap: () => {
              //     Navigator.of(context)
              //         .pushNamed("/withdraw-create", arguments: {
              //       "transactionEntity": transactionList[index],
              //     })
              //   },
              // ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  print("delete")
                },
              ),
            ],
            child: TransactionItem(
              transaction: transactionList[index],
            ),
          ),
        ),
      ),
    );

  }

  buildTransferRecord(List<Transaction> transactionList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
           //todo to route detail
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
              // IconSlideAction(
              //   caption: 'Edit',
              //   color: Colors.indigo,
              //   icon: Icons.edit,
              //   onTap: () => {
              //     Navigator.of(context)
              //         .pushNamed("/withdraw-create", arguments: {
              //       "transactionEntity": transactionList[index],
              //     })
              //   },
              // ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                 print("delete")
                },
              ),
            ],
            child: TransactionItem(
              transaction: transactionList[index],
            ),
          ),
        ),
      ),
    );

  }
}