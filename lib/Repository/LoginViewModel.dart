import 'package:flutter/cupertino.dart';
import 'package:lucky/Data/Database/database.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier{
  late UserDao  userDao;

  Future<void> insertUser(BuildContext context, UserData userData) async{
    userDao = Provider.of<UserDao>(context,listen: false);
    var userdata = await userDao.getUserByUserId(userData.userId);
    if(userdata.userId.isEmpty){
      var result = await userDao.insertUser(userData);
    }
  }

}