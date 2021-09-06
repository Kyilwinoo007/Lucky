import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/Repository/UserViewModel.dart';
import 'package:lucky/UI/User/CreateUser.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {

  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserViewModel model = serviceLocator<UserViewModel>();
  late UserInfo userInfo;
  late List<UserData> userInfoList;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: luckyAppbar(
        context: context,
        title: "Users",
      ),
      body: StreamBuilder(
          stream: model.getAllUser(context),
          builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
             userInfoList = snapshot.data ?? [];
            return buildBody(userInfoList);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:FloatingActionButton(

        child: Icon(
          Icons.add,
          size: 25,
        ),
        backgroundColor: LuckyColors.splashScreenColors,
        onPressed: () {
          if (this.userInfoList.length < Constants.maxUser) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateUser(null)));
          } else {
            Utils.confirmDialog(
                context, "Sorry!", "Cannot create more than two users.");
          }
        },
      ),
    );
  }

  Widget buildBody(List<UserData> userDataList) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return userDataList.length > 0
        ? (orientation == Orientation.landscape
            ? buildLandscapeLayout(
                userDataList,
              )
            : buildPortraitLayout(
                userDataList,
              ))
        : Utils.buildEmptyView(
            context: context,
            icon: LineAwesomeIcons.crying_face,
            title: "Empty User");
  }

  buildLandscapeLayout(List<UserData> userInfoList) {
    return ListView.builder(
      itemCount: userInfoList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: UserScreenItem(user: userInfoList[index], model: model),
      ),
    );
  }

  buildPortraitLayout(List<UserData> userInfoList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: userInfoList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: UserScreenItem(user: userInfoList[index], model: model),
        ),
      ),
    );
  }

  void getUserInfo() async {
    UserInfo userInfo = await basicInfo.getUserInfo();
    if (userInfo != null) {
      setState(() {
        this.userInfo = userInfo;
      });
    }
  }
}

class UserScreenItem extends StatefulWidget {
  final UserData user;
  final UserViewModel model;

  const UserScreenItem({Key? key, required this.user, required this.model})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserScreenItemState();
}

class _UserScreenItemState extends State<UserScreenItem> {
  var isDeactivate;

  @override
  void initState() {
    isDeactivate = this.widget.user.isDeactivate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, left: 12, bottom: 4, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Name : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            this.widget.user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  InkWell(
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => CreateUser(this.widget.user)));
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                    // InkWell(
                    //   onTap: () {
                    //     Utils.confirmDialog(context, "Confirm",
                    //             "Are you sure you want to delete!")
                    //         .then((value) {
                    //       if (value) {
                    //          Utils.showLoaderDialog(context);
                    //         deleteUser(this.widget.user);
                    //         Utils.dismissDialog(context);
                    //         //updateUserInfo();
                    //       }
                    //     });
                    //   },
                    //   child: Icon(
                    //     Icons.delete,
                    //     color: Colors.red,
                    //     size: 25.0,
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, left: 12, bottom: 4, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      this.widget.user.email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, left: 12, bottom: 4, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Phone : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      this.widget.user.phone,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, left: 12, bottom: 4, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child:  Text(
                              "Deactivate",
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                      ),
                    ),
                    FlutterSwitch(
                      activeColor: Color.fromRGBO(51, 226, 255, 1),
                      inactiveColor: Colors.black38,
                      height: 25,
                      width: 50,
                      showOnOff: false,
                      onToggle: (value) {
                        setState(() {
                          isDeactivate = value;
                          deactivateUser(this.widget.user);
                        });
                      },
                      value: isDeactivate,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteUser(UserData user) {
    this.widget.model.deleteUsers(context,user);
  }

  void deactivateUser(UserData user) {
    this.widget.model.deactivateUser(context,user,isDeactivate);
  }
}
