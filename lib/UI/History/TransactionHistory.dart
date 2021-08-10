import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Bill/BillDetail.dart';
import 'package:lucky/UI/Bill/BillItem.dart';
import 'package:lucky/UI/Deposite/DepositeDetail.dart';
import 'package:lucky/UI/Deposite/DepositeRecord.dart';
import 'package:lucky/UI/Transactions/BankTransactionDetail.dart';
import 'package:lucky/UI/Transactions/TransactionDetail.dart';
import 'package:lucky/UI/Transactions/TransactionItem.dart';
import 'package:lucky/UI/Transactions/bankTransactionItem.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';

class TransactionHistory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TransactionHistoryState();

}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: model.getAllTransaction(context),
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            // if (!snapshot.hasData) return Utils.buildLoading();
            final transactionList = snapshot.data ?? [];
            return buildBody(transactionList);
          }),
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
        title: "Empty History");
  }

  buildLandscapeLayout(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          if(transactionList[index].transactionsType == Constants.DEPOSITE_TYPE){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DepositeDetail(transactionList[index])));
          }else if(transactionList[index].transactionsType == Constants.WITHDRAW_TYPE ||
              transactionList[index].transactionsType == Constants.TRANSFER_TYPE){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TransactionDetail(transactionList[index])));
          }else if(transactionList[index].transactionsType == Constants.BILL_TOP_UP){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BillDetail(transactionList[index])));
          }else{
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BankTransactionDetail(transactionList[index].transferrorType,transactionList[index])));
          }
          },
        child: Container(
          width: 20,
          child: items(
          transaction: transactionList[index],
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
            if(transactionList[index].transactionsType == Constants.DEPOSITE_TYPE){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DepositeDetail(transactionList[index])));
            }else if(transactionList[index].transactionsType == Constants.WITHDRAW_TYPE ||
                transactionList[index].transactionsType == Constants.TRANSFER_TYPE){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TransactionDetail(transactionList[index])));
            }else if(transactionList[index].transactionsType == Constants.BILL_TOP_UP){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BillDetail(transactionList[index])));
            }else{
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BankTransactionDetail(transactionList[index].transferrorType,transactionList[index])));
            }
            },
          child: items(
            transaction: transactionList[index],
          ),
        ),
      ),
    );

  }

  items({required Transaction transaction}) {
    if(transaction.transactionsType == Constants.DEPOSITE_TYPE){
      return DepositeItem(transaction: transaction);
    }else if (transaction.transactionsType == Constants.TRANSFER_TYPE ||
          transaction.transactionsType == Constants.WITHDRAW_TYPE){
      return TransactionItem(transaction: transaction);
    }else if(transaction.transactionsType == Constants.BILL_TOP_UP){
      return BillItem(transaction: transaction,);


    }else{
      return BankTransactionItem(transferorType: transaction.transferrorType,transaction: transaction,);

    }
  }

  deleteTransaction(Transaction transaction) {
    model.deleteTransaction(context, transaction);
  }
}