import 'package:day_by_day_app/Models/DayChoices.dart';
import 'package:day_by_day_app/SchedulingPage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'helpers/Widgets.dart';

class schedulingPage extends StatefulWidget {
  DateTime Day;
  schedulingPage(this.Day);

  @override
  _schedulingPageState createState() => _schedulingPageState(Day);
}

class _schedulingPageState extends State<schedulingPage> {
  DateTime Day;
  _schedulingPageState(this.Day);

  @override
  Widget build(BuildContext context) {
    var screen=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF101820),
    appBar: AppBar(
    backgroundColor: Colors.black,
    title: Text("Home"),
    titleSpacing: 2.0,
    leading: Icon(Icons.home_outlined),
    ),
    body: ListView.builder(
      itemCount:choices.length ,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return card(choices[index], screen);
      },

    )
    );
  }
  GestureDetector card(Choices item,Size screen)
  {
    return GestureDetector(
      onTap: ()
      {
        pushNewScreen(context, screen: schedulingpage2(item,Day),withNavBar: true,pageTransitionAnimation: PageTransitionAnimation.cupertino);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0)
              )
            ]
        ),
        child: Stack(
          children:<Widget> [
            Hero(
              tag: item.typeimg[0]
              ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0)
                ,
                child: Image(image: AssetImage(item.typeimg[0])
                  ,height:200.0 ,
                  width: screen.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 1.0,
              bottom: 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0)
                      )
                    ),
                    child: Text(item.title,style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600
                        ,letterSpacing: 1.2)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}