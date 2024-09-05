import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdkey = 'USERKEY';
  static String userNamekey = 'USERNAMEKEY';
  static String userEmailkey = 'USEREMAILKEY';
  static String userImagekey = 'USERIMAGEKEY';

  Future<bool>saveUserId(String getuserId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey,getuserId);
  }

  Future<bool>saveUserName(String getuserName)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey,getuserName);
  }

  Future<bool>saveUserEmail(String getuserEmail)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey,getuserEmail);
  }

  Future<bool>saveUserImage(String getuserImage)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImagekey,getuserImage);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }

  Future<String?> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }

  Future<String?> getUserEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }

  Future<String?> getUserImage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImagekey);
  }
}