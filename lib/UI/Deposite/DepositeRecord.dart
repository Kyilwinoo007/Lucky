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
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class DepositeRecord extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DepositeRecordState();

}

class _DepositeRecordState extends State<DepositeRecord>{
  final TransactionViewModel model = serviceLocator<TransactionViewModel>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: luckyAppbar(
        context: context,
        title: "Deposite",
      ),
      body: StreamBuilder(
          stream: model.getTransactionByType(context, Constants.DEPOSITE_TYPE),
          builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
            // if (!snapshot.hasData) return Utils.buildLoading();
            final transactionList = snapshot.data ?? [];
            return buildBody(transactionList);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 25,),
        backgroundColor: LuckyColors.splashScreenColors,
        onPressed: () async{
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
        title: "Empty Deposite List");
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