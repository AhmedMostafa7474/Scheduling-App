class Choices
{
  String title;
  List<String> type;
  List<String> typeimg;

  Choices(this.title, this.type, this.typeimg);
}
List<Choices>choices=[
  Choices("Learning", ["Studying","Course","Exam","Reading"], [
      "assets/Learning/studying1.jpg",
    "assets/Learning/course1.jpg",
    "assets/Learning/exam.jpg"
    ,
    "assets/Learning/reading.png"
  ]),
  Choices("Gym",["Chest Day","Shoulders Day","Back Day","Arm Day","Leg Day","Push Day","Pull Day"], [
    "assets/Gym/ChestDay.jpg",
    "assets/Gym/ShoulderDay.jpg",
    "assets/Gym/BackDay.jpg",
    "assets/Gym/ArmDay.jpg",
    "assets/Gym/LegDay.jpg",
    "assets/Gym/PushDay.jpg",
    "assets/Gym/PullDay.jpg"
  ]),
  Choices("Fun Time", ["Hang with friends","Cinema","Movies & Series","Dating","Party","Sport Match"], [
    "assets/Fun_Time/HangFriends.jpg",
    "assets/Fun_Time/Cinema.jpg",
    "assets/Fun_Time/Movies.jpg",
    "assets/Fun_Time/Dating.jpg",
    "assets/Fun_Time/Party.jpg",
    "assets/Fun_Time/Sport.jpg"
  ]),
  Choices("Work", ["Regular Work","Meeting"], [
    "assets/Work/work.jpg",
    "assets/Work/Meeting.jpg"
  ]),
  Choices("Free Time", ["Free Time"], [
    "assets/Freetime/freetime.jpg"
  ]),
];