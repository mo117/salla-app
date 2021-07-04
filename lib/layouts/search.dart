import 'package:flutter/material.dart';

class Search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Search", style: Theme.of(context).textTheme.bodyText1,))
    );


  }
}