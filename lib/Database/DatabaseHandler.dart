import 'package:day_by_day_app/Models/DayItemModel.dart';
import 'package:day_by_day_app/ViewModels/Day_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'scheduler.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Days(id TEXT PRIMARY KEY NOT NULL, title TEXT NOT NULL,start_time TEXT NOT NULL, end_time TEXT NOT NULL, day TEXT NOT NULL, img TEXT,note TEXT)",
        );
      },
      version: 1,
        //onUpgrade: _onUpgrade
    );
  }
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE Days ADD COLUMN note TEXT;");
    }
  }
  Future<int> insertDay(dayitem Dayitem) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('Days', Dayitem.toMap());
    return result;
  }
  Future<void> deleteDayItem(String id) async {
    final db = await initializeDB();
    await db.delete(
      'Days',
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<void> updateDayItem(String text,String id) async {
    final db = await initializeDB();
    await db.rawUpdate('UPDATE Days SET note = ? WHERE id = ?', [text, id]);
  }
  bool CheckTime(List<dayitem>Days,dayitem item,Dayy)
  {
    for(dayitem i in Days)
      {
        if(i.start_time.split(" ")[1]==item.start_time.split(" ")[1]) {
          DateFormat dateFormat = new DateFormat.Hm();
          DateTime now = Dayy;
          DateTime open = dateFormat.parse(i.start_time.split(" ")[0]);
          open = new DateTime(
              now.year, now.month, int.parse(i.day), open.hour, open.minute);
          DateTime close = dateFormat.parse(i.end_time.split(" ")[0]);
          close = new DateTime(
              now.year, now.month, int.parse(i.day), close.hour, close.minute);
          DateTime newitemstart = dateFormat.parse(
              item.start_time.split(" ")[0]);
          newitemstart = new DateTime(
            now.year, now.month, now.day, newitemstart.hour,
            newitemstart.minute,);
          DateTime newitemend = dateFormat.parse(item.end_time.split(" ")[0]);
          newitemend = new DateTime(
              now.year, now.month, now.day, newitemend.hour, newitemend.minute);
          print("Start :" + newitemstart.toString());
          print("end :" + newitemend.toString());
          print("Nowstart :" + open.toString());
          print("NowEnd :" + close.toString());
          if ((newitemstart.isAfter(open) && newitemstart.isBefore(close)) ||
              (newitemend.isAfter(open) && newitemend.isBefore(close))||(newitemstart.isAfter(newitemend))) {
            return false;
          }
        }
      }
    return true;
  }
}