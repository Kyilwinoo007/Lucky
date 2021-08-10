import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Transactions/BankTransactionDetail.dart';
import 'package:lucky/UI/Transactions/TransactionItem.dart';
import 'package:lucky/UI/Transactions/bankTransactionItem.dart';
import 'package:lucky/UI/Transfer/BankTransfer/CreateBankTransfer.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';

class BankTransferRecord extends StatefulWidget{
 final String transferorType;
  const BankTransferRecord({
    Key? key,
    required  this.transferorType,
  }) : super(key: key);


  @override
  _BankTransferRecordState createState() => _BankTransferRecordState();

}

class _BankTransferRecordState extends State<BankTransferRecord> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: luckyAppbar(
      //   context: context,
      //   title: "Transfer",
      // ),
      body: StreamBuilder(
          stream: model.getBankTransactionByTransferorType(context,this.widget.transferorType),
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
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateBankTransfer(transferorType : this.widget.transferorType,typeList: this.widget.transferorType == Constants.BankType ? Constants.bankTransferTypeList : Constants.partnerTransferTypeList)));
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
        icon: LineAwesomeIcons.crying_face,
        title: "Empty Transfer List");
  }

  buildLandscapeLayout(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => BankTransactionDetail(this.widget.transferorType ,transactionList[index])));
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

              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  deleteTransaction(transactionList[index]),
                },
              ),
            ],
            child: BankTransactionItem(
              transferorType : this.widget.transferorType,
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
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BankTransactionDetail(this.widget.transferorType ,transactionList[index])));          },
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
            child: BankTransactionItem(
              transferorType: this.widget.transferorType,
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
         model.deleteTransaction(context ,transaction);
      }
    });
  }
}