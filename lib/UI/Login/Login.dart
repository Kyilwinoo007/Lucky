import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/Repository/LoginViewModel.dart';
import 'package:lucky/UI/Home/home.dart';
import 'package:lucky/UI/Widgets/CustomButton.dart';
import 'package:lucky/UI/Widgets/CustomClipper.dart';
import 'package:lucky/UI/Widgets/CustomTextInput.dart';
import 'package:lucky/UI/Widgets/Wrapper.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailOrPhoneController;
  late TextEditingController _userPasswordController;
  late Wrapper _emailOrPhoneErrMessage;
  late Wrapper _userPasswordErrMessage;
  String email = '';
  String phone = '';
  late UserInfo userInfo;
  late List<String> userIdList;
  final LoginViewModel model = serviceLocator<LoginViewModel>();


  @override
  void initState() {
    _emailOrPhoneController = TextEditingController();
    _userPasswordController = TextEditingController();
    _emailOrPhoneErrMessage = new Wrapper("");
    _userPasswordErrMessage = new Wrapper("");
    super.initState();
  }

  Stack _clipper({required double height ,required double width}){
    return Stack(
      children: [
        ClipPath(
          clipper: CurveClipper(),
          child: Container(
            height: height,
            width: width,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
  hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }


  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
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
    Widget passwordInput = CustomPasswordInput(
      errorMessage: this._userPasswordErrMessage.value,
      userPasswordController: this._userPasswordController,
      label: "Password",
      hintText: "Enter Password",
    );
    Widget userNameInput = CustomTextInput(
      errorMessage: this._emailOrPhoneErrMessage.value,
      isRequired: true,
      label: "Email / Phone",
      controller: this._emailOrPhoneController,
      hintText: "Enter email / phone",
      leadingIcon: Icon(        LineAwesomeIcons.user,
        size: 25.0,
        color: LuckyColors.splashScreenColors,
      ),
    );
    Widget firstSentence = Text(
      "Hello There\nWelcome Back".toUpperCase(),
      style: TextStyle(
        fontSize: 29.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
    Widget secondSentences = Text(
      "Sign In to continue.",
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
    );
        Widget submitButton = SolidGreenButton(
      title: "Login",
      clickHandler: () {
        if(isValid()) {
          Utils.checkInternetConnection(context).then((value) =>
          {
            if(!value){
              ScaffoldMessenger.of(context).showSnackBar(Utils.showSnackBar()),
            } else
              {
                Utils.showLoaderDialog(context),
                getUserFromFireStore(),
                Utils.hideKeyboard(context),
              }
          });
        }

      },
    );
    return SafeArea(
        child: Scaffold(
          body: orientation == Orientation.landscape
              ? buildLandscapeLayout(
            passwordInput: passwordInput,
            userNameInput: userNameInput,
            firstSentence: firstSentence,
            secondSentence: secondSentences,
            submitButton: submitButton,
          )
              : buildPortraitLayout(
            passwordInput: passwordInput,
            userNameInput: userNameInput,
            firstSentence: firstSentence,
            secondSentence: secondSentences,
            submitButton: submitButton,
          ),
        ),
     // ),
    );
  }

  Widget buildPortraitLayout({
    @required passwordInput,
    @required userNameInput,
    @required firstSentence,
    @required submitButton, required Widget secondSentence,
  }) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          _clipper(height: size.height /2.7, width: double.infinity),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child:userNameInput,),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child:passwordInput,),
          SizedBox(height: 18,),
           Row(
             children: [
               Expanded(child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child: submitButton,
               ),)

             ],
           ),
        ],
      ),
    );
  }

  Widget buildLandscapeLayout({
    required Widget passwordInput,
    required Widget userNameInput,
    required Widget firstSentence,
    required Widget submitButton, required Widget secondSentence,
  }) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          _clipper(height: size.height /2.7, width: double.infinity),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child:userNameInput,),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child:passwordInput,),
          SizedBox(height: 18,),
          Row(
            children: [
              Expanded(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: submitButton,
              ),)

            ],
          )


        ],
      ),
    );
  }

  bool isValid() {
    bool isPasswordValid,isEmailOrPhoneValid = false;
    String pwdErrMsg ="" ,emailOrPhoneErrMsg = "";
    if(_emailOrPhoneController.text.trim().isEmpty){
      isEmailOrPhoneValid = false;
      emailOrPhoneErrMsg = "Required";
    }else{
      if(EmailValidator.validate(_emailOrPhoneController.text)){
        isEmailOrPhoneValid = true;
        email = _emailOrPhoneController.text;

      }else if(Utils.validatePhone(_emailOrPhoneController.text)){
        isEmailOrPhoneValid = true;
        phone = _emailOrPhoneController.text;
      }else {
        isEmailOrPhoneValid = false;
        emailOrPhoneErrMsg  = "Please,enter valid email or phone";
      }
    }
    if(_userPasswordController.text.trim().isEmpty){
      isPasswordValid = false;
      pwdErrMsg = "Required";
    }else{
      isPasswordValid = true;
    }
    setState(() {
      _emailOrPhoneErrMessage.value = emailOrPhoneErrMsg;
      _userPasswordErrMessage.value = pwdErrMsg;

    });

    return isPasswordValid && isEmailOrPhoneValid;
  }

  void getUserFromFireStore() async{
    late QuerySnapshot querySnapshot;

    if(phone.isNotEmpty){
      querySnapshot = await FirebaseFirestore.instance
          .collection(Constants.firestore_collection)
          .where("phone",isEqualTo: phone)
          .where("pwd",isEqualTo: this._userPasswordController.text)
          .get();
    }
    if(email.isNotEmpty){
   querySnapshot = await FirebaseFirestore.instance
        .collection(Constants.firestore_collection)
        .where("email",isEqualTo: email)
        .where("pwd",isEqualTo: this._userPasswordController.text)
        .get();
    }
    if(querySnapshot.docs.isNotEmpty){
      querySnapshot.docs.forEach((element) {
        userIdList = List.from(element.get("userIdList"));
        userInfo = UserInfo(
            element.id,
            element.get("name"),
            element.get("phone"),
            element.get("email"),
            element.get("isActive"),
            " ",
            element.get("userType"),
            element.get("isDeactivate"),
            element.get('url'),
            List.from(element.get("userIdList")));
        if(userInfo.isDeactivate){
          Utils.dismissDialog(context);
          Utils.errorDialog(context, "Your account was deactivated!");
        }else if(userInfo.isActive){
          Utils.dismissDialog(context);
          Utils.errorDialog(context, "Your account was already login \n on another device!");
        }else{
          setUser();
          setUserToSharedPreference();
          updateFireStoreData();
        }
      });
    }else{
      Utils.dismissDialog(context);
      Utils.errorDialog(context, "Incorrect Email or Password!");
    }

  }
  void setUserToSharedPreference() {
    basicInfo.setUserInfo(userInfo).then((value){
    });
  }

  void updateFireStoreData() {
    FirebaseFirestore.instance
        .collection(
        Constants.firestore_collection)
        .doc(userInfo.id)
        .update({
      "isActive": true,
    }).then((_) {
      Utils.dismissDialog(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
          "home", (Route<dynamic> route) => false);
    });
  }

  void setUser() async{
    for(int i = 0 ; i < userIdList.length ; i ++){
      var document =  FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(userIdList[i].trim()).get();
      document.then((value) => {
        model.insertUser(context,UserData(
          userId: value.id,
          parentId: userInfo.id,
          name: value.get("name"),
          email: value.get("email"),
          phone: value.get("phone"),
          isActive: value.get("isActive") ,
          userType: value.get("userType"),
          isDeactivate: value.get("isDeactivate"),
        ))
      });
    }
  }
}
