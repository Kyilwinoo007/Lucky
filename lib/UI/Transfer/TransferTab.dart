import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/UI/Transfer/BankTransfer/BankTransferRecord.dart';
import 'package:lucky/UI/Transfer/Partner/PartnerTransferRecord.dart';
import 'package:lucky/UI/Transfer/TransferRecord.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';

class TransferTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    _TransferTabState _transferTabState = _TransferTabState();
    return _transferTabState;
  }
}

class _TransferTabState extends State<TransferTab> with SingleTickerProviderStateMixin{
  var controller;
  @override
  void initState() {
    super.initState();
    controller =  TabController(length: 3 ,vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: luckyAppbar(
            bottomWidget: TabBar(
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              controller: controller,
              tabs: [
                Tab(icon: Icon(LineAwesomeIcons.alternate_exchange),text: "Transfer",),
                Tab(icon: Icon(Icons.account_balance),text: "Bank",),
                Tab(icon: Icon(LineAwesomeIcons.user_friends),text: "Partner",),
              ],
            ),
            title:"Transfer", context: context,
          ),
          body: TabBarView(
            controller: controller,
            children: [
                TransferRecord(),
                BankTransferRecord(transferorType: Constants.BankType,),
                PartnerTransferRecord(),
            ],
          ),
        ),
    );
  }
}
