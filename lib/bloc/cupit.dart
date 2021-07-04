import 'package:bbbb/model/categorymodel.dart';
import 'package:bbbb/model/favouritsmodel.dart';
import 'package:bbbb/model/get_favourits_model.dart';
import 'package:bbbb/model/settingsmodel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bbbb/Network/dio.dart';
import 'package:bbbb/bloc/states.dart';
import 'package:bbbb/layouts/categories.dart';
import 'package:bbbb/layouts/favourets.dart';
import 'package:bbbb/layouts/products.dart';
import 'package:bbbb/layouts/settings.dart';
import 'package:bbbb/model/homemodel.dart';
import 'package:bbbb/shared_components/constance.dart';

class AppCupit extends Cubit<Appstates> {
  AppCupit() : super(AppinitialState());

  static AppCupit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> bottomnav = [
    Products(),
    Categories(),
    Favourits(),
    Settings(),
  ];

  void changebotoom(int index) {
    currentindex = index;
    emit(AppBottomnavState());
  }

   Map<int , bool> favourits = {};
   Homemodel homemodel;

  void gethomedata() {
    emit(LoadinghomeState());
    DioHelper.getData(url: "home", token: token).then((value) {
      homemodel = Homemodel.fromJson(value.data);
      // print(homemodel.data.banners);
      homemodel.data.products.forEach((element) {
         favourits.addAll({
           element.id : element.inFavorites
         });
      });
      print(favourits.toString());

      emit(SucsseshomeState());
    }).catchError((eror) {
      print(eror.toString());
      emit(erorhomeState());
    });
  }

  CategoryModel categoryModel;

  void getCategorydata() {
    emit(LoadingcategoryState());
    DioHelper.getData(url: "categories").then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel.data);
      emit(SucssescategoryState());
    }).catchError((eror) {
      print(eror.toString());
      emit(erorcategoryState());
    });
  }

  Favouritmodel favouritmodel;
  void changeFavorites(int productId) {
    favourits[productId] = !favourits[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: "favorites",
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favouritmodel = Favouritmodel.fromJson(value.data);
      print(value.data);

      if (!favouritmodel.status) {
        favourits[productId] = !favourits[productId];
      } else {
        getfavourits();
      }

      emit(ShopSuccessChangeFavoritesState(favouritmodel));
    }).catchError((error) {
      favourits[productId] = !favourits[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  Getfavourite getFavourite;
  void getfavourits(){
    DioHelper.getData(url: "favorites",  token: token).then((value) {
    getFavourite = Getfavourite.fromJson(value.data);

emit(ShopSuccessGetFavoritesState());
    }).catchError((eror){
      emit(ShoperorGetFavoritesState());
    });
  }
  Getprofile getprofile;

  void getprofilee(){
    emit(ShopLoadingGetprofileState());
    DioHelper.getData(url: "profile",  token: token).then((value) {
      getprofile =   Getprofile.fromJson(value.data);
      print('name ======>${getprofile.data.name.toString()}');
      emit(ShopSuccessGetprofileState(getprofile));
    }).catchError((error){
      print( 'Error=>>>>>>>${error.toString()}');
      emit(ShoperorGetprofileState());
    });
  }



}