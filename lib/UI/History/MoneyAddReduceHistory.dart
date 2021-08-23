import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Repository/TransactionViewModel.dart';
import 'package:lucky/UI/Transactions/TransactionItem.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class MoneyAddReduceHistory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MoneyAddReduceHistoryState();

}

class MoneyAddReduceHistoryState extends State<MoneyAddReduceHistory> {
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: model.getAllMoneyInputRecords(context),
          builder: (context, AsyncSnapshot<List<BalanceInputRecord>> snapshot) {
            final inputRecords = snapshot.data ?? [];
            return buildBody(inputRecords);
          }),
    );
  }
  Widget buildBody(List<BalanceInputRecord> inputRecords) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return inputRecords.length > 0
        ? (orientation == Orientation.landscape
        ? buildLandscapeLayout(
      inputRecords,
    )
        : buildPortraitLayout(
      inputRecords,
    ))
        : Utils.buildEmptyView(
        context: context,
        icon: LineAwesomeIcons.crying_face,
        title: "Empty History");
  }

  buildLandscapeLayout(List<BalanceInputRecord> inputRecords) {
    return ListView.builder(
      itemCount: inputRecords.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => DepositeDetail(openingClosingList[index])));
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
                  deleteTransaction(inputRecords[index]),
                },
              ),
            ],
            child: InputRecordItem(
              transaction: inputRecords[index],
            ),
          ),
        ),
      ),
    );
  }

  buildPortraitLayout(List<BalanceInputRecord> inputRecords) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: inputRecords.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
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
                  deleteTransaction(inputRecords[index]),
                },
              ),
            ],
            child: InputRecordItem(
              transaction: inputRecords[index],
            ),
          ),
        ),
      ),
    );
  }

  deleteTransaction(BalanceInputRecord balanceInputRecord) async{
    BalanceInputRecordsDao dao = Provider.of<BalanceInputRecordsDao>(context,listen: false);
    Utils.confirmDialog(
        context, "Confirm", "Are you sure want to delete.")
        .then((value) {
      if (value) {
        dao.deleteBalanceInputRecord(balanceInputRecord);
      }
    });
  }
}

class InputRecordItem extends StatelessWidget {
  final BalanceInputRecord transaction;

  const InputRecordItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
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
          leading:transaction.inputType == Constants.MoneyInputAdd ? CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.green,
              size: 40.0,
            ),
          ):
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              LineAwesomeIcons.minus_circle,
              color: Colors.red,
              size: 40.0,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children :[
              Padding(
                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text(
                  "Cash : " +
                      this.transaction.cash.toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              Text("E-Money : " +
                  this.transaction.eMoney.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                    fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(height: 8.0,)
            ]
          ),
          subtitle: transaction.reason != null ? Text(
            '${transaction.reason}',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ): SizedBox.shrink(),
          trailing: Column(
            children :[
              Padding(
                padding: EdgeInsets.only(top: 6.0,bottom: 8.0),
                child: Text('${transaction.agent}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800
                ),),
              ),
              Text(
                '${transaction.date}',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}