import 'package:bbbb/Network/dio.dart';
import 'package:bbbb/layouts/shopHome.dart';
import 'package:bbbb/log_in/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bbbb/model/loginmodel.dart';

class Logincupit extends Cubit<LoginStates>{
  Logincupit() : super(LoginInitialstate());

  static Logincupit get(context) => BlocProvider.of(context);

   ShopLoginmodel loginmodel;

  void userLogin({String email ,  String password}){
    emit(Loginloadingstate());
    DioHelper.postData(
        url: "login",
        data: {
          "email":email,
          "password":password,
        }
    ).then((value){
      print(value.data);
      loginmodel = ShopLoginmodel.fromjson(value.data);
      print(loginmodel.status);
      print(loginmodel.message);
      emit(Loginsuccessstate(loginmodel));
    }).catchError((eror){
      emit(Loginerorstate(eror.toString()));
    });
  }


}