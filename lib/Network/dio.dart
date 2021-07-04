// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// class Diohelper{
//
//   static  Dio dio;
//
//   static init(){
//     dio = Dio(
//       BaseOptions(
//         baseUrl: "https://student.valuxapps.com/api/",
//         receiveDataWhenStatusError: true,
//         headers: {
//           "Content-Type" : "application/json",
//           "lang": "en"
//         }
//       )
//     );
//   }
//
//   static Future<Response> getdata({ @required String url ,  Map<String , dynamic> query, String token}) async{
//     return await dio.get(
//     url,
//     queryParameters: query,
//     );
//   }
//
//   static Future<Response> postDaata({
//  @required String url,
//   Map<String,dynamic> query,
//   @required  Map<String , dynamic> data,
//     String lang = "en",
//     String token
//
// })async{
//     dio.options.headers = {
//       'lang' : lang,
//       'Authorization' : token??"",
//       "Content-Type" : "application/json",
//
//     };
//     return await dio.post(
//       url,
//       queryParameters: query??null,
//       data: data ,
//
//     );
//   }
//
//
//
// }
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json"}));
  }

  static Future<Response> getData(
      {String url,
        Map<String, dynamic> query,
        lang = "en",
        token = "0"}) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json"
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {@required String url,
        data,
        Map<String, dynamic> query,
        lang = "en",
        token }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json"
    };
    return await dio.post(url, data: data, queryParameters: query);
  }


  static Future<Response> putData(
      {@required String url,
        data,
        Map<String, dynamic> query,
        lang = "en",
        token }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json"
    };
    return await dio.put(url, data: data, queryParameters: query);
  }

}
