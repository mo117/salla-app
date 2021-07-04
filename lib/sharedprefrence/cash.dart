import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
 static  SharedPreferences sharedPreferences ;
 static init() async{
   sharedPreferences = await SharedPreferences.getInstance();

 }

 static dynamic getdata({ String key}){
   return sharedPreferences.get(key);
 }

  static Future<bool> savedata({ String key ,dynamic value})async{
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);

  }

 static Future<bool> removedata({@required String key})async{
  return await sharedPreferences.remove(key);
  }

}