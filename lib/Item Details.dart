import 'package:day_by_day_app/Database/DatabaseHandler.dart';
import 'package:day_by_day_app/HomePage.dart';
import 'package:day_by_day_app/Models/DayItemModel.dart';
import 'package:day_by_day_app/NavgScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class itemdetails extends StatefulWidget {
  dayitem item;
  itemdetails(this.item);

  @override
  _itemdetailsState createState() => _itemdetailsState(item);
}

class _itemdetailsState extends State<itemdetails> {
  dayitem item;

  _itemdetailsState(this.item);

  @override
  Widget build(BuildContext context) {
    final TextStyle headline1 = Theme.of(context).textTheme.headline4!;
    final TextStyle headline2 = Theme.of(context).textTheme.headline1!;
    late String note;
      note=item.note;
    var screensize=MediaQuery.of(context).size;
    var textcontroller=TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF2AA4C),
        child: Icon(CupertinoIcons.add),
        onPressed: () {
          Get.bottomSheet(
            Container(
              height: 170,
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                children: [
                  TextField(
                    style:GoogleFonts.questrial(textStyle: headline1,
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600
                  ,letterSpacing: 1),
                  decoration: InputDecoration(
                    labelText: "Description"
                  ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller:textcontroller,
                  ),
                  SizedBox(height: 12.0,),
                  TextButton(onPressed:()async{
                    await DatabaseHandler().updateDayItem(textcontroller.text, item.id);
                    setState(() {
                      note=textcontroller.text;
                      print("Note :"+note);
                    });
                    Get.back();
                    Get.off(navgscreen());
                  }, child: Text("Add",style: TextStyle(color: Colors.white),)
                  ,style: TextButton.styleFrom(
                      primary:Color(0xFFF2AA4C)
                          ,backgroundColor: Color(0xFFF2AA4C)
                    ),)
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        },

      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          setState(() {

          });
          return null;
        },
        child: Stack(
          children:[
            ListView(),Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: item.img
                  ,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0)
                    ,
                    child: Image(image: AssetImage(item.img)
                      ,height:300.0 ,
                      width: screensize.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  SizedBox(height: 15,),
                  Text(item.title,style: GoogleFonts.questrial(textStyle: headline2,
                  color: Color(0xFFF2AA4C),
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600
                  ,letterSpacing: 1.2)),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.access_time,size: 18.0,),
                  SizedBox(width: 5.0,),
                  Text(item.start_time,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600
                  ,letterSpacing: 1.2)),
                  SizedBox(width: 18.0,),
                  Text(item.end_time,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600
                  ,letterSpacing: 1.2)),
              ],
            ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Note :",style: GoogleFonts.questrial(textStyle: headline1,
                        color: Color(0xFFF2AA4C),
                        fontSize: 31.0,
                        fontWeight: FontWeight.w600
                        ,letterSpacing: 1.2)),
                  ),
                ),
                    Padding(
                     padding: note.isEmpty?const EdgeInsets.only(top: 80.0):const EdgeInsets.only(top: 30.0,left: 20,right: 20),
                     child: Align(
                       alignment: Alignment.bottomCenter,
                       child: Text(note.isEmpty?"You didn't write description yet !":'$note',style: GoogleFonts.questrial(textStyle: headline1,
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                        ,letterSpacing: 1)),
                     ),
                   )
            ]
          ),
        ]
        ),
      ),
    );
  }
}
