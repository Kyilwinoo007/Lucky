import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class BankTransactionItem extends StatelessWidget {
  final Transaction transaction;
  final String transferorType;

  const BankTransactionItem({Key? key, required this.transaction, required this.transferorType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool isTransfer ,isBank;
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
    if(transferorType == Constants.BankType){
      isBank = true;
      isTransfer = transaction.transactionsType == Constants.BANK_TRANSFER_TYPE;
    }else if(transferorType == Constants.PartnerType){
      isBank = false;
      isTransfer = transaction.transactionsType == Constants.PARTNER_TRANSFER_TYPE;
    }
    return Card(
      elevation: 5,
      child: Container(
//        height: 80.sp,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isTransfer ? Colors.red[50] : Colors.green[50],
            child: Icon(
              isTransfer ? Icons.arrow_back : Icons.arrow_forward,
              color: isTransfer ? Colors.red : Colors.green,
              size: 30.0,
            ),
          ),
          title: transaction.transferrorType == Constants.BankType ? Text(
            this.transaction.bank.isEmpty
                ? "Unknown"
                : this.transaction.bank,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ) : Text(
            this.transaction.partner.isEmpty
                ? "Unknown"
                : this.transaction.partner,
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
              color: isTransfer ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                (isTransfer ? "-" : "+") + " \$${this.transaction.amount}",
                style: TextStyle(
                  fontSize: 15.0,
                  color: isTransfer ? Colors.red : Colors.green,
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
