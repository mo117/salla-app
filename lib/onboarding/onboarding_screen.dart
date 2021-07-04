
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bbbb/log_in/log_in.dart';
import 'package:bbbb/shared_components/component.dart';
import 'package:bbbb/sharedprefrence/cash.dart';

class BoardingModel {
   String image;
   String title;
   String body;

  BoardingModel({ this.body,  this.image,  this.title});
}

List<BoardingModel> boarding = [
  BoardingModel(
      body: "on board 1 body",
      image: 'assets/images/onbourd_1.png',
      title: "on board 1 title"),
  BoardingModel(
      body: "on board 2 body",
      image: 'assets/images/onbourd_1.png',
      title: "on board 2 title"),
  BoardingModel(
      body: "on board 3 body",
      image: 'assets/images/onbourd_1.png',
      title: "on board 3 title"),
];

 bool isLaste = true;


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();
  void submit() async{
    CashHelper.savedata(key: "onBoarding", value: true).then((value){
      if(value){
        navigatRemove(context, ShopLoginScreen());
      }
    });
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: (){
              submit();
            }, child: Text("SKIP"))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1){
                     setState(() {
                       isLaste = true;
                     });
                    }else{
                      setState(() {
                        isLaste = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  new DotsIndicator(
                    dotsCount: boarding.length,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLaste == true){
                        submit();
                      }else{
                        boardController.nextPage(duration: Duration(
                          milliseconds: 750,
                        ), curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage("${model.image}"),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text("${model.title}", style: TextStyle(fontSize: 24)),
        SizedBox(
          height: 20,
        ),
        Text("${model.body}", style: TextStyle(fontSize: 14)),
        SizedBox(
          height: 20,
        ),
      ],
    );
