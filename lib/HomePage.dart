import 'dart:ui';

import 'package:day_by_day_app/Item%20Details.dart';
import 'package:day_by_day_app/ViewModels/Day_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Database/DatabaseHandler.dart';
import 'Models/DayItemModel.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SchedulingPage.dart';

class homepage extends StatefulWidget {
  DateTime Day;
  homepage(this.Day);

  @override
  _homepageState createState() => _homepageState(Day);
}

class _homepageState extends State<homepage> {
  late DatabaseHandler handler;
  List<dayitem>Today = [];
  DateTime Day;
  _homepageState(this.Day);

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headline1 = Theme.of(context).textTheme.headline4!;
    var screensize=MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton:FloatingActionButton(
          onPressed: () {
            pushNewScreen(context, screen: schedulingPage(Day),withNavBar: true,pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          child: Icon(
            Icons.add
          ),
        ) ,
        backgroundColor: Color(0xFF101820),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(Day.day==DateTime.now().day?"Today":"${Day.toString().split(" ")[0]}"),
          titleSpacing: 2.0,
          leading: Icon(Icons.home_outlined),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            setState(() {

            });
           return null;
          },
          child: FutureBuilder(
            future: retrieveDays(),
            builder: (BuildContext context,
                AsyncSnapshot<List<dayitem>> snapshot) {
              if (!snapshot.hasData) {
                return SpinKitCircle(
                    color: Colors.white,
                    size: 100.0
                );
              }
              else {
                if (snapshot.data!.isNotEmpty) {
                  Today.clear();
                   for (dayitem item in snapshot.data!) {
                    if (item.day == DateTime.now().day.toString() && Day.day.toString()== DateTime.now().day.toString()){
                    if(!timeout(item.id,TimeOfDay(hour: int.parse(item.end_time.split(":")[0]), minute: int.parse(item.end_time.split(":")[1].split("")[0])))) {
                      Today.add(item);
                      print(item.title);
                    }
                 }
                    else
                      {
                        if (item.day == Day.day.toString()){
                            Today.add(item);
                            print(item.title);
                        }
                      }
                    Today.sort((a, b) => int.parse(a.start_time.split(":")[0]).compareTo(int.parse(b.start_time.split(":")[0])));
                 }
                }
                return Today.isEmpty ? Padding(
                  padding: EdgeInsets.only(top: screensize.height*0.2),
                  child: Center(
                    child: Container(
                        child: Column(
                            children: [
                              Text("Day ${Day.day}",style:GoogleFonts.questrial(textStyle: headline1,
                            color: Color(0xFFF2AA4C),
                            fontSize: 31.0,
                            fontWeight: FontWeight.w600
                            ,letterSpacing: 1.2)),
                              Icon(Icons.calendar_today_outlined,
                                  color: Color(0xFFF2AA4C), size: 150),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                height: 60,
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0)
                                      ,
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(onPressed: () {
                                  pushNewScreen(context, screen: schedulingPage(Day),withNavBar: true,pageTransitionAnimation: PageTransitionAnimation.cupertino);
                                },
                                  child: Center(
                                      child:
                                      Text("Start Scheduling", style: TextStyle(
                                          color: Color(0xFF101820), fontSize: 20),
                                      )
                                  )
                                  , style: TextButton.styleFrom(
                                    primary: Colors.white,
                                  ),),
                              )
                            ]
                        )
                    ),
                  ),
                ) :
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListView.builder(
                        itemCount: Today.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                      return card(Today[index], screensize);
                        }
                      ),
                    );
              }
            },
          ),
        )
    );
  }

  GestureDetector card(dayitem item,Size screen)
  {
    return GestureDetector(
      onTap: ()
      {
        pushNewScreen(context, screen: itemdetails(item),withNavBar: true,pageTransitionAnimation: PageTransitionAnimation.cupertino);
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
                    tag: item.img
                    ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0)
                      ,
                      child: Image(image: AssetImage(item.img)
                        ,height:200.0 ,
                        width: screen.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.1,
                    bottom: 0.5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 220.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0)
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(item.title,style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600
                              ,letterSpacing: 1.2)),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time,size: 10.0,),
                              SizedBox(width: 5.0,),
                              Text(item.start_time,style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600
                                  ,letterSpacing: 1.2)),
                              SizedBox(width: 10.0,),
                              Text(item.end_time,style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600
                                  ,letterSpacing: 1.2)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(top:2.0 ,
                      right: 2.0,
                      child:
                      IconButton(icon: Icon(CupertinoIcons.clear,color: Colors.black,), onPressed: () {
                        DatabaseHandler().deleteDayItem(item.id);
                      },
                      )
                  )
                ],
              ),
            ),
    );
  }
  bool timeout(id,t)
  {int nowSec;
    print("time "+t.hour.toString()+":"+t.minute.toString());
    String n =DateFormat.jm().format(DateTime.now());
    print("today "+n.split(":")[0]+":"+n.split(":")[1]);
    if(n.split(":")[0]=="12"&&n.split(":")[1].split(" ")[1]=="AM")
      {
        nowSec=(0*60+int.parse(n.split(":")[1].split(" ")[0])) * 60;
      }
    else {
       nowSec = (int.parse(n.split(":")[0]) * 60 +
          int.parse(n.split(":")[1].split(" ")[0])) * 60;
    }
    int veiSec = (t.hour * 60 + t.minute) * 60;
    int dif = veiSec - nowSec;
    if(dif.isNegative)
      {
        DatabaseHandler().deleteDayItem(id);
      }
    print("isneg "+dif.isNegative.toString());
    return dif.isNegative;
  }
}