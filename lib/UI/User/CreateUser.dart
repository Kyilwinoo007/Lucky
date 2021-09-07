import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:lucky/Repository/UserViewModel.dart';
import 'package:lucky/UI/Widgets/CustomButton.dart';
import 'package:lucky/UI/Widgets/CustomTextInput.dart';
import 'package:lucky/UI/Widgets/LuckyAppBar.dart';
import 'package:lucky/UI/Widgets/Wrapper.dart';
import 'package:lucky/Utils/Utils.dart';
import 'package:lucky/common/serviceLocator.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CreateUser extends StatefulWidget{
  UserData? userData;
  CreateUser(this.userData);
  @override
  State<StatefulWidget> createState() => _CreateUserState();

}

class _CreateUserState extends State<CreateUser> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController _userPasswordController = new TextEditingController();
  final UserViewModel model = serviceLocator<UserViewModel>();


  String userId = "" ;

  Wrapper _emailErrorMesssage = new Wrapper("");
  Wrapper _userPasswordErrMessage = new Wrapper("");
  Wrapper _nameErrMessage = new Wrapper("");
  Wrapper _phoneErrMessage = new Wrapper("");
 late UserInfo userInfo;

  @override
  void initState(){
    if(this.widget.userData != null){
      nameController.text = this.widget.userData!.name;
      phoneController.text = this.widget.userData!.phone;
      emailController.text = this.widget.userData!.email;
    }
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nameInput = CustomTextInput(
      controller: this.nameController,
      errorMessage: _nameErrMessage.value,
      label: "Shop Name:",
      isRequired: true,
      hintText: "Enter Shop Name",
      leadingIcon: Icon(
        LineAwesomeIcons.user,
        size: 25.0,
      ),
    );

    final phNoInput = CustomTextInput(
      inputType: TextInputType.phone,
      controller: this.phoneController,
      errorMessage: _phoneErrMessage.value,
      isRequired: false,
      label: "Phone No.",
      hintText: "eg.09***",
      leadingIcon: Icon(
        LineAwesomeIcons.phone,
        size: 25.0,
      ),
    );
    final emailInput = CustomTextInput(
      controller: this.emailController,
      errorMessage: _emailErrorMesssage.value,
      isRequired: true,
      label: "Email",
      inputType: TextInputType.emailAddress,
      leadingIcon: Icon(
        Icons.email,
        size: 25.0,
      ),
      hintText: 'Enter email',
    );
    Widget passwordInput = CustomPasswordInput(
      errorMessage: this._userPasswordErrMessage.value,
      userPasswordController: this._userPasswordController,
      label: "Password",
      hintText: "Enter Password",
    );

    final submitButton = this.widget.userData != null ? SolidGreenButton(
      title: "Update",
            clickHandler: () async {
              Utils.checkInternetConnection(context).then((value) => {
                    if (!value)
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Utils.showSnackBar()),
                      }
                    else
                      {
                        if (isValid())
                          {
                            Utils.showLoaderDialog(context),
                            UpdateUser(),
                          }
                      }
                  });
            },
          ) :SolidGreenButton(
      title: "Create",
            clickHandler: () async {
              Utils.checkInternetConnection(context).then((value) => {
                    if (!value)
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Utils.showSnackBar()),
                      }
                    else
                      {
                        if (isValid())
                          {
                            Utils.showLoaderDialog(context),
                            createUser(),
                            //get userid
                            //update userid to firebase
                            // save to sharepreference
                          }
                      }
                  });
            },
          );
    final cancelButton = OutlineGreenElevatedButton(
      title: "Cancel",
      clickHandler: () {
        Navigator.of(context).pop();
      },
    );
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

    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: luckyAppbar(
        context: context,
        title: "Create Users",
      ),
      body: orientation == Orientation.landscape
          ? buildLandscapeView(
          name: nameInput,
          phoneNo: phNoInput,
          email: emailInput,
          password:passwordInput,
          submitButton: submitButton,
          cancelButton: cancelButton)
          : buildPortraitView(
          name: nameInput,
          phoneNo: phNoInput,
          email: emailInput,
          password:passwordInput,
          submitButton: submitButton,
          cancelButton: cancelButton),
    );
  }

  buildLandscapeView(
      {required CustomTextInput name,
      required CustomTextInput phoneNo,
      required CustomTextInput email,
      required Widget password,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton}) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: name,
              ),
              Expanded(
                child: phoneNo,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: email,
              ),
              Expanded(
                child: password,
              ),
            ],
          ),
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(child: submitButton),
              SizedBox(
                width: 10,
              ),
              Expanded(child: cancelButton),
            ],
          ),
        )
      ],
    );

  }

  buildPortraitView(
      {required CustomTextInput name,
      required CustomTextInput phoneNo,
      required CustomTextInput email,
      required Widget password,
      required SolidGreenButton submitButton,
      required OutlineGreenElevatedButton cancelButton}) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.72,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            name,
            SizedBox(height: 10,),
            phoneNo,
            SizedBox(height: 10,),
            email,
            SizedBox(height: 10,),
            password,
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: submitButton,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: cancelButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

  bool isValid() {
    bool isNameValid, isEmailValid,isPasswordValid;
    bool isPhoneValid = true;
    String nameErrorMsg = '', emailErrorMsg = '', passwordErrorMsg = '' ,phoneErrorMsg = '';
    if (nameController.text.trim().isNotEmpty) {
      isNameValid = true;
    } else {
      nameErrorMsg = "Required";
      isNameValid = false;
    }
    if(emailController.text.trim().isNotEmpty){
      if(!EmailValidator.validate(emailController.text)){
        emailErrorMsg = "Invalid email !";
        isEmailValid = false;
      }else{
        isEmailValid = true;
      }
    }else{
      emailErrorMsg = "Required";
      isEmailValid = false;
    }
    if(phoneController.text.trim().isNotEmpty){
      if(!Utils.validatePhone(phoneController.text.trim())){
        isPhoneValid = false;
        phoneErrorMsg = "Invalid phone number !";
      }
    }
    if(_userPasswordController.text.trim().isNotEmpty){
      if(_userPasswordController.text.length < 6){
        isPasswordValid = false;
        passwordErrorMsg = "Required at least 6 characters";
      }else{
        isPasswordValid = true;
      }

    }else{
      passwordErrorMsg = "Required";
      isPasswordValid = false;
    }

    setState(() {
      _nameErrMessage.value = nameErrorMsg;
      _emailErrorMesssage.value = emailErrorMsg;
      _userPasswordErrMessage.value = passwordErrorMsg;
      _phoneErrMessage.value = phoneErrorMsg;
    });

    return isNameValid && isEmailValid && isPasswordValid && isPhoneValid;
  }

  void createUser() async{
    model.addUserToFireStore(nameController.text,phoneController.text,emailController.text,_userPasswordController.text);
    QuerySnapshot  querySnapshot = await FirebaseFirestore.instance
        .collection(Constants.firestore_collection)
        .where("email",isEqualTo: emailController.text)
        .where("pwd",isEqualTo: _userPasswordController.text)
        .where("name",isEqualTo: nameController.text)
        .get();
    querySnapshot.docs.forEach((element) {
      userId = element.id;
    });
    model.addUserToDatabase(context, UserData(
        userId: userId,
        parentId: userInfo.id,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text.trim().isNotEmpty ? phoneController.text : "",
        userType: "user",
        isActive: false,
        isDeactivate: false));
    model.updateFireStoreDatabase(userInfo.id);
    Utils.dismissDialog(context);
    Navigator.of(context).pop();
  }

  Future<void> getUserInfo() async {
   UserInfo userInfo = await basicInfo.getUserInfo();
   if(userInfo != null){
     this.userInfo = userInfo;
   }
  }

  void UpdateUser() async{
    await model.updateUserFireStoreDatabase(this.widget.userData,nameController.text,phoneController.text,emailController.text,_userPasswordController.text);
    var result = await  model.updateDatabase(context, UserData(
        id: this.widget.userData!.id,
        userId: this.widget.userData!.userId,
        parentId: this.widget.userData!.parentId,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        userType: this.widget.userData!.userType,
        isActive: this.widget.userData!.isActive,
        isDeactivate: this.widget.userData!.isDeactivate));
    if(result){
      Utils.dismissDialog(context);
      Navigator.of(context).pop();
    }
  }
}