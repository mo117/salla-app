import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bbbb/log_in/log_in.dart';
import 'package:bbbb/sharedprefrence/cash.dart';

void navigat(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigatRemove(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

void signout (context){
  CashHelper.removedata(key: "token").then((value){
    navigatRemove(context, ShopLoginScreen());
  });

  String token = "";
}