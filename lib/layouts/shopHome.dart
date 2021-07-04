import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bbbb/bloc/cupit.dart';
import 'package:bbbb/bloc/states.dart';
import 'package:bbbb/layouts/search.dart';
import 'package:bbbb/shared_components/component.dart';

class ShopHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit ,Appstates>(
      listener: (context , state) {},
      builder: (context , state){
       return Scaffold(appBar: AppBar(title: Text("salla"),
       actions: [
         IconButton(onPressed: (){
           navigat(context, Search());
         }, icon: Icon(Icons.search))
       ],
       ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCupit.get(context).currentindex,
            onTap: (index){
              AppCupit.get(context).changebotoom(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category) , label: "category"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: "favourits"),
              BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings"),
            ],
          ),
          body: AppCupit.get(context).bottomnav[AppCupit.get(context).currentindex],
          );
      },
    );
  }

}