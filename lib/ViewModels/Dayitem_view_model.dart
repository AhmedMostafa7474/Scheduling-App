import 'package:day_by_day_app/Models/DayItemModel.dart';

class dayItemViewModel
{
  final dayitem dayitemm;
  dayItemViewModel({required this.dayitemm});

  String getTitle()
  {
    return dayitemm.title;
  }
  String getstart_time()
  {
    return dayitemm.start_time;
  }
  String getend_time()
  {
    return dayitemm.end_time;
  }
  String getday()
  {
    return dayitemm.day;
  }
  String getimg()
  {
    return dayitemm.img;
  }
  String getnote()
  {
    return dayitemm.note;
  }
}