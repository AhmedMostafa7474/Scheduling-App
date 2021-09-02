import 'package:day_by_day_app/HomePage.dart';
import 'package:day_by_day_app/NavgScreen.dart';
import 'package:day_by_day_app/WelcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserStatus.dart';
class routepage extends StatefulWidget {
  @override
  _routepageState createState() => _routepageState();
}

class _routepageState extends State<routepage> {
  // late final PushNotificationsManager _pushNotificationsManager;
  Future<bool> checkinlogin()async
  {
    var status= await loginStatues().readStatus();
    return status;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkinlogin(),
        builder: (context,snapshot) {
          if(snapshot.data==true)
          {
            return  navgscreen();
          }
          else{
            return  welcomescreen();
          }
        }
    );
  }
}
