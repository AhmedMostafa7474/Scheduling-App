import 'dart:ui';

import 'package:day_by_day_app/HomePage.dart';
import 'package:day_by_day_app/NavgScreen.dart';
import 'package:day_by_day_app/UserStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class welcomescreen extends StatefulWidget {
  @override
  _welcomescreenState createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    var screensize=MediaQuery.of(context).size;
    final TextStyle headline1 = Theme.of(context).textTheme.headline1!;
    return Stack(
      children: [
        Container(
          height:screensize.height,
          width: screensize.width,
          decoration:  BoxDecoration(
            color: Color(0xFF101820),
          ),
        )
        ,
        Padding(
          padding: EdgeInsets.only(top: screensize.height*0.3),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/Logo.png",color:Color(0xFFF2AA4C) ,),
                ),
                SizedBox(height: 12.0,),
                Text("Welcome",style: GoogleFonts.questrial(textStyle: headline1,color:Color(0xFFF2AA4C),fontSize: 40)),
                SizedBox(height: 7.0,),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 5.0,bottom: 5.0),
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),topLeft: Radius.circular(15.0)
                    ,bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0)),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                  ),
                  child: TextButton(onPressed: (){
                    loginStatues().writeStatus(true);
                    Get.off(navgscreen());
                  },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Get Started",style: TextStyle(color: Color(0xFF101820),fontSize: 18),)
                          ,
                          Icon(Icons.arrow_forward_ios_outlined ,color: Color(0xFF101820),)
                        ],
                      )
                  ,style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
