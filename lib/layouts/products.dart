import 'package:bbbb/model/categorymodel.dart';
import 'package:bbbb/model/homemodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bbbb/bloc/cupit.dart';
import 'package:bbbb/bloc/states.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var homemodel = AppCupit.get(context).homemodel;
          var categ = AppCupit.get(context).categoryModel;
          if (AppCupit.get(context).homemodel == null ||
              AppCupit.get(context).categoryModel == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: homemodel.data.banners
                          .map((e) => Image(
                                image: NetworkImage('${e.image}'),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                      options: CarouselOptions(
                          height: 250,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          viewportFraction: 1,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "categories",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        Container(
                          height: 100,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  buildercategories(categ.data.data[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 1,
                                  ),
                              itemCount: categ.data.data.length),
                        ),
                        Text(
                          "New products",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.white,
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: 1 / 1.6,
                            children: List.generate(
                                homemodel.data.products.length,
                                (index) =>buildGridProduct(homemodel.data.products[index] , context )
    )))
                  )]);
          }}
    );}
  }
Widget buildGridProduct( Product model , context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image),
              // fit: BoxFit.fitHeight,
              width: 120,
              height: 150,
            ),
            if (model.discount != 0)
              Container(
                  alignment: Alignment.bottomLeft,
                  color: Colors.red.withOpacity(.5),
                  width: 50,
                  padding: EdgeInsets.all(2),
                  child: Text("DISCOUNT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 8,
                          fontFamily: "Quicksand Bold",
                          color: Colors.white)))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(model.name,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Quicksand Bold",
                      height: 1.3),
                  maxLines: 2),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${model.price.round()}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Quicksand Bold",
                          height: 1.5,
                          color: Colors.black)),
                  SizedBox(width: 9),
                  if (model.discount != 0)
                    Text("${model.oldPrice.round()}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Quicksand Bold",
                            height: 1.5,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        AppCupit.get(context).changeFavorites(model.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: AppCupit.get(context).favourits[model.id]
                            ? Colors.red
                            : Colors.grey,
                      ))
                ],
              )
            ],
          ),
        ),
      ]),
);
Widget buildercategories(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
