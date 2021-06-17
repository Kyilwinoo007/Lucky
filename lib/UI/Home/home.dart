import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Repository/AgentViewModel.dart';
import 'package:lucky/Repository/HomeViewModel.dart';
import 'package:lucky/UI/Agent/Agent.dart';
import 'package:lucky/UI/Widgets/ButtonWidgets.dart';
import 'package:lucky/UI/Widgets/HomeScreenTopWidget.dart';
import 'package:lucky/UI/Withdraw/WithDrawRecord.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();

}

// ignore: camel_case_types
class _HomeState extends State<Home> {
  final HomeViewModel model = serviceLocator<HomeViewModel>();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  void initState() {
    super.initState();
    model.getAllBalance(context);
  }

  @override
  Widget build(BuildContext context) {
    // var topSection = HomeScreenTopWidget(
    //   cash: 0.0,
    //   eMoney: 0.0,
    // );
    var depositWidget = ButtonWidgets(
      icon: Icon(Icons.account_balance),
      onTap: () {
        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
        print("deposite");
      },
      text: "Deposite",
    );
    var withdrawWidget = ButtonWidgets(
      icon: Icon(Icons.credit_card),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WithDrawRecord()));
      },
      text: "Withdraw",
    );
    var transferWidget = ButtonWidgets(
      icon: Icon(Icons.send),
      onTap: () {
        print("Transfer");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Transfer",
    );
    var bankTransferWidget = ButtonWidgets(
      icon: Icon(Icons.account_balance),
      onTap: () {
        print("Transfer");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Bank",
    );
    var billTopUpWidget = ButtonWidgets(
      icon: Icon(Icons.villa),
      onTap: () {
        print("Transfer");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Bill",
    );
    var analyticsWidget = ButtonWidgets(
      icon: Icon(Icons.insert_chart),
      onTap: () {
        print("Analytic");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Analytics",
    );
    var historyWidget = ButtonWidgets(
      icon: Icon(Icons.history),
      onTap: () {
        print("History");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "History",
    );
    var usersWidget = ButtonWidgets(
      icon: Icon(Icons.people),
      onTap: () {
        print("Users");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Users",
    );
    var profileWidget = ButtonWidgets(
      icon: Icon(Icons.account_circle_sharp),
      onTap: () {
        print("profile");

        // Navigator.of(context).pushNamed("/transactions", arguments: {
        //   "type": "Text",
        // });
      },
      text: "Profile",
    );
    var agentWidget = ButtonWidgets(
      icon: Icon(Icons.real_estate_agent),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Agent()));
      },
      text: "Agent",
    );

    return ChangeNotifierProvider<HomeViewModel>(
      create: (context)=> model,
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body:  SmartRefresher(
        onRefresh: _refresh,
        controller: _refreshController,
        child: Column(
          children: [
            Center(
              child: buildPortraitView(
                    Consumer<HomeViewModel>(builder: (context, model, child) {
                      return HomeScreenTopWidget(
                        cash: model.totalCash,
                        eMoney: model.totalEmoney,
                      );
                    },
                    ),
                    depositWidget,
                    withdrawWidget,
                    transferWidget,
                    // bankTransferWidget,
                    billTopUpWidget,
                    agentWidget,
                    analyticsWidget,
                    historyWidget,
                    usersWidget,
                    profileWidget),
              )
            ],
          ),
      ),
      ),
    );
  }
  buildPortraitView(
      Widget topSection,
      Widget depositWidget,
      Widget withdrawWidget,
      Widget transferWidget,
      Widget bankTransferWidget,
      Widget billTopUpWidget,
      Widget analyticsWidget,
      Widget historyWidget,
      Widget usersWidget,
      Widget profileWidget,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        topSection,
        Container(
          padding: EdgeInsets.all(14.0),
          width: double.infinity,
          child: Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      depositWidget,
                      withdrawWidget,
                      transferWidget,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      bankTransferWidget,
                      billTopUpWidget,
                      analyticsWidget,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40,
                  ).copyWith(
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      historyWidget,
                      usersWidget,
                      profileWidget,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _refresh() async{
    model.getAllBalance(context);
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}