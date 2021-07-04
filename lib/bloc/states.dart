import 'package:bbbb/model/favouritsmodel.dart';
import 'package:bbbb/model/settingsmodel.dart';

abstract class Appstates{}
class AppinitialState extends Appstates{}
class AppBottomnavState extends Appstates{}
class LoadinghomeState extends Appstates{}
class LoadingcategoryState extends Appstates{}
class SucsseshomeState extends Appstates{}
class erorhomeState extends Appstates{}
class SucssescategoryState extends Appstates{}
class erorcategoryState extends Appstates{}
class ShopChangeFavoritesState extends Appstates {}
class ShopSuccessChangeFavoritesState extends Appstates
{
  final Favouritmodel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends Appstates {}

class ShopLoadingGetFavoritesState extends Appstates{}

class ShopSuccessGetFavoritesState extends Appstates {}
class ShoperorGetFavoritesState extends Appstates {}
class ShopSuccessGetprofileState extends Appstates {
  final Getprofile getprofile;
  ShopSuccessGetprofileState(this.getprofile);
}
class ShoperorGetprofileState extends Appstates {}
class ShopLoadingGetprofileState extends Appstates{}





