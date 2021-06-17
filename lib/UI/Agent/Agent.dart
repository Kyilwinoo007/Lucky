import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Repository/AgentViewModel.dart';
import 'package:lucky/UI/Agent/AgentItem.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Agent extends StatefulWidget{
  @override
  _AgentState createState() => _AgentState();

}

class _AgentState extends State<Agent> {

  @override
  Widget build(BuildContext context) {

      return Scaffold(
          appBar: luckyAppbar(
            title: "Agent",
            context: context,
          ),
          body:  ListView.builder(
              itemBuilder: (context, index) => AgentItem(
                name: Constants.agentList[index],
                type: Constants.agentIdList[index],
                  index: index,
              ),
              itemCount: Constants.agentList.length,
            ),
    );
  }
}


