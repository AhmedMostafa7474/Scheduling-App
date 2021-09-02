import 'package:day_by_day_app/Database/DatabaseHandler.dart';
import 'package:day_by_day_app/HomePage.dart';
import 'package:day_by_day_app/Models/DayChoices.dart';
import 'package:day_by_day_app/Models/DayItemModel.dart';
import 'package:day_by_day_app/ViewModels/Day_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class schedulingpage2 extends StatefulWidget {
  Choices item;
  DateTime Day;
  schedulingpage2(this.item, this.Day);

  @override
  _schedulingpage2State createState() => _schedulingpage2State(item,Day);
}

class _schedulingpage2State extends State<schedulingpage2> {
  @override
  var starttime=TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Choices itemm;
  DateTime Dayy;
  _schedulingpage2State(this.itemm, this.Dayy);
  Widget build(BuildContext context) {
    var screen=MediaQuery.of(context).size;
    Choices Listt=itemm;
    return Scaffold(
        backgroundColor: Color(0xFF101820),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Home"),
          titleSpacing: 2.0,
          leading: Icon(Icons.home_outlined),
        ),
        body: ListView.builder(
          itemCount:Listt.type.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return card(Listt.type![index],Listt.typeimg[index], screen);
          },
        )
    );
  }
  InkWell card(String item,String img, Size screen,)
  {
    var selectedstart=TextEditingController();
    var selectedend=TextEditingController();
    return InkWell(
      onTap: ()async
      {
        AlertDialog alert = AlertDialog(
         title: Text(
           "Select Time"
         ),
           backgroundColor: Colors.white,content: Padding(
             padding: EdgeInsets.all(15),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 TextField(
                   keyboardType: TextInputType.datetime,
                   decoration: InputDecoration(labelText: 'Start time'),
                   controller: selectedstart,
                   style: TextStyle(color: Colors.black),
                   onTap: ()
                     async {
                       TimeOfDay initialTime = TimeOfDay.now();
                       TimeOfDay? pickedTime = await showTimePicker(
                         context: context,
                         initialTime: initialTime,
                       );
                       setState(() {
                         selectedstart.text= pickedTime!.format(context);
                       });
                     },
                 ),
                 Divider(
                   color: Colors.grey,
                   height: 5.0,
                 ),
                 TextField(
                   keyboardType: TextInputType.datetime,
                   decoration: InputDecoration(labelText: 'End time'),
                   controller: selectedend,
                   style: TextStyle(color: Colors.black),
                   onTap: ()
                   async {
                     TimeOfDay initialTime = TimeOfDay.now();
                     TimeOfDay? pickedTime = await showTimePicker(
                       context: context,
                       initialTime: initialTime,
                     );
                     setState(() {
                       selectedend.text= pickedTime!.format(context);
                     });
                   },
                 ),
                 SizedBox(
                   height: 15,
                 ),
                 ElevatedButton(onPressed: ()async {
                  dayitem Day=dayitem(Dayy.day.toString()+selectedstart.text, item, selectedstart.text, selectedend.text, Dayy.day.toString(), img);
                  var snapshot=await retrieveDays();
                  if(DatabaseHandler().CheckTime(snapshot, Day,Dayy)) {
                    await DatabaseHandler().insertDay(Day);
                    await flutterLocalNotificationsPlugin.zonedSchedule(
                       int.parse(selectedstart.text.split(":")[0])+int.parse(selectedstart.text.split(":")[1].split(" ")[0])+Dayy.day,
                        Day.title,
                       "Start time :"+ Day.start_time,
                        tz.TZDateTime.from(DateTime(Dayy.year, Dayy.month, Dayy.day, int.parse(selectedstart.text.split(":")[0]), int.parse(selectedstart.text.split(":")[1].split(" ")[0])), tz.local),
                        //tz.TZDateTime.parse(tz.local, selectedstart.text).add(const Duration(seconds: 15)),
                        const NotificationDetails(
                            android: AndroidNotificationDetails('your channel title',
                                'your channel name', 'your channel description')),
                        androidAllowWhileIdle: true,
                        uiLocalNotificationDateInterpretation:
                        UILocalNotificationDateInterpretation.absoluteTime);

                    Get.defaultDialog(
                        title: "Message",
                        backgroundColor: Colors.white,
                        content: Text("Activity Added !"),
                        onConfirm: () {
                          Get.back();
                          Get.back();
                        }
                        ,
                        textConfirm: "Confirm"
                    );
                  }
                  else
                    {
                      Get.defaultDialog(
                          title: "Message",
                          backgroundColor: Colors.white,
                          content: Text("Time Calender Conflict  !"),
                          onConfirm: () {
                            Get.back();
                            Get.back();
                          }
                          ,
                          textConfirm: "Confirm"
                      );
                    }
                 }, child: Text('Submit'))
               ],
             ),
           )
       );
       showDialog(context: context, builder: (BuildContext context) {
         return alert;
       },

       );
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
              tag: img
              ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0)
                ,
                child: Image(image: AssetImage(img)
                  ,height:200.0 ,
                  width: screen.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0.5,
              bottom: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 220.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0)
                        )
                    ),
                    child: Text(item,style: TextStyle(
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
