import 'package:bbbb/bloc/cupit.dart';
import 'package:bbbb/bloc/states.dart';
import 'package:bbbb/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit , Appstates>(
      listener: (context , state){},
      builder: (context , state){
        return ListView.separated(
        itemBuilder: (context, index)=> builditem(AppCupit.get(context).categoryModel.data.data[index]),
        separatorBuilder: (context , index) => SizedBox(width: 10,),
        itemCount:AppCupit.get(context).categoryModel.data.data.length
        );
      },
    );
  }
}

Widget builditem(DataModel model) =>Padding(
  padding: EdgeInsets.all(20),
  child: Row(
    children: [
      Image(
          height: 120,
          width: 120,
          image: NetworkImage( model.image)
      ),
      SizedBox(width: 20,),
      Text(model.name, style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 20),),
      Spacer(),
      Icon(
          Icons.arrow_forward_ios
      )
    ],
  ),
);
