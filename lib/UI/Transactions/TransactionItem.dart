
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({Key? key, required this.transaction}) : super(key: key);

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
    bool isWithDraw = true;
    return Card(
      elevation: 5,
      child: Container(
//        height: 80.sp,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isWithDraw ? Colors.red[50] : Colors.green[50],
//          child: Image.asset("images/kbzpay.png",fit: BoxFit.cover,)
            child: Icon(
              isWithDraw ? Icons.arrow_back : Icons.arrow_forward,
              color: isWithDraw ? Colors.red : Colors.green,
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
              color: isWithDraw ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                (isWithDraw ? "-" : "+") + " \$${this.transaction.amount}",
                style: TextStyle(
                  fontSize: 15.0,
                  color: isWithDraw ? Colors.red : Colors.green,
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
