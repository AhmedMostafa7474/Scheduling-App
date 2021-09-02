import 'dart:ui';

import 'package:day_by_day_app/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class calenderpage extends StatefulWidget {
  @override
  _calenderpageState createState() => _calenderpageState();
}

class _calenderpageState extends State<calenderpage> {
  @override
  Widget build(BuildContext context) {
    var screen=MediaQuery.of(context).size;
    var _selectedDay;
    var _focusedDay;
    CalendarFormat _calendarFormat =CalendarFormat.month;
    return Scaffold(
      backgroundColor: Color(0xFF101820),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Calendar"),
        titleSpacing: 2.0,
        leading: Icon(Icons.home_outlined),
      )
        ,
      body: Container(
        height: screen.height*3.5,
        color: Colors.white,
        child: TableCalendar(
          firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 31),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
              print("Selected Day = "+ selectedDay.day.toString());
            });
            pushNewScreen(context, screen: homepage(selectedDay),withNavBar: true,pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },

        ),
      )
    );
  }
  GestureDetector card(Size screen)
  {
    return GestureDetector(
      onTap: ()
      {
        //Get.to(schedulingpage2(item),arguments: item,);
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
              tag: "assets/back.jpg"
              ,
              child:
              Container(
              height:200.0 ,
              width: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: Text(DateTime.now().toString().split(" ")[0],
                        style: GoogleFonts.questrial(
                            color: Color(0xFFF2AA4C),fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
