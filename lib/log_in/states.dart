import 'package:bbbb/model/loginmodel.dart';

abstract class LoginStates{}
class LoginInitialstate extends LoginStates{}
class Loginsuccessstate extends LoginStates{
  ShopLoginmodel loginmodel;
 Loginsuccessstate(this.loginmodel);
}
class Loginerorstate extends LoginStates{
  final String eror;
 Loginerorstate(this.eror);
}
class Loginloadingstate extends LoginStates{}