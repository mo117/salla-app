import 'package:bbbb/bloc/cupit.dart';
import 'package:bbbb/bloc/states.dart';
import 'package:bbbb/model/get_favourits_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favourits extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCupit,Appstates>(
      listener: (context , state){},
      builder: (context , state){
        if(state is ShopLoadingGetFavoritesState|| AppCupit.get(context).getFavourite == null){
          return Center(child: CircularProgressIndicator(),);
        }else
          return ListView.separated(
              itemBuilder:(context , index) =>
              buildFavItem(AppCupit.get(context).getFavourite.data.data[index],context),
              itemCount: AppCupit.get(context).getFavourite.data.data.length,
            separatorBuilder: (context , index)=> Spacer(),
          );
      }
    );
  }
}

Widget buildFavItem(  model, context) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          model.product.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            AppCupit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon: Icon(Icons.favorite,color:  AppCupit
                              .get(context).favourits[model.product.id]?Colors.red:Colors.grey,)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


