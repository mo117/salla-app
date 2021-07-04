import 'package:bbbb/bloc/cupit.dart';
import 'package:bbbb/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget{
  var emailcontroler = TextEditingController();
  var namecontroler = TextEditingController();
  var phonecontroler = TextEditingController();
  var Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit,Appstates>(
        listener: (context ,state){

          if(state is ShopLoadingGetprofileState) return Center(child: CircularProgressIndicator());
          if (AppCupit.get(context).getprofile.data == null)
          return Center(child: CircularProgressIndicator());
        },
        builder: (context , state){
          if( AppCupit.get(context).getprofile == null  ){
            return Center(child: CircularProgressIndicator(),);
          }else{
            var model = AppCupit.get(context);
            namecontroler.text =  model.getprofile.data.name;
            emailcontroler.text = model.getprofile.data.email;
            phonecontroler.text = model.getprofile.data.phone;
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: Formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your name";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: namecontroler,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.person),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                gapPadding: 6,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your EMail";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroler,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.email_outlined),
                              labelText: "Email Adress",
                              border: OutlineInputBorder(
                                gapPadding: 6,
                              )
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your Phone";
                            }
                          },
                          keyboardType: TextInputType.phone,
                          controller: phonecontroler,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.phone),
                              labelText: "Phone Numper",
                              border: OutlineInputBorder(
                                gapPadding: 6,
                              )
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      });
  }
}