import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bbbb/layouts/shopHome.dart';
import 'package:bbbb/log_in/cupit.dart';
import 'package:bbbb/log_in/states.dart';
import 'package:bbbb/register/register.dart';
import 'package:bbbb/shared_components/component.dart';
import 'package:bbbb/sharedprefrence/cash.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailcontroler = TextEditingController();
  var passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => Logincupit(),
      child: BlocConsumer<Logincupit, LoginStates>(
        listener: (context, state) {
          if (state is Loginsuccessstate) {
            if (state.loginmodel.status) {
              print(state.loginmodel.data.token);
              print(state.loginmodel.message);
              CashHelper.savedata(key: "token", value: state.loginmodel.data.token).then((value){
                navigatRemove(context, ShopHome());
              });

              Fluttertoast.showToast(
                  msg: state.loginmodel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              print(state.loginmodel.message);
              Fluttertoast.showToast(
                  msg: state.loginmodel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your email";
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
                          onFieldSubmitted: (value) {
                            if (formkey.currentState.validate()) {
                              Logincupit.get(context).userLogin(
                                  email: emailcontroler.text,
                                  password: passwordcontroler.text);
                            }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your password";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordcontroler,
                          decoration: InputDecoration(
                              prefix: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility_outlined),
                                onPressed: () {},
                              ),
                              labelText: "password",
                              border: OutlineInputBorder(
                                gapPadding: 6,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        if (state is Loginloadingstate)
                          Center(child: CircularProgressIndicator()),
                        Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              if (formkey.currentState.validate()) {
                                Logincupit.get(context).userLogin(
                                    email: emailcontroler.text,
                                    password: passwordcontroler.text);
                              }
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have ana account?"),
                            TextButton(
                                onPressed: () {
                                  navigat(context, RegisterScreen());
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 15),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
