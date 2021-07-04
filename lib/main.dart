import 'package:flutter/material.dart';
import 'package:bbbb/Network/dio.dart';
import 'package:bbbb/bloc/observer.dart';
import 'package:bbbb/layouts/shopHome.dart';
import 'package:bbbb/log_in/log_in.dart';
import 'package:bbbb/sharedprefrence/cash.dart';
import 'package:bbbb/styles/theme.dart';
import 'bloc/cupit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/states.dart';
import 'package:bbbb/onboarding/onboarding_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool onBoarding = CashHelper.getdata(key: "onBoarding");
  String token = CashHelper.getdata(key: "token");
  print(onBoarding);
  if(onBoarding != null){
    if(token != null){
      widget = ShopHome();
    }else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = OnboardingScreen();
  }
  print(token);
  runApp(MyApp(
    staetwidget: widget,
  ));
}
class MyApp extends StatelessWidget {
  Widget staetwidget;
  MyApp({this.staetwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
    BlocProvider<AppCupit>(
    create: (BuildContext context) => AppCupit()..gethomedata()..getCategorydata()..getfavourits()..getprofilee(),
    )
      ],
        child: BlocConsumer<AppCupit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              // darkTheme: darkTheme,
              home:  staetwidget
          );
        }
    ),
    );
  }
}
