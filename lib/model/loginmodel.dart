 class ShopLoginmodel{
  bool status;
  String message;
  Userdata data;

  ShopLoginmodel.fromjson(Map<String , dynamic> json){
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? Userdata.fromjson(json["data"]) : null;
  }


 }

 class Userdata{

int id;
String name;
 String email;
 String phone;
 String token;
 String imgae;
 int points;
 int credit;

  Userdata.fromjson(Map<String , dynamic> json){
    id = json["id"];
    name= json["name"];
    email = json["email"];
    phone = json["phone"];
    token = json["token"];
    imgae = json["image"];
    credit = json["credit"];
    points= json["points"];

  }

 }