
class dayitem
{
  String id;
  String title;
  String start_time;
  String end_time;
  String day;
  String img;
  String note="";

  dayitem(this.id,this.title, this.start_time, this.end_time,this.day, this.img);

  dayitem.fromMap(Map<String,dynamic> res)
  :     id=res["id"],
        title=res["title"],
        start_time=res["start_time"],
        end_time=res["end_time"],
        day=res["day"],
        img=res["img"],
        note=res["note"];

  Map<String, Object?> toMap() {
    return {'id':id,'title':title,'start_time': start_time, 'end_time': end_time,'day':day, 'img': img,'note':note};
  }
}