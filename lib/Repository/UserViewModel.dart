import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucky/Constants/Constants.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:lucky/Data/SharedPref/basicInfo.dart';
import 'package:lucky/Data/UserInfo.dart';
import 'package:provider/provider.dart';

class UserViewModel extends ChangeNotifier{
  late UserDao userDao;
  
  // void getUser(List<String> userIdList) async {
  //
  //   // List<UserInfo> userInfoList  = [];
  //   if(userIdList.length > 0){
  //     for(int i = 0 ; i < userIdList.length ; i ++){
  //       var document =  FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(userIdList[i].trim()).get();
  //       UserInfo info;
  //       document.then((value) =>{
  //         info = UserInfo(value.id,
  //       value. get ("name"), value. get ("phone"),
  //       value.get("email"), value.get("isActive"), " ", value.get("userType"), value.get("isDeactivate"), []),
  //         // userInfoList.add(info),
  //         this.loading = false,
  //         this.userInfoList.add(info),
  //       notifyListeners(),
  //       });
  //     }
  //
  //   }
  // }

  void deleteUsers(BuildContext context,UserData user) async{
    userDao = Provider.of<UserDao>(context,listen: false);
    await FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(user.userId).delete();
   await userDao.deleteUser(user);
    List<UserData> result = await userDao.getAllUser;
    List<String> userIdList = [];
    result.forEach((element) {
      userIdList.add(element.userId);
    });
    if(user.parentId.isNotEmpty){
    await  FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(user.parentId).update({
        'userIdList': userIdList,
      });
    }

  }

  Stream<List<UserData>> getAllUser(BuildContext context) {
    userDao = Provider.of<UserDao>(context,listen: false);
    return userDao.watchAllModes;
  }

  void addUserToFireStore(String name, String phone,String email, String pwd, String url) async{
    await FirebaseFirestore.instance.collection(Constants.firestore_collection).add(
        {
          'name': name,
          'phone': phone.isNotEmpty ? phone : "",
          'email': email,
          'isActive': false,
          'isDeactivate' : false,
          'pwd':pwd,
          'userType':'user',
          'url':url,
          'userIdList': [],
        }
    );
  }

  void addUserToDatabase(BuildContext context, UserData userData) async{
    userDao = Provider.of<UserDao>(context,listen: false);
   await userDao.insertUser(userData);
  }

  void updateFireStoreDatabase(String parentId) async{
    List<UserData> lstUserData = await userDao.getAllUser;
    List<String> userIdList = [];
    lstUserData.forEach((element) {
      userIdList.add(element.userId);
    });
   await FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(parentId).update({
      'userIdList': userIdList,
    });
  }

  void deactivateUser(BuildContext context, UserData user, isDeactivate) async{
    userDao = Provider.of<UserDao>(context,listen: false);
    await userDao.updateUser(UserData(
        id: user.id,
        userId: user.userId,
        parentId: user.parentId,
        name: user.name,
        email: user.email,
        phone: user.phone,
        userType: user.userType,
        isActive: user.isActive,
        isDeactivate: isDeactivate));
    await FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(user.userId).update({
      'isDeactivate':isDeactivate
    });
  }

  Future<bool> updateDatabase(BuildContext context, UserData userData) async{
    userDao = Provider.of<UserDao>(context,listen: false);
   var result = await userDao.updateUser(userData);
   return result;
  }

  updateUserFireStoreDatabase(UserData? userData, String name, String phone, String email, String pwd) async{

    if(pwd.isNotEmpty){
      await FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(userData!.userId).update(
          {
            'name': name,
            'phone': phone.isNotEmpty ? phone : "",
            'email': email,
            'pwd':pwd,

          });
    }else{
      await FirebaseFirestore.instance.collection(Constants.firestore_collection).doc(userData!.userId).update(
          {
            'name': name,
            'phone': phone.isNotEmpty ? phone : "",
            'email': email,
          });
    }

  }

  
}