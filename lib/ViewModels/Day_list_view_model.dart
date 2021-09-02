import 'package:day_by_day_app/Database/DatabaseHandler.dart';
import 'package:day_by_day_app/Models/DayItemModel.dart';
import 'package:sqflite/sqflite.dart';

Future<List<dayitem>> retrieveDays() async {
  final Database db = await DatabaseHandler().initializeDB();
  final List<Map<String, Object?>> queryResult = await db.query('Days');
  return queryResult.map((e) => dayitem.fromMap(e)).toList();
}
